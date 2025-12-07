# tailscale-exit-node
Script to set up tailscale in your vps to use an a vpn exit node

A very simple script which will install tailscale to ur vps server and use that as an private vpn by making it as an exit node

- log in to tailscale admin dashboard to get the api key and open the script file and edit the api key line
- set up port forwarding in azure dash board
- set inbound port rules to 41641 UDP in azure

Rest of things which the vpn is supposed to have the bash script will set it up

After this you will see your server name appear in the list of machine in tailscale dashboard, you need to click on your machine and click set as exit node!
