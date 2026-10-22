INSTALLED VERSIONS:

HomeBrew 
    - HomeBrew 7.0.10

    Command to INSTALL:
                    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


Docker CLI
    - Docker version 29.9.2

    Command to INSTALL Docker and Compose:
                                        brew install docker docker-compose

Docker Compose
    - Docker Compose version 5.6.1


Colima
    - Colima 0.10.3

    Command to INSTALL:
                    brew install colima

    Command to START:
                    colima start --cpu 4 --memory 12 --disk 80 --vm-type vz --vz-rosetta --mount-type virtiofs


Lima (Colima Dependency)
    - Lima 2.2.1
    installed with Colima command


OTHER COMMANDS USED:

PULL KALI:
            docker pull kalilinux/kali-rolling

RUN KALI:
            docker run --rm -it kalilinux/kali-rolling /bin/bash

            screenshots/Kali Shell.png

            Figure 1. Kali Linux container running on Apple Silicon.

PULL JUICE SHOP:
                docker pull bkimminich/juice-shop:v20.2.0

RUN JUICE SHOP:
                docker run -d --name juice-shop-test -p 127.0.0.1:3000:3000 bkimminich/juice-shop:v20.2.0
                
                screenshots/Juice Shop Welcome Page.png

                Figure 2. OWASP Juice Shop running in the lab environment.

VERIFICATION RESULTS:

Kali Linux Verification-
OS: Kali GNU/Linux Rolling
Architecture: aarch64
Nmap Check: which nmap returned no result.
Installed Packages: apt list --installed | wc -l returned 80

Juice Shop Verification-
Application loaded successfully at:
http://127.0.0.1:3000
Container status verified with:
docker ps
Result:
127.0.0.1:3000->3000/tcp

ARM64 VERIFICATION-
Kali:
docker inspect kalilinux/kali-rolling --format '{{.Architecture}}'
Result: arm64

Juice Shop:
docker inspect bkimminich/juice-shop:v20.2.0 --format '{{.Architecture}}'
Result: arm64


ISSUES ENCOUNTERED:

1) Rosetta 2 Warning
    When starting Colima with the --vz-rosetta option, the following warning appeared:
        Unable to enable Rosetta: Rosetta2 is not installed
    Colima continued starting successfully despite the warning. Running colima status confirmed that Colima was operating with the following configuration:
        Virtualization: macOS Virtualization.Framework
        Architecture: aarch64
        Runtime: Docker
        Mount type: virtiofs

    Resolution - No immediate change was required. Colima was allowed to continue running natively using the aarch64 architecture. Rosetta can be installed later if testing requires an x86_64/amd64-only container.

