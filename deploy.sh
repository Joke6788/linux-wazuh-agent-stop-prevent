#!/bin/bash
# deploy.sh - Wazuh Agent Stop Prevention

set -e

echo "============================================"
echo "Wazuh Agent - Stop Prevention Deployment"
echo "============================================"

# Check root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root (use sudo)"
    exit 1
fi

# Check Wazuh Agent
if ! systemctl list-units --full -all | grep -q "wazuh-agent.service"; then
    echo "❌ Wazuh Agent is not installed!"
    echo "Please install Wazuh Agent first."
    exit 1
fi

echo "✅ Wazuh Agent found"



echo "📁 Creating override.conf..."
mkdir -p /etc/systemd/system/wazuh-agent.service.d/

cat > /etc/systemd/system/wazuh-agent.service.d/override.conf << 'EOF'
[Service]
Restart=always
RestartSec=3

[Unit]
RefuseManualStop=yes
EOF



echo "✅ override.conf created successfully"

# Reload systemd
echo "🔄 Reloading systemd..."
systemctl daemon-reload

# Restart Wazuh Agent
echo "🔄 Restarting Wazuh Agent..."
systemctl restart wazuh-agent

# Verify
echo ""
echo "✅ Deployment Complete!"
echo ""
echo "📌 Verify with:"
echo "   sudo systemctl cat wazuh-agent"
echo ""
echo "📌 Test stop prevention:"
echo "   sudo systemctl stop wazuh-agent"
echo "   (Should show 'Operation refused')"
echo ""
echo "📌 To revert:"
echo "   sudo rm -rf /etc/systemd/system/wazuh-agent.service.d/"
echo "   sudo systemctl daemon-reload"
echo "   sudo systemctl restart wazuh-agent"
