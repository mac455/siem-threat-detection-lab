# SIEM Security Monitoring & Threat Detection Lab

## Project Overview

This project demonstrates the implementation of a comprehensive Security Information and Event Management (SIEM) solution using **Graylog**, **OpenSearch**, and **MongoDB**. The system processes real-time security events, detects sophisticated cyber attacks, and provides security dashboards for visualising security operations using an Ubuntu VM (Virtualbox).

##  Architecture

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

##  Key Achievements

###  Multi-Source Log Ingestion
- Configured **Apache web server** log collection
- Implemented **rsyslog forwarding** to Graylog
- Set up **real-time log processing** pipeline
- Created **custom application log** formats (JSON)

###  Advanced Threat Detection Rules
Developed **8 sophisticated detection rules** :
- **classify_malicious_user_agents_raw** - Detection of malicious user agents
- **classify_normal_traffic** - Classification of legitimate web traffic
- **classify_normal_user_agents_raw** - Identification and classification of legitimate user agents
- **detect_directory_traversal** - Path traversal and file inclusion attack detection
- **detect_scanner_activity** - Vulnerability scanner detection
- **detect_sql_injection** - Advanced SQL injection  detection
- **detect_web_reconnaissance** - Web application reconnaissance detection
- **detect_xss_attack** - Cross-site scripting (XSS) payload detection and analysis

## Data Processing & Field Extraction

#### Manual Field Extractors for Apache Logs:
- **Custom field extractors** for Apache logs:
  - `http_method` (GET, POST, etc.)
  - `http_status` (200, 404, 500, etc.)
  - `user_agent` (Browser/tool identification)
  - `requested_url` (Target endpoint analysis)

#### Pipeline Rule-Generated Fields:
- **Automated field extraction** through detection pipeline rules:
  - `attack_type` (SQL injection, XSS, directory traversal, reconnaissance)
  - `malicious_agent` (Automated security tools and scanners)
  - `normal_agent` (Legitimate browser classifications)

### Dashboards
Created **comprehensive security dashboard** with **4 key visualisations**:

#### 1. Top Attack Types (Pie Chart)
- Visual distribution of different attack categories
- Proportional representation of SQL injection, XSS, directory traversal, and reconnaissance attempts
- Real-time attack type classification and trending
![image](https://github.com/user-attachments/assets/cdf41e19-96be-4924-85e1-ae786200e150)

#### 2. Most Requested URLs (Data Table)
- Horizontal bar chart showing frequently targeted endpoints
- Identification of high-risk application paths
- Attack surface analysis and vulnerability hotspot detection
![image](https://github.com/user-attachments/assets/7fa6f329-9b30-49e8-b00a-79519ff89ad0)

#### 3. Most Used User Agents (Data Table)
- Detailed breakdown of user agent strings and their frequency
- Identification of legitimate browsers vs. automated security tools
- Classification of normal traffic vs. malicious scanning tools
  ![image](https://github.com/user-attachments/assets/d5d081a3-8b93-4e4d-9f13-14a75b14a5f6)
  
#### 4. Total Web Requests (Single Number)
- Real-time counter of total HTTP requests processed
- Overall system activity monitoring
- Baseline establishment for traffic volume analysis
  ![image](https://github.com/user-attachments/assets/2b8329a5-d690-4383-ba44-bdd308324207)


