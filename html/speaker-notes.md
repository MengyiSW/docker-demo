# Speaker Notes — Introduction to Docker

## Slide 01 — Title: Introduction to Docker
## Slide 02 — Agenda: What We'll Cover Today

<p>
Hello and welcome to SimWell Developers Session #2: Intro to Docker. Our 1st SimWell Developers Session #2: was about Coding standards and best practices which held at the summer strategic meeting. The session today was designed to give you a practical introduction to Docker — the most popular containerization platform in software development.
By the end of this meeting, we'll have a general understanding of all the main concepts and also a great big picture overview of how Docker is used in the whole software development process. So let's quickly go through the topics we will cover for today.
So get your first hands-on experience and confidence using Docker in a projecs.  We will start with the basic concepts of what Docker actually is and what problems it solves. Also, will understand the difference between Docker and virtual machine. And after installing Docker, we will go through all the main documents to start and stop containers
Set expectations: "We're not going to cover Dockerfile authoring or Docker Compose today — those are great next steps once the foundations click."

If you get stuck anywhere, just comment and Ryan will try my best to answer your questions.

**Opening hook:**
Ask who knows Docker and when and how they use it. Some possible answers:

- "I use it to run Postgres locally for development."
- "I use it in CI to build and test my app."
- "I use it in production to deploy my microservices."

---

## Slide 03 — What is Docker?
The word "Docker"
The name is a deliberate play on the shipping/cargo world. In British English, a "docker" is a dockworker — a waterfront laborer who loads and unloads ships WikipediaYourDictionary. The software is called Docker because it works with containers — and who handles containers at a port? Dockers. The whole naming concept is a metaphor: just as a docker moves standardized shipping containers around a port, the Docker software moves standardized software containers between computing environments.

What a container is, a container is a way to package applications with everything they need inside of the package, including the dependencies and all the configuration necessary. And that package is portable, just like any other artifact is in. That package can be easily shared and moved around between a development team or development and operations team. And that portability of containers plus everything packaged in one isolated environment gives it some of the advantages that makes development and deployment process more efficient.
And we'll see some of the examples of how that works in later slides, so as I mentioned, containers are portable, so there must be some kind of a storage for those containers so that you can share them and move them around. So containers leave in a container repository. 
So the whole thing is one big, coherent metaphor: containers → shipping → docks → docker workers → a whale carrying containers. It all hangs together beautifully.

When I first started learning Docker, after understanding some of the main concepts, my first question was, OK, so what is the difference between Docker and an Oracle virtual books, for example? And the difference is quite simple, I think. And in the short video, I'm going to cover exactly that. And I'm going to show you the difference by explaining how DOCA works on an operating system level and then comparing it to how virtual machine works. So let's get started.
In order to understand how Docker works on the operating system level, let's first look at how operating system is made up. So operating systems have two layers operating system kernel in the applications layer. So as you see in this diagram, the kernel is the part that communicates with the hardware components like CPU and memory, et cetera, and the applications run on the kernel layer. So they are based on the kernel.
So for example, you will know Linux operating system and there are lots of distributions of Linux out there. There's Bonta and Debian and there is Linux meaned, etc. There are hundreds of distributions. They all look different. So the graphical user interface is different. The file system is maybe different. So a lot of applications that you use are different because even though they use the same Linux kernel, they use different or they implement different applications on top of that kernel.
So, as you know, Docker and virtual machine, they're both virtualization tools. So the question here is what parts of the operating system they virtualize? So Docker virtualizes the application layer. So when you download a docker image, it actually contains the applications layer of the operating system and some other applications installed on top of it. And it uses the kernel of the host because it doesn't have its own kernel, the virtual box or the virtual machine, on the other hand, has the applications layer and its own kernel. So it virtualizes the complete operating system, which means that when you download a virtual machine image on your host, it doesn't use your host kernel. It puts up its own.
So what is this difference between Docker and virtual machine actually mean? So first of all, the size of Docker images are much smaller because they just have to implement one layer. So Docker images are usually a couple of megabytes. Virtual machine images, on the other hand, can be a couple of gigabytes large. A second one is the speed so you can run and start docker containers much faster than the VMS because they every time you start them, you they have to put the operating system kernel and the applications on top of it. The third difference is compatibility, so you can run a virtual machine image of any operating system on any other operating system host, but you can't do that with Docker.
So what is the problem exactly? Let's say you have a Windows operating system with a kernel and some applications and you want to run Linux based Docker image on that Windows host. The problem here is that a Linux based, her image might not be compatible with the Windows kernel, and this is actually true for the Windows versions below 10 and also for the older Mac versions, which if you have seen how to install Docker on different operating systems, you see that the first step is to check whether your hosts can actually run Docker natively, which basically means is the kernel compatible with the Docker images? So in that case, a workaround is that you install a technology called Docker Toolbox, which abstracts away the kernel to make it possible for your hosts to run different docker images.

