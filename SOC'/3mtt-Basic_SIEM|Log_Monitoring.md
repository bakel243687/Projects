# Enterprise SOC Monitoring & Detection Engineering Lab

## 3MTT Cybersecurity Project

---

## Project Overview

As part of my 3MTT cybersecurity development journey, I built a simulated enterprise Security Operations Center (SOC) environment to develop practical experience in security monitoring, detection and incident investigation.

The project builds on an existing virtualized enterprise environment containing Windows Server, Active Directory, Windows endpoints and Linux systems.

The objective was to move beyond simply configuring infrastructure and begin monitoring what happens within it from a security operations perspective.

Wazuh was deployed as the centralized SIEM and security monitoring platform, while Sysmon was used to provide additional endpoint telemetry on Windows systems.

The final environment allows security events from multiple systems to be collected, analysed and investigated from a centralized dashboard.

---

# Problem Statement

Organizations generate large amounts of security-related data from endpoints, servers, authentication systems and network infrastructure.

Without centralized monitoring, identifying suspicious activity can become difficult because security events are distributed across individual systems.

For this project, I wanted to simulate this problem within a controlled enterprise environment.

The goal was to answer:

> How can a small organization centralize security telemetry, detect suspicious activity and investigate security events across Windows and Linux systems?

---

# Project Objectives

The project was designed to:

- Deploy a centralized SIEM environment.
- Monitor Windows and Linux endpoints.
- Collect Windows Security and Event Viewer logs.
- Integrate Sysmon for enhanced endpoint visibility.
- Monitor Active Directory security activity.
- Generate controlled security events.
- Analyse events using Wazuh.
- Map security activity to MITRE ATT&CK.
- Develop a foundation for detection engineering.
- Practice SOC investigation and threat hunting.
- Document the deployment, issues and solutions.

