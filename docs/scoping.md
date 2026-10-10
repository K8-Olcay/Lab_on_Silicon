**Problem Statement**

Cybersecurity labs often rely on exposed virtual machines running inside VirtualBox, and this may work well for Intel-based computers, but it creates many challenges for Apple Silicon. Apple Silicon Macs use the ARM64 architecture and most security lab environments were designed for AMD64/x86 systems, which causes compatibility issues. M series MAC users face problems with architecture mismatches, virtualization support, and if tools and targets run natively, require emulation, or fail completely. Modern containers, like Docker, can provide a more flexible alternative. Docker supports ARM64 compatible images and also allows some AMD64 workloads to run through Rosetta based translation when needed. Yet, many existing security labs treat Apple Silicon compatibility as an afterthought and don't give much guidance on native support, emulation requirements, or even expected behavior.
This project aims to create and document an Apple Silicon first and foremost security lab using Colima, Docker, Kali Linux containers, and OWASP Juice Shop. The goal is to provide reproducible learning environment that supports OWASP top 10 exercises while clearly documenting compatibility, deployment, and security considerations for ARM64 systems.

**Related Work**

*WebSploit*
Provides a Cybersecurity training environment that contains numerous intentionally vulernable applications running in Docker containers. It includes targets such as OWASP Juice Shop, DVWA, WebGoat, some additional custom training labs, and numerous cybersecurity resources and exercises. It starts with users cloning the repository and running the installation script. Docker containers are then deployed as a part of the setup process. The project documentation indicates support for Apple Silicon (M1-M4) systems and includes ARM64 troubleshooting. Some gaps are that you would need a large setup environment before you could start working on the exercises, and while support is available, its not specifically geared around ARM64 compatibility and you have to search through different sections to know which components work natively and which ones may need additional configuration.
https://github.com/the-art-of-hacking/websploit 10/8/26

*HackingLab*
Provides a containerized security training environment for pentesting, vulnerability research, and CTF practice. It also provides tools like Kali Linux, Metasploit, NMAP, Wireshark etc.. that support pentesting, vulnerability scanning, network analysis, and web app testing. It also provides Web App vulnerable targets like DVWA, WebGoat, OWASP Juice shop, and many more. It covers many topics from SQL injections to vulnerabilities to OWASP Top 10. It deploys using Docker containers and the prerequisites are a Docker Desktop and Git. After cloning the repository it is launched with Docker Compose. There isn't any explicit documentation about Apple Silicon, ARM64 support or any architecture specific requirements, so it may potentially run natively or require emulation. Some positives are that it allows users to start only the resources they need, includes a lot of vulnerability web apps, and covers OWASP Top 10. It does lack compatibility guidance and what runs natively and what doesn't. It also takes up a lot of system resources, and with lack of documentation and with so many tools, it maybe a little overwhelming for beginners.
https://github.com/herson/hackinglab 10/9/26

*Vuln Apps Tronic*
Provides a Docker based cybersecurity lab and has many vulnerable web apps and API's for practicing security in a controlled environment. It includes targets like DVWA, OWASP Juice shop and more. It covers categories like OWASP10, vulnerabilities, security and SQL injection. It is started by cloning the Git repository and then initializing the submodules, and then deploying through Docker compose. There is no explicit documentation about Apple Silicon/ARM64 compatibility, the lab is Docker based but doesn't mention what is ARM64 native or what needs emulation. Some positives are that its easy to deploy using a single command, many vulnerable apps, uses Docker compose profiles to reduce storage, and is safer using local host only. I really liked the profile based structure, it is very organized and includes Notes, troubleshooting and a quick setup. Gaps again include a lack of explicit Apple Silicon documentation, Arm64 support is listed as a future roadmap item and no compatibility guidance with what runs natively and what needs emulation.
https://github.com/GitAddRemote/vuln-app-tronic 10/9/26

*HackMeIfYouCan*
Provides a self hosted web app security training platform with 33 vulnerable labs covering all OWASP Top 10 categories. It includes a central dashboard, built in request repeater, hint system, progress tracking, and vulnerability targets to allow users to practice security with SQL injection, SSRF, authentication, and authorization. It is started by cloning the Git repository and deployed using Docker and Docker compose. The documentation does not provide specific information about Apple Silicon / ARM64 compatibility, and does not say what runs natively and what needs emulation. I like the learning design with progressive difficulty levels, the central dashborad is also a nice touch to help keep things simple, and the README includes a clear setup and usage directions. It again lacks Apple Silicon / ARM64 documentation and doesn't say if the containers are ARM64 native or if it requires emulation. It doesn't mention memory requirements but it may need a lot of resources for all 33 labs.
https://github.com/enm251/HackMeIfYouCan 10/9/26