**Key distinction — VM vs Container:**

Use the analogy on the slide, then go deeper:

> "A VM is like renting an entire house — you get your own plumbing, electricity, foundation, roof. A container is like
> renting an apartment in a shared building — you have your own space, your own locks, your own kitchen, but you share
> the
> building's plumbing and electrical grid. That shared infrastructure is the host OS kernel."

**Extend the metaphor further:**
> "Now imagine the hotel vs apartment scenario. A VM is like building a new hotel from scratch for every guest — full
> walls, its own generator, its own water supply. Takes time to construct, uses a lot of resources. A container is like
> setting up a room divider in one big open space — you get your isolated zone almost instantly, using a fraction of the
> resources."

**What this means practically:**

|             | Virtual Machine  | Container            |
|-------------|------------------|----------------------|
| Boots in... | 30–60 seconds    | < 1 second           |
| Includes    | Full OS + kernel | App + libraries only |
| Size        | GBs              | MBs                  |
| Isolation   | Hardware-level   | OS process-level     |
| Overhead    | High             | Near zero            |

**Third metaphor — shipping containers (the origin of the name):**
> "Think about how global shipping worked before standardized containers. Every port had different equipment, every ship
> was loaded differently, cargo got damaged in transit. Then someone invented the standard metal shipping container —
> same
> size, same corner locks, works on any ship, any truck, any crane, any port in the world. Docker containers are the
> same
> idea for software. Build it once, it runs identically anywhere Docker is installed."

**What isolation actually means:**

- Own filesystem — the container can't see files outside itself unless you explicitly mount them
- Own network — the container has its own IP, its own ports; nothing leaks in or out unless you map it
- Own processes — `ps aux` inside the container shows only that container's processes

**Pause and check understanding:** "Any questions so far on VM vs container?" This concept trips people up the most —
give it a moment before moving on.

## Slide 04 — The Problem: "Works on My Machine"

**Relatable opener — ask the room:**
> "Raise your hand if you've ever heard 'it works on my machine'... or said it yourself."

**Elaborate on each bullet with concrete real-world examples:**

- **Environment drift** — "Your dev machine runs Ubuntu 22.04 with `openssl 3.0`. Production runs Amazon Linux 2 with
  `openssl 1.1`. Your app uses a TLS feature that behaves differently between versions — and that bug only surfaces in
  prod at 2am on a Friday. The code didn't change. The environment did."

- **Dependency conflicts** — "You join a new team. Project A needs Python 3.8 and `numpy 1.21`. Project B needs Python
  3.11 and `numpy 1.24`. Installing both on the same machine without a tool like `pyenv` or `venv` is a mess. Or imagine
  needing Node 16 for a legacy React app and Node 20 for your new Next.js project simultaneously — you're constantly
  switching with `nvm use` and still breaking things."

  A real example to tell:
  > "I once spent half a day debugging a broken CI build. Turned out the pipeline runner had `libpq` version 14 but my
  Dockerfile expected version 15. The app ran fine locally because my laptop happened to have the right version already.
  Classic drift."

