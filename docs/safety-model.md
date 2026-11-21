# Lab on Silicon Safety Model

## 1. Purpose and Threat Model

Lab on Silicon is a deliberately vulnerable cybersecurity lab designed to run locally on Apple Silicon. The purpose of the lab is to provide a controlled environment for practicing security testing without exposing vulnerable services to outside networks.

The main threat considered by this project is accidental exposure or unauthorized network access. The goal is to prevent the vulnerable Juice Shop target from being exposed to the local or campus network and to prevent the running lab containers from accessing the internet.

The lab is not designed to defend against a determined attacker who already has access to the host machine. Instead, the safety model focuses on keeping the intentionally vulnerable environment contained during normal lab use.

## 2. Defense in Depth

The lab uses multiple controls rather than relying on a single security setting.

| Risk | Mitigation | Verification |
|---|---|---|
| Vulnerable application reachable from the campus LAN | Juice Shop is bound only to `127.0.0.1:3000` | `verify-isolation.sh` test 3 |
| Localhost-published port reachable from other LAN hosts on older Docker versions | Docker Engine 28+ is required and Juice Shop remains bound to loopback | `verify-isolation.sh` test 1 |
| Target or attack container reaching the internet | IP masquerading is disabled on `lab-net` | `verify-isolation.sh` test 6 |
| Accidental tool installation breaking isolation | Egress is disabled by default and the temporary override process is documented | README and `compose.yaml` comment |
| Lab mixing with unrelated containers | Kali and Juice Shop use the dedicated, explicitly named `lab-net` bridge | `verify-isolation.sh` test 2 |
| Non-native emulation hiding architecture or performance issues | Kali and Juice Shop image architecture and Kali runtime architecture are checked | `verify-arch.sh` |

## 3. Accepted Residual Risks

Lab on Silicon runs on a personal machine, so some risks remain even with the isolation controls in place.

For the current MVP, container escape risk is accepted. The lab uses trusted open-source tools and does not mount host directories into the vulnerable Juice Shop container.

The lab also depends on Docker, Colima, and the host operating system to provide the underlying container isolation. These components must remain properly configured for the lab's safety controls to work as intended.

Because Juice Shop is intentionally vulnerable, it should only be used within the controlled lab environment. The verification scripts should be run whenever important network or container configuration changes are made.

## 4. Break-Glass Procedure for Temporary Egress

Outbound internet access on `lab-net` is disabled by default. If internet access is temporarily required inside the running Kali container, such as when installing an additional package, use the following procedure:

1. Open `compose.yaml`.
2. Change `com.docker.network.bridge.enable_ip_masquerade` from `"false"` to `"true"`.
3. Run `make down` followed by `make up` so Docker recreates the network with the temporary setting.
4. Perform the required package installation inside Kali.
5. Change `com.docker.network.bridge.enable_ip_masquerade` back to `"false"`.
6. Run `make down` followed by `make up` again to recreate the isolated network.
7. Run `make verify`.
8. Confirm that the architecture checks pass and that the isolation test reports `OK: isolation model verified.`

Egress should never be left enabled after the temporary maintenance task is complete. A successful `make verify` confirms that the lab has returned to its normal isolated configuration.