# Small Scale Business
Note: This is a fictional small scale business which I have decides to create an active directory for. This file consists of the process involved in mapping the active directory on Cisco Packet Tracer. This aspect of project is expected to take a week, of which I have spent two days so far

## Project Overview
This project simulates the network infrastructure of a small-scale sales company as a foundation for a future Active Directory deployment. Cisco Packet Tracer is used to design and validate the logical and physical topology before implementing the environment in a real virtual lab.

The design follows a router-on-a-stick architecture, where multiple VLANs share a single router interface using IEEE 802.1Q trunking.

## Design Objective
- Logical separation of users, servers, and IT management
- Centralized routing and policy enforcement
- Realistic small-company topology
- Clean foundation for Active Directory and security controls

## Network Topology Overview
Architecture Type: Router-on-a-Stick
Simulation Tool: Cisco Packet Tracer

Physical Layout
Internet / Cloud
        |
   RTR-EDGE-01
        |
     (Trunk)
        |
    SW-CORE-01
     |    |    |
 VLAN10 VLAN20 VLAN30
 Users  Servers   IT

## Technologies Used
- Cisco Packet Tracer

### Setting up the Packet Tracer
To set up the environment for this project, picture the kind of business in question. In this case, it is grocery store with four main end users; Management, IT and 2 in Sales

### Mapping out the store
This may seem quite impractical for some small businesses, yet it is viable especially for bigger companies

**Devices used:**
**Router**
- Model: Cisco ISR 2911 (or 1941)
- Hostname: RTR-EDGE-01
- Role:
    - Default gateway for all VLANs
    - Inter-VLAN routing
    - Future ACL and security enforcement point

**Switch**
- Model: Cisco Catalyst 2960
- Hostname: SW-CORE-01
- Role:
    - VLAN segmentation
    - Access layer for all end devices
    - Trunk connection to router

**Servers**
- SRV-DC01 — Planned Domain Controller & DNS
- SRV-FS01 — File Server

**End-User Devices**
- Sales PCs (e.g., PC-SALES-01)
- IT Admin PC (PC-IT-01)

The above devices were used to map out the simple network in Cisco Packet Tracer as seen in the picture below

### Configuring the Devices
#### User/Server Devices
IP addresses were assigned to each PCs and servers through config. 

**VLAN and IP Addressing Scheme**

| VLAN ID | VLAN Name     | Subnet          | Default Gateway |
| ------- | ------------- | --------------- | --------------- |
| 10      | USERS         | 192.168.10.0/24 | 192.168.10.1    |
| 20      | SERVERS       | 192.168.20.0/24 | 192.168.20.1    |
| 30      | IT-MANAGEMENT | 192.168.30.0/24 | 192.168.30.1    |


#### Switch
VLANs were added to the VLAN database to enable the network segmentation. The following VLANs were added:
- VLAN10 - Users
- VLAN20 - Servers
- VLAN30 - MGT/IT

**Note: after each line, you enter to register your command before moving to the next line of command**

**VLAN Creation**
```
enable
configure terminal

vlan 10
 name USERS
vlan 20
 name SERVERS
vlan 30
 name IT-MANAGEMENT
exit
```

Access Port Assignment
```
interface fastEthernet0/1
 switchport mode access
 switchport access vlan 10

interface fastEthernet0/10
 switchport mode access
 switchport access vlan 20

interface fastEthernet0/15
 switchport mode access
 switchport access vlan 30
```

**Trunk Port to Router**
```
interface gigabitEthernet0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
 no shutdown
```

#### Router
**Enable Physical Interface**
```
enable
configure terminal

interface gigabitEthernet0/0
 no shutdown
exit
```

**Subinterface Configuration (Router-on-a-Stick)**
**VLAN 10 — Users**
```
interface gigabitEthernet0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0
```
**VLAN 20 — Servers**
```
interface gigabitEthernet0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0
```

**VLAN 30 — IT Management**
```
interface gigabitEthernet0/0.30
 encapsulation dot1Q 30
 ip address 192.168.30.1 255.255.255.0
```

**Save Configuration**
```
end
write memory
```

End Device IP Configuration
User PC (Sales Example)

IP Address: 192.168.10.10

Subnet Mask: 255.255.255.0

Default Gateway: 192.168.10.1

Server Example

IP Address: 192.168.20.10

Subnet Mask: 255.255.255.0

Default Gateway: 192.168.20.1

IT Admin PC

IP Address: 192.168.30.10

Subnet Mask: 255.255.255.0

Default Gateway: 192.168.30.1

**Verification and Testing**
**Router Verification**
```show ip interface brief```