- **Slow onboarding** — "A new developer joins. The setup doc says 'install Postgres 14' but doesn't mention the
  required extensions. They spend 2 days installing the wrong versions, asking Slack, hitting undocumented steps. That's
  2 days of lost productivity — for them, and for the senior who keeps getting pinged. With Docker: `docker compose up`
  and the full environment is running in minutes, no wiki needed."

- **The blame game** — "The developer says 'it works on my machine.' The ops engineer says 'then ship your machine.'
  Nobody wins. 'Works on my machine' is not a deployment strategy — it's a symptom of an environment problem that Docker
  eliminates by making the environment part of the code."

**Transition:**
> "Docker solves all of this by packaging the application and its entire environment into one portable unit. You ship
> the environment, not just the code."

<p>
So now let's see how container's improved the development process by specific examples, how did we develop applications before the containers? Usually when you have a team of developers working on some application, you would have to install most of the services on your operating system directly. Right. For example, you you're developing some JavaScript application and you need to be cool and ready for messaging. And every developer in the team would then have to go and install the binaries of those services and configure them and run them on their local development environment and depending on which operating system they're using, the installation process will look actually different.
Also, another thing with installing services like this is that you have multiple steps of installation. So you have a couple of commands that you have to execute. And the chances of something going wrong and error happening is actually pretty high because of the number of steps required to install each service. And this approach or this process of setting up a new environment can actually be pretty tedious, depending on how complex your application is. For example, if you have 10 services that your application is using, then you would have to do that 10 times on each operating system environment.

So now let's see how containers solve some of these problems with containers. You actually do not have to install any of the services directly on your operating system because the container is its own isolated operating system layer with Linux based image. As we saw in the previous slides, you have everything packaged in one isolated environment. So you have the postgresql with the specific version packaged with a configuration in the start script inside of one container. So as the developer, you have to go and look for the binaries to download on your machine, but rather you just go ahead and check out the container repository to find that specific container and download on your local machine. And the download step is just one docker command which fetches the container and starts it at the same time. And regardless of which operating system you're on, the command, the doc recommend for starting the container will not be different. It will be the exactly the same.
So we have 10 applications that your JavaScript application uses and depends on. You would just have to run 10 docker commands for each container and that will be it. Which makes the setting up your local development environment actually much easier and much more efficient than the previous version. Also, as we saw in the demonstration before, you can actually have different versions of the same application running on your local environment without having any conflict.


So now let's see how container's can improve the deployment process before the containers, a traditional deployment process will look like this. Development team will produce artifacts together with a set of instructions of how to actually install and configure those artifacts on the server. So you would have a jar file or something similar for your application. And in addition, you would have some kind of a database service or some other service also with a set of instructions of how to configure and set it up on the server. So development team would give those artifacts over to the operations team and the operations team will handle setting up the environment to deploy those applications.
Now, the problem with this kind of approach is that, first of all, you need to configure everything and install everything directly on the operating system, which we saw in the previous example that could actually lead to conflicts with dependency version and multiple services running on the same host. In other problems that could arise from this kind of process is when there is misunderstanding between the development team and operations because everything is in a textual guide as instructions. So there could be cases where developers forget to mention some important point about configuration. Or maybe when operations team misinterpreted some of those instructions and when that fails, the operations team has to go back to the developers and ask for more details. And this could lead to some back and forth communication until the application is successfully deployed on the server.
With containers, this process is actually simplified because, now you have the developers and operations working in one team to package the whole configuration dependencies inside the application, just as we saw previously. And since it's already encapsulated in one single environment and you're going to have to configure any of this directly on the server. So the only thing you need to do is run a docker command that pulls that container image that you've stored somewhere in the repository and then run it. This is, of course, a simplified version, but that makes exactly the problem that we saw on the previous slide much more easier. No environmental configuration needed on the server. The only thing, of course, you need to do is you have to install and set up the DOCA runtime on the server before you will be able to run containers there, but that's just one time effort.

