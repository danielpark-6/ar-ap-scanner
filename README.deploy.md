Vercel deploy notes
- Repo: danielpark-6/ar-ap-scanner
- Project root: apps/web
- Install: corepack enable && pnpm install
- Build: pnpm --filter ./apps/web build
- Env (Preview): ENABLE_STRIPE=false, ENABLE_WEBHOOKS=false, ENABLE_DATABASE=false, etc.
