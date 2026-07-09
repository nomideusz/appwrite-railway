# Deploy and Host Appwrite on Railway

[Appwrite](https://appwrite.io/) is an open-source backend-as-a-service: authentication (email, OAuth, magic links, teams), databases, file storage with on-the-fly image transforms, realtime subscriptions, and messaging — all behind one API with SDKs for web, mobile, and server.

## About Hosting Appwrite

Appwrite 1.9 is a genuinely multi-service stack — API, console, realtime, MongoDB (primary), PostgreSQL (vectors), Redis, and a fleet of background workers. This template decomposes it into 13 Railway services wired over private networking, replacing the stock Traefik ingress with a small nginx gateway that replicates its routing (`/v1/realtime` → realtime, `/console` → console, everything else → API). MongoDB runs as a single-node replica set on a Railway volume (member on loopback so redeploys never lose the primary), and file storage goes to a **Railway bucket over S3** — no shared-volume juggling. First boot initializes the databases in about a minute; then open your gateway domain and create the admin account (first signup owns the instance).

## Common Use Cases

- Full backend for web/mobile apps: auth, database, storage, and realtime from one endpoint
- Self-hosted alternative to Firebase/Supabase with your data on your infrastructure
- Identity provider for side projects — magic links, OAuth, teams, and sessions out of the box

## Dependencies for Appwrite Hosting

- All bundled: MongoDB 8 (replica set), PostgreSQL, Redis, and an S3-compatible Railway bucket are provisioned by the template

### Deployment Dependencies

- [Appwrite documentation](https://appwrite.io/docs)
- [Template source on GitHub](https://github.com/nomideusz/appwrite-railway)

### Implementation Details

**Your Appwrite URL is the `gateway` service's domain** — it's the only service with a public domain; the `appwrite` API service itself stays private behind it. Open that domain, go to `/console`, and sign up — the first account becomes the instance owner.

Known limitations on Railway:

- **Functions and Sites are not available**: Appwrite's executor spawns Docker containers via `docker.sock`, which Railway does not expose. Auth, databases, storage, realtime, and messaging all work fully.
- Custom domains for projects should be added on the gateway service (Railway handles TLS).
- SMTP is unset by default — configure `_APP_SMTP_*` variables on the `appwrite` and `worker-mails` services to enable email delivery.

## Why Deploy Appwrite on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Appwrite on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
