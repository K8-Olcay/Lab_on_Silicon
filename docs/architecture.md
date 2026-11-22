Architecture

**Network Model**

Lab_on_Silicon uses a dedicated Docker bridge network called lab-net to connect the Kali attack container and the OWASP Juice Shop target container.

MacBook Pro M5 (host)
└── Colima VM
    └── Docker engine
        └── lab-net (private bridge network)
            ├── kali
            │   └── No ports published
            ├── juice-shop
            │   └── 127.0.0.1:3000 only
            └── Internet egress
                └── BLOCKED (IP masquerading disabled)

Outbound internet access from `lab-net` is intentionally disabled by setting `com.docker.network.bridge.enable_ip_masquerade` to `"false"`. Kali and Juice Shop can still communicate with each other over the private bridge network, and Juice Shop remains accessible from the host through `127.0.0.1:3000`.

The isolation configuration is verified automatically by `make verify`.


**Kali Attack Image**

The Kali attack container is built from kalilinux/kali-rolling using a custom Dockerfile located at kali/Dockerfile.

The lab uses the targeted toolset approach rather than the full kali-linux-headless metapackage. This keeps the attack image smaller while providing the tools needed for the security testing activities in the lab.

The following tools are installed:

nmap
curl
sqlmap
hydra
nikto
dirb
netcat-openbsd
dnsutils
The image is built locally as lab-kali.

**Docker Compose Services**

The lab is managed as a single environment using compose.yaml.

**Kali**

The kali service uses the locally built lab-kali image and is connected only to lab-net. No ports are published from the Kali container because it is designed to initiate connections to targets within the lab.

The container uses stdin_open and tty so that an interactive Kali shell can remain available for security testing.

**OWASP Juice Shop**

The juice-shop service uses the pinned image:

bkimminich/juice-shop:v20.3.0

Pinning the version helps keep the lab reproducible instead of depending on a changing latest image.

Juice Shop is connected to lab-net and publishes its web interface using:

127.0.0.1:3000:3000

This allows the application to be accessed from the host browser at http://127.0.0.1:3000 without binding the application to all host network interfaces.

**Connectivity Verification**

Connectivity between the Kali attack container and Juice Shop was tested over the private Docker network.

Kali successfully resolved the juice-shop service name and received an HTTP 200 response from:

http://juice-shop:3000

An Nmap scan from Kali also successfully reached the juice-shop service and detected TCP port 3000 as open.

These tests confirm that the two containers can communicate through lab-net as designed.