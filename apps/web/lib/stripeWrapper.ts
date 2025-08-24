// apps/web/lib/stripeWrapper.ts
import { isStripeEnabled, isWebhooksEnabled } from "./featureFlags";

async function getStripeInstance() {
  if (!isStripeEnabled()) return null;
  // dynamic import so dev & deploy do not require stripe until enabled
  const StripePkg = (await import("stripe")).default;
  // cache on global to avoid re-instantiation
  if (!(globalThis as any).__stripeInstance) {
    (globalThis as any).__stripeInstance = new StripePkg(process.env.STRIPE_SECRET_KEY!, { apiVersion: "2024-11-15" });
  }
  return (globalThis as any).__stripeInstance;
}

export const stripe = {
  async createCustomer(opts: { email: string }) {
    if (!isStripeEnabled()) return { id: `cust_mock_${Date.now()}`, email: opts.email };
    const s = await getStripeInstance();
    return s.customers.create(opts);
  },

  async createCheckoutSession(opts: any) {
    if (!isStripeEnabled()) return { url: `https://mock-checkout.local/session/${Date.now()}` };
    const s = await getStripeInstance();
    return s.checkout.sessions.create(opts);
  },

  async retrieveSubscription(subId: string) {
    if (!isStripeEnabled()) return { id: subId, status: "active", items: { data: [{ price: { unit_amount: 1000, recurring: { interval: "month" } } }] } };
    const s = await getStripeInstance();
    return s.subscriptions.retrieve(subId);
  },

  // keep this synchronous for webhook handlers by using require() only when needed
  constructEvent(buf: string, sig: string | undefined, webhookSecret: string | undefined) {
    if (!isStripeEnabled() || !isWebhooksEnabled()) {
      return { type: "mock.event", data: { object: {} } };
    }
    // require here to keep top-level import-free
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    const StripePkg = require("stripe");
    const s = new StripePkg(process.env.STRIPE_SECRET_KEY!, { apiVersion: "2024-11-15" });
    return s.webhooks.constructEvent(buf, sig, webhookSecret);
  }
};