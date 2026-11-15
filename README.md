# Deploy and Host OWASP Juice Shop on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/juice-shop?referralCode=sLjDXb&utm_medium=integration&utm_source=button&utm_campaign=juice-shop)

OWASP Juice Shop is probably the most modern and sophisticated insecure web application. It is a fake online juice store with more than 100 hacking challenges built in, covering the whole OWASP Top Ten and much more: SQL injection, XSS, broken authentication, insecure deserialization, JWT forgery, SSRF, prompt injection against an AI chatbot and others. A score board tracks what you have solved. This template runs the official Juice Shop 20.4.0 image on Railway as one small service, with variables for CTF events and the chatbot challenges.

**Juice Shop is deliberately vulnerable.** Use it for training, workshops and CTFs only. Never put real data, real passwords or real payment details into it, and delete the service when your session is over.

This is a community template, not made or supported by the OWASP Foundation.

## About Hosting OWASP Juice Shop

Open your Railway domain and start hacking. Nothing else is needed: the shop, its SQLite database and all challenges live in one container.

**Find the score board:** it is hidden on purpose. Finding it is the first challenge.

**Progress resets on restart.** Juice Shop rebuilds its database on every boot, by design, so a redeploy or restart starts the shop fresh. Your solved challenges are kept in your browser and restored automatically when you come back, and the score board can export a continue code to restore them by hand.

**Run a CTF:** set `NODE_ENV=ctf`. The shop then shows a flag code each time a challenge is solved, hides hints and turns every challenge on. Set `CTF_KEY` to your own secret and use the same key in [juice-shop-ctf-cli](https://github.com/juice-shop/juice-shop-ctf) to set up CTFd or FBCTF, and point `SOLUTIONS_WEBHOOK` at a URL that should hear about each solve.

**Chatbot challenges:** the shop's AI assistant needs an OpenAI-compatible LLM. Set `LLM_API_URL` (for example `https://openrouter.ai/api/v1`), `LLM_API_KEY` and `LLM_MODEL`. Without them the chatbot stays offline and the rest of the shop works as usual.

## Common Use Cases

- Hands-on web security training and secure coding workshops
- Capture-the-flag events with CTFd or FBCTF
- Practising pentest tools (Burp Suite, OWASP ZAP, sqlmap) against a safe, legal target
- Demonstrating DAST scanners and WAF rules on a known-vulnerable app

## Dependencies for OWASP Juice Shop Hosting

- None. Everything is in the image. An LLM API key is optional, for the chatbot challenges.

### Deployment Dependencies

- [OWASP Juice Shop on GitHub](https://github.com/juice-shop/juice-shop)
- [Pwning OWASP Juice Shop (official guide)](https://pwning.owasp-juice.shop/)
- [Juice Shop CTF extension](https://github.com/juice-shop/juice-shop-ctf)
- [Template source](https://github.com/two-workspaces/juice-shop)

### Implementation Details

- **Tested on Railway:** the shop and its healthcheck, solving challenges (SQL-injection admin login, Confidential Document), the `ctf` profile, and the chatbot streaming replies through an OpenAI-compatible API set with the `LLM_*` variables. The CTF webhook and juice-shop-ctf-cli were not tested.
- **Memory:** about 175 MB idle and 160–180 MB under load in our test, so it fits a 0.5 GB plan.
- **Safety mode:** upstream turns off the challenges that can hang or crash the server (RCE and XXE denial of service, memory bomb, SSTi, some XSS ones) when it runs in Docker. Railway's containers don't look like Docker to Juice Shop, so the image adds the marker file and behaves exactly like `docker run bkimminich/juice-shop`. Set `SAFETY_MODE=disabled`, or use `NODE_ENV=ctf`, to turn them all on; a solved denial-of-service challenge can then make the service unresponsive until it restarts.
- **Config profiles:** `NODE_ENV` picks one of upstream's config files: empty for the standard shop, or `ctf`, `tutorial`, `quiet`, `unsafe`, `mozilla`, `bodgeit`, `juicebox` and others.
- **Image:** upstream's `bkimminich/juice-shop:v20.4.0`, pinned, plus a small config file that maps the template variables and the Docker marker file.

## Why Deploy OWASP Juice Shop on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying OWASP Juice Shop on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
