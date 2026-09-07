# Rojeta Provider Apps — Backend API Integration Specification

This document defines the REST API integration contracts and payload specifications for the **Rojeta Provider Application** (Doctor, Hospital, Lab & Radiology, Nursing Care). It addresses core synchronization requirements between the Patient mobile app, the Provider mobile app, and the backend services.

---

## 1. General Architectural Standards

### 1.1 Base Configuration

- **Base URL:** `https://rojeta.fassla.net/api/v1`
- **Default Headers:**

  ```http
  Accept: application/json
  Content-Type: application/json
  Authorization: Bearer <JWT_TOKEN>
  ```

### 1.2 Response Envelope

All API responses must follow this consistent envelope structure:

#### Success Response

```json
{
  "status": true,
  "message": "Operation completed successfully",
  "data": {}
}
```

#### Paginated Response

```json
{
  "status": true,
  "message": "Data retrieved successfully",
  "data": {
    "current_page": 1,
    "data": [
      { "id": 101, "name": "..." }
    ],
    "first_page_url": "https://.../api/v1/doctor/appointments?page=1",
    "from": 1,
    "last_page": 5,
    "last_page_url": "https://.../api/v1/doctor/appointments?page=5",
    "next_page_url": "https://.../api/v1/doctor/appointments?page=2",
    "path": "https://.../api/v1/doctor/appointments",
    "per_page": 15,
    "prev_page_url": null,
    "to": 15,
    "total": 75
  }
}
```

#### Error Response (Validation / 422)

```json
{
  "status": false,
  "message": "The given data was invalid.",
  "errors": {
    "phone": [
      "The phone number has already been taken."
    ]
  }
}
```

---

## 2. Authentication & Identity Sync (TC-017, TC-019)

### 2.1 Sign Up / Register

- **Endpoint:** `POST /auth/register`
- **Request Body:**

  ```json
  {
    "name": "Dr. Ahmed Mansour",
    "first_name": "Ahmed",
    "second_name": "Mansour",
    "phone": "01012345678",
    "email": "ahmed.mansour@example.com",
    "password": "SecretPassword123",
    "password_confirmation": "SecretPassword123",
    "role": "doctor", // "doctor" | "hospital" | "lab" | "radiology" | "nursing"
    "specialty": "Cardiology",
    "title": "Consultant Cardiologist",
    "gender": "male"
  }
  ```

- **Response (201 Created / 200 OK):**

  ```json
  {
    "status": true,
    "message": "Registration successful. OTP sent.",
    "data": {
      "user": {
        "id": 142,
        "name": "Dr. Ahmed Mansour",
        "first_name": "Ahmed",
        "second_name": "Mansour",
        "phone": "01012345678",
        "email": "ahmed.mansour@example.com",
        "role": "doctor",
        "specialty": "Cardiology",
        "title": "Consultant Cardiologist",
        "avatar": "https://rojeta.fassla.net/storage/avatars/default.png"
      },
      "token": "1|eyJhbGciOiJIUzI1NiIsInR5cCI6..."
    }
  }
  ```

### 2.2 Verify OTP

- **Endpoint:** `POST /auth/verify-otp`
- **Request Body:**

  ```json
  {
    "phone": "01012345678",
    "otp": "1234"
  }
  ```

- **Response:**

  ```json
  {
    "status": true,
    "message": "Phone verified successfully.",
    "data": {
      "user": {
        "id": 142,
        "name": "Dr. Ahmed Mansour",
        "phone": "01012345678",
        "email": "ahmed.mansour@example.com",
        "role": "doctor"
      },
      "token": "2|eyJhbGciOi..."
    }
  }
  ```

### 2.3 Login

- **Endpoint:** `POST /auth/login`
- **Request Body:**

  ```json
  {
    "phone": "01012345678",
    "password": "SecretPassword123"
  }
  ```

- **Response:**

  ```json
  {
    "status": true,
    "message": "Login successful.",
    "data": {
      "user": {
        "id": 142,
        "name": "Dr. Ahmed Mansour",
        "first_name": "Ahmed",
        "second_name": "Mansour",
        "phone": "01012345678",
        "email": "ahmed.mansour@example.com",
        "role": "doctor",
        "specialty": "Cardiology",
        "title": "Consultant Cardiologist",
        "avatar": null
      },
      "token": "3|eyJhbGciOi..."
    }
  }
  ```

### 2.4 Doctor Profile Details & Persistence