---

## Slide 05 — Why Use Docker?

Go through each bullet with a concrete scenario:

- **Consistent environments** — "The container is the environment. If it works in your container, it works in CI, it
  works in prod. Full stop."
- **Isolation** — "Need Postgres 14 for the legacy project and Postgres 16 for the new one? Run them both simultaneously
  on the same laptop, different ports, zero conflict."
- **Reproducibility** — "Share a Dockerfile and everyone gets the exact same setup. No more 'what version did you
  install?'"
- **Faster CI/CD** — "Build your image in CI once. That exact artifact — not a rebuilt version — goes to staging, then
  to prod. No surprises."
- **Easy cleanup** — "Tried a database for a proof-of-concept? `docker rm` and it's completely gone. No leftover
  services, no registry entries, no residual config files polluting your machine."

---

## Slide 06 — Docker on Linux, Mac & Windows

> ⚠️ **This is the most technically nuanced slide. Spend extra time here.**

### What is the Docker Client and What is the Docker Server?

Before getting into OS differences, establish this mental model — it's the key to understanding everything on this
slide.

> "Docker has two separate pieces: a **client** and a **server**. They are different programs. They can run on the same
> machine or on completely different machines."

**Docker Client (`docker`):**

- The CLI tool you type commands into: `docker run`, `docker pull`, `docker ps`
- It does NOT build or run anything itself
- Its only job is to translate your command into an API call and send it somewhere
- It's just a messenger

**Docker Server / Daemon (`dockerd`):**

- The background process that actually does the work
- It manages images, containers, networks, and volumes
- It talks to the Linux kernel to create and run containers
- It listens for API calls from clients

**How they connect:**

```
You type:    docker run postgres:16
                    │
                    ▼
          Docker Client (docker CLI)
                    │
                    │  HTTP request: "POST /containers/create"
                    │  sent over a socket
                    ▼
          Docker Daemon (dockerd)
                    │
                    │  calls Linux kernel APIs
                    │  (cgroups + namespaces)
                    ▼
          Container starts running
```

> "On Linux, that socket is a Unix socket at `/var/run/docker.sock`. On macOS and Windows, the client connects to the
> daemon inside a VM through a similar mechanism. The important thing: **the client and server don't have to be on the
same machine.** You can run the Docker CLI on your laptop and point it at a daemon on a remote server using the
`DOCKER_HOST` environment variable."

**Why this matters for the OS discussion:** The client can run on any OS. The server (daemon) **must** run on Linux —
because only Linux has cgroups and namespaces. On macOS and Windows, Docker solves this by hiding a Linux environment
for the daemon to live in.

---

**Set up the core concept:**

> "Containers are a Linux technology. They rely on two Linux kernel features: **cgroups** (for resource limits — CPU,
> memory) and **namespaces** (for isolation — filesystem, network, processes). This is why the daemon must always run on
> Linux, and why macOS and Windows need a workaround."

---

### 🐧 Linux — Native, Zero overhead

**What's happening under the hood:**

Docker Engine (`dockerd`) runs **directly on your Linux host**. When you run `docker run ubuntu bash`, Docker asks the
Linux kernel to create an isolated process using namespaces and cgroups. There is no middleman, no hypervisor, no
translation layer.

**Why this matters:**

- Containers share the host kernel — so `uname -r` inside the container returns your host's kernel version.
- Full native performance. A containerized app runs at essentially the same speed as running it directly on the OS.
- File I/O, network, CPU — all native.

**Example — install Docker Engine on Ubuntu:**

```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable the daemon
sudo systemctl enable --now docker

# Verify
docker run hello-world
```

**Pro tip:** Add your user to the `docker` group so you don't need `sudo`:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

### 🍎 macOS — Docker Desktop with a hidden Linux VM

**The fundamental problem:**

macOS uses a Darwin/BSD kernel. It does **not** have Linux cgroups or namespaces. So Docker cannot run containers
natively on macOS.

