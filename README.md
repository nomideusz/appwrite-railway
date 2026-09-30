# Deploy and Host Appwrite on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/appwrite-1?utm_medium=integration&utm_source=button&utm_campaign=appwrite)

[Appwrite](https://appwrite.io/) is an open-source backend-as-a-service: authentication (email, OAuth, magic links, teams), databases, file storage with on-the-fly image transforms, realtime subscriptions, and messaging, all behind one API with SDKs for web, mobile, and server. This template runs **Appwrite 2.3**, the current major version, with the new Console.

## About Hosting Appwrite

Appwrite 2 runs on PostgreSQL by default, keeps usage metrics in ClickHouse, and ships a new Console with a built-in terminal and API explorer. This template follows the upstream default ("combined") layout: the API, the Console, realtime, one worker that serves every queue, and the scheduler, maintenance and interval tasks, plus PostgreSQL, ClickHouse and Redis. A small nginx gateway takes Traefik's place and routes one public domain: `/v1` to the API, `/v1/realtime` to realtime, everything else to the Console. Uploaded files go to a **Railway bucket over S3**, so nothing needs a shared volume. Open your gateway domain once the deploy finishes and create the admin account (the first signup owns the instance).

## Common Use Cases

- Full backend for web and mobile apps: auth, database, storage, and realtime from one endpoint
- Vector search for AI features with VectorsDB (enabled here, on the bundled PostgreSQL)
- Self-hosted alternative to Firebase or Supabase with your data on your own infrastructure

## Dependencies for Appwrite Hosting

- All bundled: PostgreSQL 18, ClickHouse, Redis, and an S3-compatible Railway bucket are provisioned by the template

### Deployment Dependencies

- [Appwrite documentation](https://appwrite.io/docs)
- [Template source on GitHub](https://github.com/nomideusz/appwrite-railway)

### Implementation Details

**Your Appwrite URL is the `gateway` service's domain.** It is the only service with a public domain. Open it and sign up; the first account becomes the instance owner and further signups are closed (invite teammates from the Console). Sign up with email: the Console's GitHub button returns error 412 until you set `_APP_CONSOLE_GITHUB_APP_ID` and `_APP_CONSOLE_GITHUB_SECRET` on the `appwrite` service (GitHub OAuth app callback: `https://<your-domain>/v1/account/sessions/oauth2/callback/github/console`).

- **Email**: set the optional `_APP_SMTP_*` variables on the `appwrite` service (the worker reads them from there). Railway's Hobby plan blocks ports 25, 465 and 587, so use your provider's alternate port: 2525 (Mailgun, SendGrid) or 2587 (Resend).
- **Custom domain**: add it to the `gateway` service, then set the gateway's `PUBLIC_HOST` variable to it. Every service reads the domain from there.
- **Functions and Sites are not available**: Appwrite runs them in Docker containers it starts itself through `docker.sock`, which Railway does not expose. Auth, databases (TablesDB and VectorsDB), storage, realtime, and messaging all work.
- **Memory**: about 2.7 GB at idle across all services, half of it ClickHouse (it feeds the Console's usage charts). Deploy on Hobby or above.

## Why Deploy Appwrite on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Appwrite on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
