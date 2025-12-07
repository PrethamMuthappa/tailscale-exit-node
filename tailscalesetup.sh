#!bin/bash

set -e

echo "------------tailscale installation----------"

#--------------------------
# You need auth key for this process, go to tailscale admin page, select add devices and copy the script which it generates it has the api key in it
#-------------------------

curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=ENTER YOUR AUTH KEY(TAILSCALE DASH->NEW DEVICES->GENERATE SCRIPT AND COPY KEY FROM THAT)

# check if ip forwarding is enabled or not in azure networking inferace 
# YOU NEED TO MANUALLY ENABLE IP FORWARDING IN YOUR NETWORK INTERFACE OF YOUR VPS DASHBOARD, IN MY CASE AZURE
# Set inbount port rule 41641 UDP in azure

if [ $(sysctl -n net.ipv4.ip_forward) -eq 0 ]; then
    echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-tailscale.conf
    sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
fi 

#Enabling nat masquerade
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sudo tailscale up --reset

sudo tailscale up \
  --advertise-exit-node \
  --snat-subnet-routes=true \
  --ssh