*Lorikeet OWASP Top 10 Labs*
Provides a collection of 10 vulnerable LAMP stack lab environments for practicing web application security testing. Each lab is containerized with Docker for easy deployment and isolation. It is started by cloning the Git repository and launching an individual lab using Docker Compose. Each lab contains its own Dockerfile and docker-compose.yml file, allowing the environments to be deployed independently. The documentation does not provide any information regarding Apple Silicon, ARM64 compatibility, multi architecture images, or emulation requirements. The labs are containerized with Docker, but there is no indication of whether they have been tested on ARM64 systems or if any images require x86 emulation. It is simple and easy to use. Each lab can be deployed independently using Docker Compose, making it easier to focus on a single topic without the overhead of a larger platform. It lacks Apple Silicon / ARM64 documentation and doesn't say if the containers are ARM64 native or if it requires emulation, it offers fewer labs, and doesn't have some of the user friendly features like a central dashboard.
https://github.com/Lorikeet-Security/owasp-top-10-labs-lamp-dockerized 10/9/26

*OWASP VulnerableApp*
It is a cybersecurity training platform that provides intentionally vulnerable web applications for security testing and learning. It allows users to practice finding vulnerabilities, experiment with security tools, and test how well vulnerability scanners detect security issues. It can be started by cloning the Git repository and running the app through Docker Compose. It can also be run as a standalone Java application using the released JAR file. There is no documentation or specific information regarding Apple Silicon compatibility, ARM64 native support, or emulation requirements. One of the project's strengths is its ability to provide repeatable security testing scenarios. Users can practice the same vulnerabilities multiple times, experiment with different security tools, and compare the results. The Docker Compose deployment also helps create a consistent and easy to manage testing environment. It does not provide explicit Apple Silicon or ARM64 compatibility documentation. It also focuses heavily on vulnerability benchmarking and security testing rather than providing guided educational content, dashboards, hint systems, or structured learning paths found in some other cybersecurity training platforms.
https://github.com/SasanLabs/VulnerableApp 10/9/26

*OWASP JuiceShop*
It is an intentionally vulnerable web app designed for cybersecurity training, CTF competitions, and security testing. It provides over 100 challenges covering vulnerabilities from the OWASP Top 10 and other real world web apps security flaws. The platform includes tutorials, hints, progress tracking, scoreboards, and challenge based learning for users of different skill level. It can be started by cloning the GitHub repository and running the app locally or through Docker. Docker is one of the main deployment methods documented by the project. The documentation does not give specific guidance about Apple Silicon compatibility, ARM64 native support, or emulation requirements. It does have a large learning environment and it includes over 100 challenges, built in tutorials, hints, progress tracking, and a scoreboard that helps users monitor their progress. It also supports beginners through guided learning while still providing enough advanced challenges for experienced users. The project is widely recognized and covers a broad range of OWASP Top Ten security concepts. However it focuses on a single vulnerable web app rather than providing multiple separate lab environments. It also does not provide explicit Apple Silicon or ARM64 compatibility documentation. It does offer extensive training content, but it does not focus on documenting native ARM64 support, emulation requirements, or Apple Silicon deployment considerations.
https://github.com/juice-shop/juice-shop 10/10/26

**Gap Analysis**

| **GAP IDENTIFIED**                                                                                                  | **EVIDENCE**                                                                                                                                                                                                               | **PROJECT CONTRIBUTION**                                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Apple Silicon is treated as an afterthought rather than a design constraint.                                        | HackingLab, HackMeIfYouCan, OWASP Top 10 Labs, OWASP VulnerableApp, and OWASP Juice Shop provide Docker deployments but do not include dedicated Apple Silicon guidance or ARM64 documentation.                            | Lab_on_Silicon is designed specifically for Apple Silicon systems and validates deployment on ARM64 hardware from the beginning of the project.                                  |
| No clean, single-place compatibility matrix showing what runs native vs. emulated vs. broken.                       | None of the reviewed projects provide a compatibility matrix explaining what runs natively on ARM64, what requires emulation, or what fails entirely.                                                                      | Lab_on_Silicon could document compatibility status for every tool and target so users understand expected behavior before deployment.                                            |
| Labs provide compose files but little pedagogical structure                                                         | Many projects provide vulnerable applications and challenges, but most focus primarily on deployment and exploitation. Few consistently connect objectives, attack steps, evidence collection, and remediation guidance.   | Lab_on_Silicon could pair each OWASP category with learning objectives, attack procedures, evidence collection, and remediation explanations.                                    |
| Almost everyone skips A09: Security Logging and Monitoring Failures because it's about detection, not exploitation. | Most reviewed environments really stress exploitation focused vulnerabilities such as SQL injection, XSS, and authentication bypasses. Security monitoring and detection concepts are less conspicuous.                    | Lab_on_Silicon could intentionally incorporate A09 activities so learners can practice detection, logging, monitoring, and evidence analysis in addition to offensive testing.   |
| Weak or unproven isolation claims                                                                                   | Many projects recommend running locally or in Docker containers but provide limited discussion of network isolation, container boundaries, or exposure risks.                                                              | Lab_on_Silicon could adopt an isolation by default approach and documents how vulnerable targets are restricted to the local lab environment.                                    |
| Existing projects rarely combine ARM64 compatibility guidance with OWASP training content.                          | Some projects provide strong training features (HackMeIfYouCan), while others provide strong Docker organization (Vuln Apps Tronic), but none combine OWASP training with Apple Silicon specific compatibility validation. | Lab_on_Silicon could combine OWASP focused learning, Docker deployment, ARM64 testing, compatibility documentation, and reproducible setup instructions in a single environment. |
| Dependence on Docker without Apple Silicon specific guidance.                                                       | Most reviewed projects rely on Docker and Docker Compose for deployment but provide little information about ARM64 compatibility, native execution, or emulation requirements on Apple Silicon systems.                    | Lab_on_Silicon could Apple Silicon deployment procedures, validates ARM64 compatibility, and explains when native execution or emulation is required.                            |
| Beginner guidance is often limited.                                                                                 | Many projects provide vulnerable targets and deployment instructions but assume prior cybersecurity knowledge.                                                                                                             | Lab_on_Silicon could provide guided exercises, clear learning objectives, attack instructions, evidence collection steps, and remediation discussions for each OWASP category.   |

