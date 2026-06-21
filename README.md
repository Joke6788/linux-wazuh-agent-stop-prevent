# 🛡️ Linux Wazuh Agent - Stop Prevention

This project provides a script that prevents the Wazuh Agent from being stopped using `systemctl stop wazuh-agent` on Linux systems.

If the agent crashes or gets killed, it will automatically restart.

---

## 🚀 One-Liner Installation

Run this single command on any Linux machine to deploy:

```bash
curl -sSL https://raw.githubusercontent.com/Joke6788/linux-wazuh-agent-stop-prevent/main/deploy.sh | sudo bash
