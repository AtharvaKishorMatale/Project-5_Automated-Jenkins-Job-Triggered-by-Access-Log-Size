# Project 5: Automated Jenkins Job Triggered by Access Log Size

## Project Title
**Automated Jenkins Job Triggered by Access Log Size**

## Objective
Proactively manage disk usage by automating log archival to S3 using Jenkins when log size exceeds **1 GB**.

## Services & Tools Used
- **Automation:** Jenkins
- **Storage:** Amazon S3
- **OS:** Ubuntu Server
- **Dependency:** Java

## Implementation Highlights

### Continuous Monitoring
- Script continuously checks size of `/var/log/custom/access.log`

### Conditional Triggering
- Jenkins job triggered when log size ≥ 1 GB

### Jenkins Pipeline
- **Archival:** Uploads log file to S3
- **Cleanup:** Clears local log file
- **Notification:** Sends completion email

### Secure Permissions
- IAM configured with minimum permissions required by Jenkins
