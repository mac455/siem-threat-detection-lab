# SIEM Security Monitoring & Threat Detection Lab

## Project Overview

This project demonstrates the implementation of a comprehensive Security Information and Event Management (SIEM) solution using **Graylog**, **OpenSearch**, and **MongoDB**. The system processes real-time security events, detects sophisticated cyber attacks, and provides executive-level security dashboards for enterprise security operations.

## 🏗️ Architecture

```
Web Traffic → Apache Logs → rsyslog → Graylog → OpenSearch → Security Dashboards
                                    ↓
                            Detection Rules & Alerts
```

**Technology Stack:**
- **SIEM Platform:** Graylog 4.3.x
- **Search Engine:** OpenSearch
- **Database:** MongoDB 4.4.18
- **Log Sources:** Apache Web Server, Custom Applications
- **Operating System:** Ubuntu (VirtualBox VM)

## 🎯 Key Achievements

### ✅ Multi-Source Log Ingestion
- Configured **Apache web server** log collection
- Implemented **rsyslog forwarding** to Graylog
- Set up **real-time log processing** pipeline
- Created **custom application log** formats (JSON)
