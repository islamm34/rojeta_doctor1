# Support Contact & Admin Chat API Documentation

## Overview

This document specifies the backend API requirements for the **Support Contact Information** and **Admin Support Chat** feature in the Rojeta Doctor / Provider Ecosystem.

This service serves all provider roles:

- Doctors
- Laboratory Providers
- Radiology Centers
- Nursing Agencies
- Hospitals

---

## Authentication

All requests (except public info if configured) must include the standard Bearer token in the `Authorization` header:

```http
Authorization: Bearer <auth_token>
Accept: application/json
```

---

## 1. Get Support Contact Information

Retrieves the official customer support and administrative hotline details, operating hours, and live support availability.

- **Endpoint**: `GET /api/v1/support/contact`
- **Rate Limit**: Standard user rate limit (e.g., 60 req/min)

### Request

No request body required.

### Response (200 OK)

```json
{
  "status": true,
  "message": "Support contact details retrieved successfully",
  "data": {
    "email": "support@rojeta.com",
    "phone": "+20 100 000 0000",
    "available_hours": "9:00 AM - 6:00 PM (Daily)",
    "average_response_time": "5 mins",
    "admin_id": "admin_support",
    "admin_name": "Rojeta Support Team",
    "admin_avatar": "https://rojeta.fassla.net/storage/avatars/support_avatar.png"
  }
}
```

### Fields Specification

| Field | Type | Nullable | Description |
| :--- | :--- | :--- | :--- |
| `email` | String | Yes | Official support email address |
| `phone` | String | Yes | Support hotline phone number (international format) |
| `available_hours` | String | Yes | Formatted operating hours string (e.g. `9:00 AM - 6:00 PM`) |
| `average_response_time` | String | Yes | Estimated response time (e.g. `5 mins`) |
| `admin_id` | String | Yes | Unique ID for the designated admin/support account |
| `admin_name` | String | Yes | Display name for the support team |
| `admin_avatar` | String | Yes | URL for the support team avatar/logo |

---

## 2. Initialize / Retrieve Admin Support Conversation

Initializes or fetches the one-on-one support conversation between the authenticated provider and the administrative support team.

- **Endpoint**: `POST /api/v1/support/chat/admin` (or `GET /api/v1/support/chat/admin`)
- **Headers**: `Authorization: Bearer <auth_token>`

### Request

No request body required (the server extracts the authenticated user from the token).

### Response (200 OK / 201 Created)

```json
{
  "status": true,
  "message": "Admin conversation retrieved successfully",
  "data": {
    "id": "admin_support_conv_123",
    "patient_id": "admin",
    "patient_name": "Rojeta Support Team",
    "patient_avatar": "https://rojeta.fassla.net/storage/avatars/support_avatar.png",
    "last_message": "Hello, how can we help you today?",
    "last_message_at": "2026-09-22T10:00:00Z",
    "unread_count": 0
  }
}
```

---

## 3. Chat Messaging Endpoints (Shared Chat Infrastructure)

The admin support conversation reuses the existing chat messaging endpoints:

### 3.1. Fetch Conversation Messages

- **Endpoint**: `GET /api/v1/doctor/chat/messages?conversation_id={conversation_id}&page={page}&limit={limit}`
- **Response (200 OK)**:

```json
{
  "status": true,
  "message": "Messages fetched successfully",
  "data": [
    {
      "id": "msg_001",
      "sender_id": "admin",
      "sender_role": "admin",
      "content": "Welcome to Rojeta Support! How can we assist you with your clinic setup?",
      "created_at": "2026-09-22T10:00:00Z",
      "is_me": false
    },
    {
      "id": "msg_002",
      "sender_id": "doc_456",
      "sender_role": "doctor",
      "content": "Hi, I have a question regarding the settlement cycle.",
      "created_at": "2026-09-22T10:01:30Z",
      "is_me": true
    }
  ]
}
```

### 3.2. Send Message

- **Endpoint**: `POST /api/v1/doctor/chat/send-message`
- **Request Body**:

```json
{
  "conversation_id": "admin_support_conv_123",
  "content": "Thank you, that solved my issue."
}
```

- **Response (201 Created)**:

```json
{
  "status": true,
  "message": "Message sent successfully",
  "data": {
    "id": "msg_003",
    "sender_id": "doc_456",
    "sender_role": "doctor",
    "content": "Thank you, that solved my issue.",
    "created_at": "2026-09-22T10:05:00Z",
    "is_me": true
  }
}
```

### 3.3. Mark Conversation Messages as Read

- **Endpoint**: `POST /api/v1/doctor/chat/mark-read`
- **Request Body**:

```json
{
  "conversation_id": "admin_support_conv_123"
}
```

- **Response (200 OK)**:

```json
{
  "status": true,
  "message": "Messages marked as read"
}
```

---

## 4. Error Responses

All endpoints adhere to the standard JSON error structure:

### 401 Unauthorized

```json
{
  "status": false,
  "message": "Unauthenticated"
}
```

### 500 Internal Server Error

```json
{
  "status": false,
  "message": "An unexpected error occurred. Please try again later."
}
```