- **Endpoint:** `GET /doctor/profile` (or `GET /auth/profile`)
- **Response:**

  ```json
  {
    "status": true,
    "data": {
      "id": 142,
      "full_name": "Dr. Ahmed Mansour",
      "email": "ahmed.mansour@example.com",
      "phone": "01012345678",
      "specialty": "Cardiology",
      "title": "Consultant Cardiologist",
      "bio": "Experienced cardiologist with over 15 years in interventional cardiology.",
      "avatar": "https://rojeta.fassla.net/storage/avatars/doctor_142.jpg",
      "clinics": [
        {
          "id": 1,
          "name": "Al-Amal Medical Center",
          "phone": "0223456789",
          "governorate": "Cairo",
          "city": "Nasr City",
          "full_address": "Building 12, Abbas Al-Aqqad St, Nasr City",
          "consultation_time": 30,
          "clinic_visit_price": 350.00,
          "follow_up_price": 150.00,
          "home_visit_price": 600.00,
          "video_call_price": 300.00,
          "working_hours": {
            "sat": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "sun": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "mon": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "tue": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "wed": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "thu": { "is_open": true, "start": "10:00 AM", "end": "08:00 PM" },
            "fri": { "is_open": false, "start": "09:00 AM", "end": "05:00 PM" }
          }
        }
      ]
    }
  }
  ```

- **Update Profile:** `PUT /doctor/profile` (or `POST /doctor/profile/update`)
- **Request Body:**

  ```json
  {
    "full_name": "Dr. Ahmed Mansour",
    "email": "ahmed.mansour@example.com",
    "phone": "01012345678",
    "specialty": "Cardiology",
    "title": "Senior Consultant Cardiologist",
    "bio": "Updated bio text..."
  }
  ```

---

## 3. Patient Bookings & Synchronization (TC-022)

When a patient books an appointment via the Patient App, the record must be immediately accessible to the assigned provider.

### 3.1 Fetch Provider Appointments

- **Endpoint:** `GET /doctor/appointments`
- **Query Parameters:**
  - `page`: int (e.g., `1`)
  - `limit`: int (e.g., `15`)
  - `status`: string (e.g., `Pending`, `Confirmed`, `Completed`, `Cancelled`)
  - `type`: string (e.g., `Clinic Visit`, `Home Visit`, `Video Call`)
  - `date`: string (e.g., `2026-09-10`)
- **Response Structure:**

  ```json
  {
    "status": true,
    "message": "Appointments retrieved successfully",
    "data": {
      "current_page": 1,
      "data": [
        {
          "id": "BK-9021",
          "patient_id": "PT-501",
          "patient": {
            "id": "PT-501",
            "name": "Sarah Ibrahim",
            "phone": "01122334455",
            "age": 29,
            "gender": "Female",
            "avatar": "https://rojeta.fassla.net/storage/avatars/patient_501.jpg"
          },
          "appointment_date": "2026-09-12",
          "appointment_time": "11:30 AM",
          "service_type": "Clinic Visit",
          "status": "Pending",
          "is_urgent": false,
          "is_online": false,
          "location": "Al-Amal Medical Center - Nasr City",
          "notes": "Patient experiences chronic chest pressure after walking.",
          "fee_original": "350.00",
          "fee_current": "350.00",
          "discount": "0.00",
          "payment_method": "Cash on Visit"
        }
      ],
      "total": 1,
      "per_page": 15,
      "last_page": 1
    }
  }
  ```

### 3.2 Update Appointment Status (Accept / Reject)

- **Endpoint:** `PATCH /doctor/appointments/{id}/status`
- **Request Body:**

  ```json
  {
    "status": "Confirmed" // "Confirmed" | "Cancelled" | "Completed"
  }
  ```

- **Response:**

  ```json
  {
    "status": true,
    "message": "Appointment status updated to Confirmed",
    "data": {
      "id": "BK-9021",
      "status": "Confirmed"
    }
  }
  ```

---

## 4. Chat & Messaging Synchronization (TC-022)

### 4.1 Get Conversations List

- **Endpoint:** `GET /doctor/chat/conversations`
- **Query Parameters:** `page`, `limit`
- **Response:**

  ```json
  {
    "status": true,
    "data": {
      "current_page": 1,
      "data": [
        {
          "id": "CV-301",
          "patient_id": "PT-501",
          "patient_name": "Sarah Ibrahim",
          "patient_avatar": "https://rojeta.fassla.net/storage/avatars/patient_501.jpg",
          "last_message": "Thank you doctor, I will see you on Saturday.",
          "last_message_time": "2026-09-07 10:45 AM",
          "unread_count": 1
        }
      ],
      "total": 1,
      "per_page": 20
    }
  }
  ```

### 4.2 Get Conversation Messages

- **Endpoint:** `GET /doctor/chat/messages`
- **Query Parameters:**
  - `conversation_id`: string (required)
  - `page`: int
  - `limit`: int