**How Docker Desktop solves it:**

Docker Desktop silently spins up a lightweight **Linux VM** (using Apple's Virtualization.framework on Apple Silicon, or
HyperKit/QEMU on Intel). Docker Engine (`dockerd`) runs inside this VM. Your Docker CLI on macOS talks to the daemon
inside that VM via a Unix socket.

```
Your macOS Terminal
      │
      │  docker run postgres:16
      ▼
Docker CLI (macOS binary)
      │
      │  REST API over Unix socket
      ▼
Linux VM (managed by Docker Desktop)
      │
      ▼
dockerd (inside VM)
      │
      ▼
Container (running in Linux VM)
```

**Why you don't notice it:** Docker Desktop manages the VM lifecycle automatically — it starts when Docker Desktop
starts, stops when you quit it.

**Performance implication:** File volume mounts between macOS and the Linux VM can be slower than native Linux, because
files cross the VM boundary. This is usually not an issue for databases or APIs, but can be noticeable for file-heavy
workloads.

**Apple Silicon note (M1/M2/M3):** Most images on Docker Hub are built for `linux/amd64`. Docker Desktop uses Rosetta 2
to run them on ARM. For best performance, look for `linux/arm64` variants. Example:

```bash
docker pull --platform linux/arm64 postgres:16
```

**How to install Docker Desktop on macOS:**

1. Download from docker.com/products/docker-desktop
2. Install the `.dmg`
3. Launch Docker Desktop from Applications
4. Wait for the whale icon in the menu bar to stop animating
5. Open Terminal → `docker run hello-world`

---

### 🪟 Windows — WSL2 is the right way (avoid Docker Desktop)

**Why Windows needs special treatment:**

Like macOS, Windows does not have a Linux kernel (unless you count WSL2). Standard Windows containers exist but are
rarely used — the ecosystem is Linux-first.

**The recommended approach: Docker Engine inside WSL2**

WSL2 (Windows Subsystem for Linux 2) runs a **real Linux kernel** as a lightweight utility VM. Unlike WSL1 (which was a
compatibility layer), WSL2 is a genuine Hyper-V VM with a Microsoft-maintained Linux kernel. This means you can run
Docker Engine inside WSL2 exactly as you would on native Linux.

**Client and server on Windows — where do they each live?**

```
┌─────────────────────────────────────────┐
│  Windows Host                           │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │  WSL2 Ubuntu (Linux VM)           │  │
│  │                                   │  │
│  │  Docker Client (docker CLI) ──────┼──┼──▶ you type commands here
│  │  Docker Daemon (dockerd)     ◀────┼──┘
│  │  Containers run here              │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

> "Both the Docker client AND the Docker daemon live inside WSL2 — inside Linux. When you open your Ubuntu terminal in
> WSL2 and type `docker run`, the client and the daemon are both on the same Linux system. Windows is just the host that
> provides the hardware."

**What about port forwarding?** WSL2 automatically forwards ports from the Linux VM to Windows. So if your container
maps port 5432, you can connect to `localhost:5432` from any Windows app (DBeaver, browser, Postman) — it just works.

```
Container inside WSL2
      port 5432
          │
          │  WSL2 forwards automatically
          ▼
Windows localhost:5432  ←── DBeaver / pgAdmin / any Windows tool
```

> "Install Docker Engine **inside** your WSL2 Ubuntu distro — not on Windows. The Docker CLI lives in Linux. You never
> run Docker commands from PowerShell or CMD."

**Step by step:**

```powershell
# 1. Enable WSL2 (run in PowerShell as Administrator)
wsl --install
# Reboot when prompted — Ubuntu is installed by default
```

```bash
# 2. Open your Ubuntu WSL2 terminal, then install Docker Engine
# (Follow the same Ubuntu instructions as Linux above)
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
# ... (same steps as Linux Ubuntu install)

# 3. Start Docker daemon
sudo service docker start
# Or use: sudo dockerd &

