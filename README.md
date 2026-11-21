**Lab_on_Silicon**

Lab_on_Silicon is an Apple Silicon first OWASP Top 10 security testing environment designed for students and beginners. The project combines Docker based vulnerable targets, ARM64 compatibility validation, and guided learning materials to provide a reproducible cybersecurity lab environment on Apple Silicon systems.

**PROJECT DESCRIPTION:**
Most vulnerable app labs treat Apple Silicon as an afterthought. Some work by accident, some require emulation.  Very few are designed from the start around ARM64 host machines, safety isolation, reproducibility, and clear pedagogy. This project is a chance to build and publish a tool that proves  those four things can coexist.

**PROJECT GOAL:**
Design, validate, and document an Apple Silicon-native OWASP Top 10 lab that anyone can run with one command.

**Project Status:**
*In Progress*

**QUICK START**

**TOOLCHAIN:**

This project uses:

Homebrew 7.0.10
Docker CLI 29.9.2
Docker Compose 5.6.1
Colima 0.10.3
Lima 2.2.1
Containers:

kalilinux/kali-rolling
bkimminich/juice-shop:v20.3.0

The environment was verified on Apple Silicon using native ARM64 containers.

**Run the Lab**

Install and verify the toolchain:

./scripts/setup.sh

**Start the lab:**

make up

**Open OWASP Juice Shop in the host browser:**

http://127.0.0.1:3000

**Enter the Kali attack container:**

make shell

**Check the status of the lab:**

make status

**Tear down the lab:**

make down

**Lab Controls**

The Makefile provides simple commands for managing the lab:

make up - Build and start the lab.

make down - Stop and remove the lab containers and network.

make reset - Tear down and rebuild the lab.

make status - Display the status of the lab containers.

make shell - Open an interactive shell inside the Kali container.

make verify - Verify ARM64-native operation and the lab isolation model.

**Controlled network egress**

By default, `lab-net` has **outbound internet access disabled**. This is intentional: the running Kali and Juice Shop containers do not need internet access, and closing egress keeps the lab provably contained.

This does **not** affect `docker pull` or `docker build`. Those use the Docker daemon's own network, not `lab-net`.

If you need to install additional packages inside the running Kali container:

1. Edit `compose.yaml` and set the masquerade option to `"true"`.
2. Run `make down && make up` to recreate the network.
3. Install what you need from inside Kali.
4. Set the masquerade option back to `"false"`.
5. Run `make down && make up` again.
6. Run `make verify` to confirm that the lab is isolated again.

Never leave the lab running with egress enabled unless you are actively installing packages.