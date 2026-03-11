# mengyi-sw-docker-demo 🐳

A fun Docker demo image used during a live Docker introduction session.

Pull and run the image — if you're among the first, **congratulations, félicitations!** 🎉

---

## What's inside?

| Path | Description |
|------|-------------|
| `/` (index.html) | Congratulations page with a swimming whale & confetti |
| `/slides.html` | Full Docker intro presentation slides |

The image is a minimal **nginx:alpine** container serving two static HTML pages.
Image size is tiny — no runtime dependencies beyond nginx.

---

## Quick start
In your ubuntu

```bash
# Check if port 8080 is already in use
lsof -i :8080

# If something is using it, stop the process
kill -9 $(lsof -t -i:8080)

# If the port is used by a Docker container instead, stop it with:
docker ps
docker stop <container_id>
# Pull the image
docker pull mguosimwell/mengyi-sw-docker-demo:{imageTag}

# Run it (visit http://localhost:8080 in your browser)
docker run -d -p 8080:80 mguosimwell/mengyi-sw-docker-demo:{imageTag}
```

Then open **http://localhost:8080** — you'll see the congratulations page with a whale swimming across the screen.
Head to **http://localhost:8080/slides.html** for the full Docker intro deck.

---

## Build & push (maintainer)

```bash
cd docker-demo

# Build
docker build -t mguosimwell/mengyi-sw-docker-demo .

# Test locally
docker run -d -p 8080:80 mguosimwell/mengyi-sw-docker-demo

# Push to Docker Hub
docker push mguosimwell/mengyi-sw-docker-demo
```

---

## Why this exists

This image was created for a live Docker demo to illustrate:

1. How to pull a public image from Docker Hub
2. How to run a container and map a port
3. That containers really are that simple — a full web app in one command

Used after the audience had already pulled and run a `postgres` container,
this image makes it a mini competition: **who pulls and runs it first?**

---

*Built with nginx:alpine · Served at port 80 · No secrets, no databases, pure fun.*
