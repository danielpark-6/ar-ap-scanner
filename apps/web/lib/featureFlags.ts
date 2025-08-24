export const isStripeEnabled = () => process.env.ENABLE_STRIPE === "true";
export const isWebhooksEnabled = () => process.env.ENABLE_WEBHOOKS === "true";
export const isDatabaseEnabled = () => process.env.ENABLE_DATABASE !== "false";