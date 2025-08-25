RUNBOOK: enable production services
1. Provision DB (Supabase) -> copy DATABASE_URL to Vercel
2. Run prisma migrate deploy from secure machine
3. Add Stripe keys and STRIPE_WEBHOOK_SECRET to Vercel
4. Set ENABLE_DATABASE=true, ENABLE_STRIPE=true, ENABLE_WEBHOOKS=true
5. Smoke test payment and DB writes