# 4. (Optional) Auto-start daemon when WSL launches
# Add to ~/.bashrc:
# if ! pgrep -x "dockerd" > /dev/null; then sudo service docker start; fi

# 5. Verify
docker run hello-world
```

**Why NOT Docker Desktop on Windows:**

> ⚠️ The slide explicitly warns against Docker Desktop on Windows.

Docker Desktop on Windows adds a management layer on top of WSL2 that can cause:

- Licensing issues for larger teams (Docker Desktop is paid for companies >250 employees or >$10M revenue)
- Random daemon crashes and reset loops
- Conflict with other Hyper-V workloads
- Slower resource usage (the Docker Desktop GUI itself consumes significant RAM)

Docker Engine directly inside WSL2 is leaner, more reliable, and free.

**Accessing WSL2 Docker from Windows tools:** If you need to connect a Windows GUI tool (like DBeaver or TablePlus) to a
service running in a Docker container inside WSL2, use `localhost` — WSL2 automatically forwards ports to the Windows
host.

---

### Key Insight (bottom callout)

> "The Docker CLI is just a client. It sends commands to `dockerd` via a socket. Whether that daemon is on bare metal
> Linux, inside a VM on macOS, or inside WSL2 on Windows — you type the exact same commands. The abstraction is
> perfect."

This is why your teammate on Linux and you on macOS can share the same `docker run` command and get identical behavior.

---

## Slide 07 — Core Concept 01: Image

**Analogy reinforcement:** "Think of an image like a class in OOP, or a recipe. It's the definition — not the thing
itself."

**Layered filesystem** — briefly explain this:
> "Each instruction in a Dockerfile creates a layer. Layers are cached. If you change one line, only that layer and
> everything after it rebuilds. This makes builds fast and images shareable — two images that both start from
`ubuntu:22.04` share that base layer on disk."

**Show the command:** `docker images` — walk through the output columns (REPOSITORY, TAG, IMAGE ID, SIZE).

**Tag notation:** `postgres:16` — repository name is `postgres`, tag is `16`. `latest` is just another tag, not magic.

---

## Slide 08 — Core Concept 02: Container

**OOP analogy payoff:**
> "If an image is a class, a container is an instance. Just like you can instantiate the same class many times in
> memory, you can run many containers from one image — each completely independent."

**Emphasize ephemerality:**
> "By default, containers are ephemeral. Stop and remove a container, and anything written inside it is gone. This is
> intentional. For persistent data you use volumes — we'll touch on that in Next Steps."

**Show the command:** `docker ps` for running containers, `docker ps -a` for all including stopped ones.

---

## Slide 09 — Core Concept 03: Docker Engine

**Client-server model:** The key mental model here is that `docker` (the CLI) and `dockerd` (the daemon) are separate
processes. They communicate via a REST API over a Unix socket (`/var/run/docker.sock`).

> "When you type `docker run postgres`, you're talking to the daemon. The daemon does the actual work: checks if the
> image is local, pulls it from the registry if not, creates the container, starts the process."

**Practical implication:**

- You can run the CLI on one machine and point it at a remote daemon using `DOCKER_HOST` env var.
- This is how CI/CD systems often work — the build agent has the Docker CLI; it talks to a daemon elsewhere.

---

## Slide 10 — Core Concept 04: Registry

**Registry = npm for containers.** That's the clearest analogy.

- `docker pull postgres:16` → downloads image layers from Docker Hub
- `docker push myapp:v1` → uploads your image layers to a registry

**Public vs Private:**

- **Docker Hub** — free for public images. Rate-limited for anonymous pulls (100/6h). Authenticated gets you more.
- **GitHub GHCR** — good for open-source projects hosted on GitHub.
- **AWS ECR / Azure ACR / GCP Artifact Registry** — used in production when you need private images in the cloud.
  Authentication is handled by cloud IAM.

**Image naming convention:**

```
[registry/][username/]repository[:tag]