- **Response:**

  ```json
  {
    "status": true,
    "data": {
      "current_page": 1,
      "data": [
        {
          "id": "MSG-1001",
          "sender_id": "PT-501",
          "sender_role": "patient",
          "content": "Hello Doctor, should I fast before my appointment?",
          "created_at": "2026-09-07 09:30 AM",
          "is_me": false
        },
        {
          "id": "MSG-1002",
          "sender_id": "142",
          "sender_role": "doctor",
          "content": "Yes Sarah, please fast for 8 hours prior to lipid panel testing.",
          "created_at": "2026-09-07 09:42 AM",
          "is_me": true
        }
      ]
    }
  }
  ```

### 4.3 Send Message

- **Endpoint:** `POST /doctor/chat/send-message`
- **Request Body:**

  ```json
  {
    "conversation_id": "CV-301",
    "content": "You are welcome. See you soon."
  }
  ```

- **Response (201 Created):**

  ```json
  {
    "status": true,
    "message": "Message sent successfully",
    "data": {
      "id": "MSG-1003",
      "sender_id": "142",
      "sender_role": "doctor",
      "content": "You are welcome. See you soon.",
      "created_at": "2026-09-07 11:00 AM",
      "is_me": true
    }
  }
  ```

---

## 5. Clinic & Working Hours Management (TC-021)

### 5.1 Add Clinic

- **Endpoint:** `POST /doctor/clinics` (or `POST /clinics/add`)
- **Request Body:**

  ```json
  {
    "name": "Al-Amal Medical Center",
    "phone": "0223456789",
    "governorate": "Cairo",
    "city": "Nasr City",
    "full_address": "Building 12, Abbas Al-Aqqad St, Nasr City",
    "consultation_time": 30,
    "clinic_visit_price": 350.00,
    "follow_up_price": 150.00,
    "home_visit_price": 600.00,
    "video_call_price": 300.00,
    "working_hours": {
      "sat": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "sun": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "mon": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "tue": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "wed": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "thu": { "is_open": true, "start": "09:00 AM", "end": "09:00 PM" },
      "fri": { "is_open": false, "start": "09:00 AM", "end": "05:00 PM" }
    }
  }
  ```

- **Response (201 Created):**

  ```json
  {
    "status": true,
    "message": "Clinic created successfully",
    "data": {
      "id": 15,
      "name": "Al-Amal Medical Center"
    }
  }
  ```

### 5.2 Update Clinic

- **Endpoint:** `PUT /doctor/clinics/{clinic_id}`
- **Request Body:** Same schema as Add Clinic.
- **Response (200 OK):**

  ```json
  {
    "status": true,
    "message": "Clinic updated successfully"
  }
  ```

### 5.3 Delete Clinic

- **Endpoint:** `DELETE /doctor/clinics/{clinic_id}`
- **Response (200 OK):**

  ```json
  {
    "status": true,
    "message": "Clinic deleted successfully"
  }
  ```

---

## 6. Other Provider Endpoints Summary

### 6.1 Hospital

- `GET /hospital/dashboard` — Hospital home stats, overview
- `GET /hospital/appointments` — Hospital incoming bookings
- `POST /hospital/specialties/add` — Add medical specialty
- `POST /hospital/doctors/add` — Add doctor under hospital
- `GET /hospital/financial` — Hospital revenue & transactions

### 6.2 Lab & Radiology

- `GET /lab/profile` — Lab profile details
- `PUT /lab/profile/update` — Update lab profile info
- `GET /lab/bookings` — Lab test bookings (clinic & home visits)
- `PATCH /lab/bookings/update-status` — Update lab booking status
- `POST /lab/service/add` — Add test / scan service
- `GET /lab/branches` & `POST /lab/branches/add` — Manage lab branches
- `GET /lab/home-visits/config` & `PUT /lab/home-visits/config/update` — Home sample collection configuration

### 6.3 Nursing

- `GET /nursing/dashboard` — Nursing provider stats & bookings
- `GET /nursing/services` & `POST /nursing/services/add` — Nursing service offerings & pricing
- `GET /nursing/staff` & `POST /nursing/staff/add` — Registered nurses & staff management
- `GET /nursing/bookings` — Home visit requests and status updates

---

## 7. HTTP Status Code Summary

| Code | Meaning | Usage |
| --- | --- | --- |
| `200` | OK | Successful GET, PUT, PATCH request |
| `201` | Created | Resource successfully created (registration, clinic add, message sent) |
| `401` | Unauthorized | Missing, expired, or invalid JWT token |
| `403` | Forbidden | User role does not have permission to access the endpoint |
| `404` | Not Found | Requested appointment, patient, or clinic not found |
| `422` | Unprocessable Entity | Form/data validation failure (returns standard `errors` map) |
| `500` | Internal Server Error | Server error (must return clean JSON, not HTML stack traces) |
