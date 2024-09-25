# ScamWatchNepal Documentation

## Introduction

ScamWatchNepal is an open-source application designed to enhance awareness and protection against scams in Nepal. The primary goal of ScamWatchNepal is to provide real-time notifications and alerts when users encounter suspicious websites, applications, or pages. The app aims to create a community-driven database of known scams, ensuring transparency and reliability through rigorous verification processes.

### Features

#### Current Features
- Real-Time Notifications: Users receive immediate alerts when they visit or attempt to visit a suspicious website, application, or page.
- Community-Driven Database: A centralized, open-source database where users can submit and verify scam reports. Each submission must include proof or a reliable source to ensure accuracy.
- Research and Verification: Before any report is published, it undergoes thorough research and verification to confirm its legitimacy.

#### Future Features
- Web Browser Extension: A browser extension that monitors all links visited or attempted to be visited by the user. The extension will alert the user if a link is identified as suspicious.
- App Monitoring: The ability to monitor installed applications on the user's device for known scams. Alerts will be triggered if a suspicious app is detected.

### Architecture

#### Database
- Schema:
```
Table: Scams
id (Primary Key)
url (Text)
app_name (Text)
description (Text)
proof (Text) - Link to evidence or source
status (Enum: 'pending', 'verified', 'rejected')
submitted_by (Text)
submitted_at (Timestamp)
verified_by (Text)
verified_at (Timestamp)
```

#### Backend
- APIs:
1. Submit Scam Report:
a. Endpoint: /api/submit
b. Method: POST
c. Parameters: url, app_name, description, proof, submitted_by

2. Verify Scam Report:
a. Endpoint: /api/verify
b. Method: POST
c. Parameters: id, verified_by

3. Get Scam Reports:
a. Endpoint: /api/scams
b. Method: GET
c. Parameters: status (optional), limit (optional), offset (optional)

#### Frontend
- User Interface:
1. Home Page: Displays a list of verified scams.
2. Submit Scam Form: Form to submit new scam reports.
3. Verification Dashboard: Admin interface for verifying submitted reports.

#### Web Browser Extension
- Manifest File: Defines the extension's permissions and content scripts.
- Content Script: Monitors URL changes and checks against the scam database. Triggers alerts if a suspicious URL is detected.

#### Mobile App
- Features: Real-time notifications for suspicious URLs and apps. User interface for submitting and viewing scam reports. Integration with the backend API for data synchronization.

### Development Process

#### Initial Development
- Database Setup
- Backend Development
- Frontend Development
- Testing

#### Community Involvement
- Contribute to the Database:
- Feedback and Improvements:


#### Future Development
- Web Browser Extension
- Mobile App
- Enhanced Monitoring

#### Security
- Data Encryption

#### Open Source
- Repository
- Documentation

### Contact
For more information or to get involved, please contact:
- Email: dcozupadhyay@gmail.com
- Website: https://scamwatchnepal.github.io
- GitHub: https://github.com/diggajupadhyay/scam_watch_nepal

### License : ScamWatchNepal is released under the MIT License. See the LICENSE file for details.

This documentation provides a comprehensive overview of the ScamWatchNepal application, including its features, architecture, development process, and future plans. We welcome contributions from the community to help make ScamWatchNepal a valuable resource for protecting people in Nepal from scams.