postgres:16                         # Docker Hub official image
library/postgres:16                 # Same, explicit
myuser/myapp:v1.2.3                # Docker Hub user image
ghcr.io/myorg/myapp:latest         # GitHub Container Registry
123456789.dkr.ecr.us-east-1.amazonaws.com/myapp:prod   # AWS ECR
```

---

## Slide 11 — Architecture: How It All Fits Together

Walk through the diagram slowly, left to right / top to bottom:

1. **You type a command** → Docker CLI receives it
2. **CLI → REST API → dockerd** → the daemon checks if the image is local
3. **If not local → pulls from registry** → layers are downloaded and cached
4. **dockerd creates containers** → each runs as an isolated process on the host

> "Everything you've learned — Image, Container, Engine, Registry — this diagram shows how they connect. Keep this
> mental model. It'll make debugging much easier."

**Good question to invite:** "What happens if you run `docker run` with no internet connection and the image isn't
local?" → It fails with a pull error. But if the image is already local (previously pulled), it works offline.

---

## Slide 12 — Installation: Docker Engine via WSL2

This slide is Windows-specific. Narrate the 4 steps as a live walkthrough if time permits, or skip to demo if attendees
already have Docker installed.

**Step 1 tip:** `wsl --install` defaults to Ubuntu. You can choose a different distro with `wsl --install -d Debian`.
Reboot is required.

**Step 2 tip:** The official docs at `docs.docker.com/engine/install/ubuntu` have a convenient install script. Just
copy-paste inside your WSL2 terminal.

**Step 3 — key verification commands:**

```bash
docker --version     # e.g. Docker version 26.1.0
docker info          # Full daemon info — confirms it's running
```

**Step 4 — hello-world** is always satisfying. It confirms: image pull works, container creation works, container
execution works.

---

## Slide 13 — Demo Step 1: Pull the PostgreSQL Image

**Narrate what's happening:**

```bash
docker pull postgres:16
```

> "Docker contacts Docker Hub, authenticates (or uses anonymous), and downloads the image in layers. You'll see each
> layer hash and its download progress. Layers are cached — if you pull `postgres:17` later, any shared layers are
> reused."

```bash
docker images postgres
```

> "This confirms the image is now stored locally. Note the size — about 428MB. That's everything needed to run a full
> PostgreSQL server."

**If the audience already pulled:** Skip the download and go straight to `docker images`.

---

## Slide 14 — Demo Step 2: Run a PostgreSQL Container

Walk through each flag **before** running the command:

| Flag                          | What it does                                              |
|-------------------------------|-----------------------------------------------------------|
| `-d`                          | Detached — run in background, get prompt back immediately |
| `--name mypostgres`           | Friendly name so you don't have to use the container ID   |
| `-e POSTGRES_USER=admin`      | Environment variable — sets the DB username               |
| `-e POSTGRES_PASSWORD=secret` | Sets the password (never use "secret" in production!)     |
| `-e POSTGRES_DB=mydb`         | Creates a database named `mydb` on startup                |
| `-p 5432:5432`                | Port mapping: `host_port:container_port`                  |

**Port mapping emphasis:**
> "The `-p` flag bridges your host network and the container's network. Left side is YOUR machine's port — that's where
> you'll connect. Right side is what Postgres listens on inside the container. They don't have to match — you could do
`-p 15432:5432` if port 5432 is already taken on your machine."

**Run it, then show:**

```bash
docker ps
# You should see mypostgres with status "Up X seconds"
```

---

## Slide 15 — Demo Step 3: Verify & Connect

**Left column — managing the container:**

```bash
docker ps              # confirm it's running
docker stop mypostgres # gracefully stop it (SIGTERM → SIGKILL after 10s)
docker rm mypostgres   # remove the container (frees name and resources)
```

> "Stop doesn't remove the container. It just stops the process — like pausing. `rm` actually deletes it. You can do
> both in one step: `docker rm -f mypostgres`."

**Right column — connect via psql:**

```bash
psql -h localhost -p 5432 -U admin -d mydb
```

> "We're connecting to `localhost` because we mapped port 5432. The container is running in its own network, but that
`-p 5432:5432` flag is a bridge."

**Inside psql:**

```sql
\l                -- list all databases
SELECT version(); -- confirm PostgreSQL 16
\q                -- quit
```

**Alternative clients:** DBeaver, TablePlus, pgAdmin — any Postgres client works. Use `localhost:5432`, user `admin`,
password `secret`, database `mydb`.

---

## Slide 16 — Challenge

**Set the stage with energy:**
> "Now it's your turn. I've pushed an image to Docker Hub. Your job is to pull it, run it, and tell me what you see — no
> hints beyond what's on the slide."

**The image:** `mguosimwell/mengyi-sw-docker-demo`

**What they need to figure out:**

1. Find the correct tag (they'll need to look it up on Docker Hub or try common ones like `latest`)
2. Run **without** `-d` (foreground, so they see output)
3. Use `--name demoApp`
4. Map port `8080:80` (it's NGINX — hint is on the slide)
5. Report what they see in the browser at `http://localhost:8080`
6. Stop it with `Ctrl+C` (since it's in foreground)

**Answer (for your reference):**

```bash
docker pull mguosimwell/mengyi-sw-docker-demo:latest
docker run --name demoApp -p 8080:80 mguosimwell/mengyi-sw-docker-demo:latest
# Open browser → http://localhost:8080
# Ctrl+C to stop, then: docker rm demoApp
```

**Award the LinkedIn endorsement** to the first person who succeeds and announces it.

---

## Slide 17 — Useful Commands Reference

Don't read every command — it's a reference slide. Highlight 2-3:

**Most useful day-to-day:**

```bash
docker logs -f <name>    # tail container logs in real time
docker stats             # live CPU/memory dashboard for all containers
docker inspect <name>    # full JSON — great for debugging port bindings, env vars
```

**Cleanup commands people always forget:**

```bash
docker system prune -a   # nuclear option — removes everything unused
docker system df         # shows how much disk Docker is using — run this when your disk fills up
```

> "Run `docker system df` if you ever wonder where your disk space went. Docker images add up fast."

---

## Slide 18 — Summary & Next Steps

**Recap the journey:**
> "We started with 'it works on my machine' — a universal pain point. We learned that Docker solves it by packaging the
> environment with the code. We covered the four core primitives: Image, Container, Engine, Registry. We ran a real
> Postgres database with one command, connected to it, and tore it down cleanly."

**Next steps to recommend:**

- **Dockerfile** — write your own image. Start from a base image, copy your code, install deps, expose a port, define
  the entrypoint.
- **Docker Compose** — define multi-container apps in YAML. One `docker compose up` and your app, database, and cache
  all start together.
- **Volumes** — persist data beyond container lifetime. Mount a host directory or a named volume.
- **TechWorld with Nana** on YouTube — excellent free content for everything Docker and Kubernetes.

---

## Slide 19 — References & Credits

Briefly call out:

- **TechWorld with Nana** — great YouTube tutorials for going deeper
- **docs.docker.com** — the official reference, surprisingly readable
- **Claude Code** — this presentation was built with AI assistance

> "The links are there if you want to explore. Any final questions?"

**Close strong:**
> "Docker is one of those tools where the first 20 minutes feel overwhelming, and then it clicks — and you wonder how
> you ever worked without it. You've had those 20 minutes today. Go run something."

---

## Quick Reference — Commands Used in Demo

```bash
# Pull
docker pull postgres:16

# Run PostgreSQL
docker run -d \
  --name mypostgres \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  postgres:16

# Check it's running
docker ps

# Connect via psql
psql -h localhost -p 5432 -U admin -d mydb

# Stop and remove
docker stop mypostgres
docker rm mypostgres

# Challenge solution
docker pull mguosimwell/mengyi-sw-docker-demo:latest
docker run --name demoApp -p 8080:80 mguosimwell/mengyi-sw-docker-demo:latest
```
