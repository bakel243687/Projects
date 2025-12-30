# Small Scale Business
Note: This is a fictional small scale business which I have decides to create an active directory for. This file consists of the process involved in mapping the active directory on Cisco Packet Tracer. This aspect of project is expected to take a week, of which I have spent two days so far

## Technologies Used
- Cisco Packet Tracer

### Setting up the Packet Tracer
To set up the environment for this project, picture the kind of business in question. In this case, it is grocery store with four main end users; Management, IT and 2 in Sales

### Mapping out the store
This may seem quite impractical for some small businesses, yet it is viable especially for bigger companies

Devices used:
- One Router
- One Switch
- Two Servers
- Four PCs

The above devices were used to map out the simple network in Cisco Packet Tracer as seen in the picture below

### Configuring the Devices
#### User/Server Devices
IP addresses were assigned to each PCs and servers through config > FastEthernet0 > IPv4 Configuration. Below are the configurations for all the users:
- PC-Sales - 192.168.10.0/24
- Servers - 192.168.20.0/24
- PC-MGT/PC-IT - 192.168.39.0/24

#### Switch
VLANs were added to the VLAN database to enable the network segmentation. The following VLANs were added:
- VLAN10 - Users
- VLAN20 - Servers
- VLAN30 - MGT/IT