**Requirements**

MUST HAVE
- Colima and Docker running natively on Apple Silicon (ARM64)
- A Kali Linux attack container and OWASP Juice Shop target running on a private Docker network
- OWASP Juice Shop accessible only through 127.0.0.1
- Automation scripts:
    - make up
    - make reset
    - make verify
    - make status
- One documented challenge for each OWASP Top 10 (2021) category
- Clear learning objectives, attack steps, evidence collection requirements, and remediation guidance for each challenge
- Public GitHub repository containing:
    - README
    - License
    - Architecture Documentation
    - Setup Instructions
- Beginner friendly documentation explaining installation and lab usage
- Verification that all included components function on Apple Silicon

SHOULD HAVE
- Apple Silicon compatibility matrix showing:
    - Native ARM64 support
    - Emulated support
    - Unsupported components
- A 3-5 minute demonstration video
- A second vulnerable target such as DVWA
- Screenshots and walkthrough examples for beginners
- Quick troubleshooting documentation for common setup problems
- Architecture diagrams showing network isolation and container relationships

COULD HAVE
- Custom A09 Security Logging and Monitoring Failures module
- bWAPP running under emulation when native support is unavailable
- CI pipeline to validate deployments automatically
- Additional vulnerable applications beyond Juice Shop and DVWA
- Automated lab health checks and reporting
- Interactive challenge tracking dashboard
- Guided walkthrough videos for individual OWASP categories

Lab_on_Silicon is an Apple Silicon first OWASP Top 10 security testing environment designed for students and beginners. The project focuses on providing a reproducible ARM64 compatible lab built with Colima, Docker, Kali Linux, and OWASP Juice Shop. The primary objective is to create a secure, isolated environment that allows users to complete one challenge from each OWASP Top 10 category while following clear learning objectives, attack instructions, evidence collection requirements, and remediation guidance. Rather than supporting every possible security tool or vulnerable application, the MVP prioritizes Apple Silicon compatibility, simplicity, reproducibility, and beginner friendly learning materials.

**APPENDIX A: TOOLCHAIN RECCONAISSANCE** 

A.1 Colima
- Supports installation through Homebrew
- Supports Apple Silicon (ARM64)
- Supports Apple's Virtualization Framework using --vm-type vz
- Supports Rosetta translation using --vz-rosetta
- Provides an open source alternative to Docker Desktop
- Does not require Docker Desktop's commercial licensing model

COMMANDS: 
- brew install colima docker
- colima start --vm-type vz --vz-rosetta
- docker ps

https://github.com/abiosoft/colima


A.2 Kali Linux 
- kalilinux/kali-rolling is the recommended Docker image
- The image is maintained by the Kali Linux project
- The image uses the Kali rolling release repository and receives regular updates
- Kali containers can be used as security testing and attack environments within Docker
- Kali's documentation notes that Docker images do not include the default Kali toolset by default, so additional tools may need to be installed manually
- Tools likely needed for this project include:
    - nmap
    - curl
    - sqlmap
    - hydra

COMMANDS:
- docker pull kalilinux/kali-rolling
- apt update && apt -y install kali-linux-headless
https://www.kali.org/docs/containers/


A.3 Juice Shop
- OWASP Juice Shop is an intentionally vulnerable web application designed for security education and testing.
- The project includes challenges associated with the OWASP Top 10
- Docker deployment is officially supported
- The Juice Shop Docker image is published as a multi-architecture image and Apple Silicon systems can automatically pull the ARM64 version of the image during deployment
- Juice Shop was selected as the primary vulnerable target because it supports Docker deployment and aligns with the project's Apple Silicon requirements

COMMANDS:
- docker pull bkimminich/juice-shop
- docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop

https://github.com/juice-shop/juice-shop

A.4 Docker Compose
- Docker Compose is used to simplify deployment and management of multiple containers
- The project will use Docker Compose v2
- Docker Compose profiles allow groups of services to be enabled or disabled as needed
- Services assigned to a profile only start when that profile is activated
- Profiles can help support future expansion without requiring all lab components to run at the same time

COMMANDS:
- docker compose up -d
- docker compose ps
- docker compose down
- docker compose --profile extras up -d

https://docs.docker.com/compose/