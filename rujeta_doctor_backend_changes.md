# Backend API Changes & Specifications for Rojeta Doctor App

This document outlines the required API endpoints, request schemas, response formats, and status synchronization flows to align the backend with the Rojeta Doctor application.

The Doctor App client has already been implemented defensively to support both the current responses (with fallback parsing for camelCase / snake_case and cross-endpoint synthesis) and these updated target schemas. Once these backend updates are deployed live, the client will immediately function with zero code changes required.

---

## 1. Cash Payment Confirmation (ROJ-007)

### Endpoint

`POST /api/v1/doctor/appointments/{id}/confirm-cash-payment`
*(or alternatively `PATCH /api/v1/doctor/appointments/{id}/status` with body `{"status": "paid", "payment_status": "paid"}`)*

### Description

Called by the doctor or clinic reception when a patient with a `cash` booking completes payment at the clinic. It transitions the booking's `payment_status` to `paid` and creates the associated financial ledger record for doctor earnings and platform commission.

### Request

- **Headers:** `Authorization: Bearer <token>`
- **URL Parameters:** `id` (string/integer) - The appointment ID
- **Body (JSON):**

```json
{
  "payment_method": "cash",
  "amount_received": 250.00,
  "notes": "Payment received at front desk"
}
```

### Response (`200 OK`)

```json
{
  "status": "success",
  "message": "Cash payment confirmed successfully",
  "data": {
    "id": "appt_12345",
    "status": "confirmed",
    "payment_status": "paid",
    "payment_method": "cash",
    "price": 250.00,
    "paid_at": "2026-09-20T21:00:00Z",
    "doctor_earning": 225.00,
    "platform_fee": 25.00
  }
}
```

---

## 2. Patients List & Stats Count (ROJ-008)

### Endpoint

`GET /api/v1/doctor/patients`

### Description

Returns the list of unique patients assigned to or treated by the authenticated doctor. Must include patients with at least one confirmed, completed, or scheduled booking.

### Query Parameters

- `page` (optional, integer): Page number (default: 1)
- `limit` (optional, integer): Items per page (default: 20)
- `search` (optional, string): Filter by patient name or phone number

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": [
    {
      "id": "pat_9876",
      "name": "Ahmed Hassan",
      "age": 34,
      "gender": "male",
      "phone": "+201234567890",
      "image": "https://rojeta.fassla.net/uploads/patients/ahmed.jpg",
      "blood_group": "O+",
      "condition": "Hypertension",
      "total_visits": 3,
      "last_visit": "2026-09-18"
    }
  ],
  "meta": {
    "total": 1,
    "page": 1,
    "limit": 20
  }
}
```

### Dashboard Stats Count Endpoint

`GET /api/v1/doctor/dashboard`

Ensure `total_patients` / `patients_count` reflects all unique patients with active or completed appointments:

```json
{
  "status": "success",
  "data": {
    "total_patients": 12,
    "total_appointments": 45,
    "completed_appointments": 38,
    "total_revenue": 9500.00,
    "upcoming_appointments": [ ... ]
  }
}
```

---

## 3. Doctor Availability & Schedule Management (ROJ-009 & ROJ-010)

### 3.1 Get Schedule

`GET /api/v1/doctor/schedule`

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "examination_duration_minutes": 30,
    "working_days": [
      {
        "day": "Saturday",
        "is_working": true,
        "slots": [
          {
            "id": "slot_sat_1",
            "start_time": "09:00 AM",
            "end_time": "01:00 PM"
          },
          {
            "id": "slot_sat_2",
            "start_time": "05:00 PM",
            "end_time": "09:00 PM"
          }
        ]
      },
      {
        "day": "Sunday",
        "is_working": true,
        "slots": [
          {
            "id": "slot_sun_1",
            "start_time": "10:00 AM",
            "end_time": "03:00 PM"
          }
        ]
      },
      {
        "day": "Friday",
        "is_working": false,
        "slots": []
      }
    ],
    "vacations": [
      {
        "id": "vac_1",
        "title": "Annual Leave",
        "start_date": "2026-10-01",
        "end_date": "2026-10-07"
      }
    ]
  }
}
```

### 3.2 Update Schedule (Live Synchronization with User App)

`POST /api/v1/doctor/schedule` or `PUT /api/v1/doctor/schedule` or `POST /api/v1/schedule/update`

### Request Body (JSON)

```json
{
  "examination_duration_minutes": 30,
  "working_days": [
    {
      "day": "Saturday",
      "is_working": true,
      "slots": [
        {
          "start_time": "09:00 AM",
          "end_time": "01:00 PM"
        },
        {
          "start_time": "05:00 PM",
          "end_time": "09:00 PM"
        }
      ]
    },
    {
      "day": "Friday",
      "is_working": false,
      "slots": []
    }
  ],
  "vacations": [
    {
      "title": "Eid Holiday",
      "start_date": "2026-10-15",
      "end_date": "2026-10-18"
    }
  ]
}
```

### User App Slot Synchronization Rule

When the User App queries `GET /api/v1/doctor/{id}/available-slots?date=YYYY-MM-DD`:

1. Check if `date` falls within any of the doctor's active `vacations` — if yes, return empty slots.
2. Find the corresponding `working_day` entry for the given day of the week.
3. If `is_working == false`, return empty slots.
4. If `is_working == true`, partition the time slots by `examination_duration_minutes` (e.g. 30 mins) and omit any slots already booked.

---

## 4. Financial Summary & Transactions (ROJ-011)

### 4.1 Financial Summary

`GET /api/v1/financial/summary` or `GET /api/v1/doctor/financial/summary`

### Query Parameters

- `startDate` (optional, string: `YYYY-MM-DD`)
- `endDate` (optional, string: `YYYY-MM-DD`)

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "total_income": 12500.00,
    "completed_appointments": 50,
    "commission": 1250.00,
    "net_income": 11250.00
  }
}
```

### 4.2 Financial Transactions

`GET /api/v1/financial/transactions` or `GET /api/v1/doctor/financial/transactions`

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": [
    {
      "id": "tx_5541",
      "patient_name": "Sarah Mansour",
      "visit_type": "Consultation",
      "status": "completed",
      "date": "2026-09-20",
      "time": "11:30 AM",
      "service_fee": 250.00,
      "platform_commission": 25.00,
      "your_earning": 225.00
    }
  ]
}
```

---

## 5. Doctor Notifications (ROJ-012)

### 5.1 Get Notifications

`GET /api/v1/doctor/notifications` or `GET /api/v1/notifications/get`

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": [
    {
      "id": "notif_101",
      "title": "New Booking",
      "body": "You have a new consultation booked by Mohamed Ali for tomorrow at 10:00 AM",
      "time": "2026-09-20T19:30:00Z",
      "is_read": false,
      "priority": "High",
      "type": "appointment"
    },
    {
      "id": "notif_102",
      "title": "Payment Received",
      "body": "Payment of 250 EGP for appointment #12345 has been confirmed.",
      "time": "2026-09-20T18:00:00Z",
      "is_read": true,
      "priority": "Medium",
      "type": "payment"
    }
  ]
}
```

### 5.2 Mark Notification as Read

`PATCH /api/v1/doctor/notifications/{id}/read`

### Response (`200 OK`)

```json
{
  "status": "success",
  "message": "Notification marked as read"
}
```

---

## 6. Doctor Appointment Details (ROJ-014)

### Endpoint

`GET /api/v1/doctor/appointments/{id}`

### Description

Returns the complete appointment details for the given `id`.

### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "id": "appt_12345",
    "appointment_id": "appt_12345",
    "patient_id": "pat_9876",
    "patient_name": "Ahmed Hassan",
    "patient_phone": "+201234567890",
    "patient_age": 34,
    "patient_gender": "male",
    "appointment_date": "2026-09-21",
    "appointment_time": "10:30 AM",
    "status": "confirmed",
    "payment_status": "unpaid",
    "payment_method": "cash",
    "price": 250.00,
    "notes": "Follow-up consultation for blood pressure check"
  }
}
```

---

---

## 7. Laboratory & Radiology Services Management (ROJ-017)

### 7.1 Add New Test / Scan Service

- **Endpoints:** `POST /api/v1/lab/services` or `POST /api/v1/lab/tests` or `POST /api/v1/laboratory/tests` (for Radiology: `POST /api/v1/radiology/services` or `POST /api/v1/radiology/scans`)
- **Headers:** `Authorization: Bearer <token>`, `Content-Type: application/json`

#### Request Body (JSON)

```json
{
  "name": "Complete Blood Count (CBC)",
  "category": "Hematology",
  "price": 180.00,
  "description": "Measures several components and features of your blood.",
  "turnaround_time_hours": 24,
  "requires_fasting": false,
  "sample_type": "Blood",
  "is_home_visit_available": true
}
```

#### Response (`201 Created` or `200 OK`)

```json
{
  "status": "success",
  "message": "Service added successfully",
  "data": {
    "id": "srv_7891",
    "name": "Complete Blood Count (CBC)",
    "category": "Hematology",
    "price": 180.00,
    "description": "Measures several components and features of your blood.",
    "turnaround_time_hours": 24,
    "requires_fasting": false,
    "sample_type": "Blood",
    "is_home_visit_available": true,
    "created_at": "2026-09-20T21:45:00Z"
  }
}
```

---

## 8. Lab / Radiology Profile & Information (ROJ-019 & ROJ-020)

### 8.1 Get Lab / Radiology Info

- **Endpoints:** `GET /api/v1/lab/profile` or `GET /api/v1/lab/info` or `GET /api/v1/radiology/profile`

#### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "id": "lab_441",
    "lab_name": "Al Borg Laboratories - Maadi Branch",
    "license_number": "LIC-EGY-2024-8891",
    "primary_contact_email": "maadi@alborg.com",
    "phone_number": "+201099887766",
    "laboratory_description": "Leading medical laboratory providing international standard clinical diagnostics.",
    "verification_status": "active",
    "verification_year": "2026"
  }
}
```

### 8.2 Update Lab / Radiology Info (HTTP `PUT` or `POST`)

- **Endpoints:** `PUT /api/v1/lab/profile` or `PUT /api/v1/lab/info` or `POST /api/v1/lab/profile` (for Radiology: `PUT /api/v1/radiology/profile`)
- **Headers:** `Authorization: Bearer <token>`, `Content-Type: application/json`

#### Request Body (JSON)

```json
{
  "lab_name": "Al Borg Laboratories - Maadi Branch",
  "license_number": "LIC-EGY-2024-8891",
  "primary_contact_email": "maadi@alborg.com",
  "phone_number": "+201099887766",
  "laboratory_description": "Updated laboratory description."
}
```

#### Response (`200 OK`)

```json
{
  "status": "success",
  "message": "Laboratory information updated successfully",
  "data": {
    "lab_name": "Al Borg Laboratories - Maadi Branch",
    "license_number": "LIC-EGY-2024-8891",
    "primary_contact_email": "maadi@alborg.com",
    "phone_number": "+201099887766",
    "laboratory_description": "Updated laboratory description."
  }
}
```

---

## 9. Lab / Radiology General Settings (ROJ-019, ROJ-022, ROJ-023)

### 9.1 Update General Settings (`PUT` or `POST`)

- **Endpoints:** `PUT /api/v1/lab/settings` or `PUT /api/v1/settings` or `POST /api/v1/lab/settings`

#### Request Body (JSON)

```json
{
  "email_notifications": true,
  "booking_updates": true,
  "push_notifications": true,
  "marketing_emails": false,
  "two_factor_auth": false,
  "language": "ar"
}
```

#### Response (`200 OK`)

```json
{
  "status": "success",
  "message": "Settings updated successfully"
}
```

---

## 10. Home Visits Configuration (ROJ-028)

### 10.1 Get Home Visits Configuration

- **Endpoints:** `GET /api/v1/lab/home-visits/config` or `GET /api/v1/lab/home-visits`

#### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "is_service_visible": true,
    "collection_fee": 50.00,
    "minimum_booking_amount": 150.00,
    "service_areas": [
      {
        "id": "area_1",
        "name": "Maadi & Degla",
        "delivery_fee": 50.00
      },
      {
        "id": "area_2",
        "name": "New Cairo & Rehab",
        "delivery_fee": 70.00
      }
    ],
    "weekday_slots": [
      { "id": "slot_1", "start_time": "08:00 AM", "end_time": "12:00 PM" },
      { "id": "slot_2", "start_time": "01:00 PM", "end_time": "05:00 PM" }
    ],
    "weekend_slots": [
      { "id": "slot_3", "start_time": "09:00 AM", "end_time": "02:00 PM" }
    ]
  }
}
```

### 10.2 Update Home Visits Configuration (HTTP `PUT` or `POST`)

- **Endpoints:** `PUT /api/v1/lab/home-visits/config` or `POST /api/v1/lab/home-visits/config`

#### Request Body (JSON)

```json
{
  "is_service_visible": true,
  "collection_fee": 50.00,
  "minimum_booking_amount": 150.00,
  "service_areas": [
    { "name": "Maadi & Degla", "delivery_fee": 50.00 }
  ],
  "weekday_slots": [
    { "start_time": "08:00 AM", "end_time": "12:00 PM" }
  ],
  "weekend_slots": [
    { "start_time": "09:00 AM", "end_time": "02:00 PM" }
  ]
}
```

---

## 11. Home Visit Booking Location & Fee Calculation (ROJ-026 & ROJ-027)

### 11.1 Booking Schema Requirements

When returning bookings via `GET /api/v1/bookings`:

1. **Patient Residential Address:** For all home visit bookings (`type: "home_visit"` or `type: "home"`), the backend must include the patient's full address in `patient_address` or `address` or `location_name`.
2. **Total Price Calculation:** The `total_price` (or `totalPrice` / `fee`) must be calculated as:
   $$\text{total\_price} = \text{test\_price} + \text{home\_visit\_fee}$$
   Example: If CBC is 180 EGP and Home Collection is 50 EGP, `total_price` should return `230.00`.

#### Sample Booking JSON Object

```json
{
  "id": "book_9921",
  "booking_ref_id": "ROJ-LAB-9921",
  "type": "home_visit",
  "patient_name": "Nour El-Din",
  "patient_phone": "+201122334455",
  "patient_address": "Building 14, Street 9, Maadi, Cairo",
  "service_name": "Comprehensive Lipid Profile",
  "test_price": 220.00,
  "home_visit_fee": 50.00,
  "total_price": 270.00,
  "booking_date": "2026-09-22",
  "booking_time": "09:00 AM",
  "status": "confirmed",
  "payment_status": "pending"
}
```

---

## 12. Lab & Radiology Notifications (ROJ-024)

### 12.1 Permissions & Endpoint

- **Endpoint:** `GET /api/v1/notifications/get` or `GET /api/v1/lab/notifications`
- Ensure authenticated accounts with `user_type == "laboratory"` or `user_type == "radiology_center"` have access permissions and do **not** receive `403 Forbidden`.

---

## 13. Lab & Radiology In-App Chat (ROJ-025)

### 13.1 Chat Endpoints

- `GET /api/v1/doctor/chat/conversations` or `GET /api/v1/chat/conversations`: Returns conversations between lab/radiology provider and patients who booked services.
- `GET /api/v1/doctor/chat/messages?conversation_id={id}`
- `POST /api/v1/doctor/chat/send-message`

---

---

## 14. Radiology Center Role API Specifications (ROJ-029 to ROJ-043)

### 14.1 Radiology Scans & Services Management (ROJ-029 & ROJ-031)

- **Endpoints:**
  - `GET /api/v1/radiology/services` (or `GET /api/v1/lab/services?user_type=radiology`)
  - `POST /api/v1/radiology/services` (or `POST /api/v1/lab/services` with `"type": "radiology"`)
  - `PUT /api/v1/radiology/services/{id}`
  - `DELETE /api/v1/radiology/services/{id}`
- **Request Body for Creating a Scan:**

```json
{
  "name": "Chest X-Ray (PA & Lateral)",
  "name_ar": "أشعة سينية على الصدر",
  "category": "X-Ray",
  "price": 350.00,
  "duration_minutes": 20,
  "home_visit_available": true,
  "instructions": "Remove metal objects before scan",
  "is_active": true
}
```

- **Response (`201 Created` or `200 OK`):**

```json
{
  "status": "success",
  "message": "Radiology service added successfully",
  "data": {
    "id": "scan_441",
    "name": "Chest X-Ray (PA & Lateral)",
    "price": 350.00,
    "category": "X-Ray",
    "home_visit_available": true,
    "is_active": true
  }
}
```

---

### 14.2 Radiology Booking Payment Confirmation (ROJ-030)

- **Endpoint:** `POST /api/v1/bookings/{id}/confirm-cash-payment` (or `PATCH /api/v1/bookings/{id}/payment-status`)
- **Request:**

```json
{
  "payment_status": "paid",
  "payment_method": "cash",
  "amount_received": 350.00
}
```

- **Response (`200 OK`):**

```json
{
  "status": "success",
  "message": "Booking payment confirmed",
  "data": {
    "id": "book_9921",
    "status": "confirmed",
    "payment_status": "paid",
    "total_price": 350.00
  }
}
```

---

### 14.3 Radiology Center Profile & Information (ROJ-033)

- **Endpoints:**
  - `GET /api/v1/radiology/profile` (or `GET /api/v1/lab/profile`)
  - `PUT /api/v1/radiology/profile` / `POST /api/v1/radiology/profile` / `PATCH /api/v1/radiology/profile`
- **Request Body:**

```json
{
  "name": "Al-Amal Radiology & Scan Center",
  "about": "Advanced medical imaging and diagnostic scans.",
  "phone": "+201011223344",
  "email": "contact@alamal-radiology.com",
  "address": "15 Al-Nasr St, Nasr City, Cairo",
  "license_number": "RAD-2026-991"
}
```

---

### 14.4 Radiology Financial Section & Revenue (ROJ-035)

- **Endpoints:**
  - `GET /api/v1/financial/summary`
  - `GET /api/v1/financial/transactions`
- **Specification:**
  - When the authenticated user is a Radiology Center (`user_type == "radiology"` / `"radiology_center"`), include all completed scan bookings and home visit scan fees in `total_income`, `completed_appointments`, and the `transactions` array.

---

### 14.5 Home Visit Configuration for Radiology (ROJ-040, ROJ-041, ROJ-042)

- **Endpoints:**
  - `GET /api/v1/radiology/home-visits/config`
  - `PUT /api/v1/radiology/home-visits/config` / `POST /api/v1/radiology/home-visits/config`
- **Schema:**

```json
{
  "is_home_visit_enabled": true,
  "home_visit_fee": 75.00,
  "minimum_booking_amount": 200.00,
  "service_areas": [
    { "name": "Nasr City & Heliopolis", "radius_km": 15, "techs_available": 3 }
  ],
  "weekday_slots": [
    { "start_time": "08:00 AM", "end_time": "04:00 PM" }
  ],
  "weekend_slots": [
    { "start_time": "10:00 AM", "end_time": "02:00 PM" }
  ]
}
```

---

### 14.6 Bookings List & Dashboard Consistency (ROJ-043)

- **Endpoint:** `GET /api/v1/bookings?user_type=radiology`
- **Query Parameter Fix:**
  - Ensure the query parameter `user_type=radiology` or `role=radiology` filters by the provider account rather than the appointment type column `type` (which holds `"branch_visit"` or `"home_visit"`).
  - All upcoming bookings returned on `GET /api/v1/radiology/dashboard` (or `lab/dashboard`) must also be present in `GET /api/v1/bookings?user_type=radiology`.

---

---

## 15. Nursing Care Provider Role API Specifications (ROJ-044, ROJ-045, ROJ-046)

### 15.1 Nursing Dashboard Synchronization (ROJ-046)

- **Endpoints:**
  - `GET /api/v1/nursing/dashboard` (or `GET /api/v1/dashboard?user_type=nursing`)
- **Description:** Returns high-level statistics for the nursing provider office, including active staff count, active services count, today's appointments, completed appointments, and the next upcoming booking.

#### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "stats": {
      "today_appointments": 14,
      "completed_appointments": 38,
      "active_staff": 8,
      "active_services": 5
    },
    "upcoming_booking": {
      "id": "book_nursing_101",
      "booking_ref_id": "ROJ-NUR-101",
      "patient_name": "Mariam Mahmoud",
      "service_title": "12-Hour Nursing Care",
      "assigned_nurse_name": "Sarah Ahmed",
      "time_slot": "08:00 AM - 08:00 PM",
      "status": "confirmed",
      "payment_status": "paid",
      "price": 600.00
    },
    "recent_bookings": [
      {
        "id": "book_nursing_102",
        "booking_ref_id": "ROJ-NUR-102",
        "patient_name": "Ali Hassan",
        "service_title": "Home Visit / IV Injection",
        "assigned_nurse_name": "Mohamed Omar",
        "time_slot": "10:00 AM",
        "status": "confirmed",
        "payment_status": "unpaid",
        "price": 200.00
      }
    ]
  }
}
```

---

### 15.2 Nursing Services Management (ROJ-045 & ROJ-046)

- **Endpoints:**
  - `GET /api/v1/nursing/services`
  - `POST /api/v1/nursing/services`
  - `PUT /api/v1/nursing/services/{id}`
  - `DELETE /api/v1/nursing/services/{id}`

#### Request Body for Adding a Service (`POST /api/v1/nursing/services`)

```json
{
  "title": "12-Hour Nursing Care",
  "subtitle": "Continuous daytime clinical care, vitals monitoring, medication administration, and hygiene assistance.",
  "duration_tag": "12 Hours",
  "price": 600.00,
  "pricing_type": "Per Visit",
  "available_gender": "Both",
  "is_active": true,
  "bullet_points": [
    "Medication administration & IV management",
    "Post-surgical wound dressing",
    "Vital signs routine check"
  ]
}
```

#### Response (`201 Created` or `200 OK`)

```json
{
  "status": "success",
  "message": "Nursing service added successfully",
  "data": {
    "id": "nsrv_101",
    "title": "12-Hour Nursing Care",
    "subtitle": "Continuous daytime clinical care, vitals monitoring, medication administration, and hygiene assistance.",
    "duration_tag": "12 Hours",
    "bullet_points": [
      "Medication administration & IV management",
      "Post-surgical wound dressing",
      "Vital signs routine check"
    ]
  }
}
```

---

### 15.3 Nursing Staff Management (ROJ-045 & ROJ-046)

- **Endpoints:**
  - `GET /api/v1/nursing/staff`
  - `POST /api/v1/nursing/staff`
  - `PUT /api/v1/nursing/staff/{id}`
  - `DELETE /api/v1/nursing/staff/{id}`

#### Request Body for Adding a Nurse (`POST /api/v1/nursing/staff`)

```json
{
  "name": "Sarah Ahmed",
  "phone": "+201011223344",
  "gender": "FEMALE",
  "status": "AVAILABLE",
  "years_of_experience": 5,
  "skills": ["ICU", "Pediatrics", "Post-Op Care"],
  "services": ["12-Hour Nursing", "Home Visit"],
  "image_url": "https://rojeta.fassla.net/uploads/nursing/sarah.jpg"
}
```

#### Response (`201 Created` or `200 OK`)

```json
{
  "status": "success",
  "message": "Nurse added successfully",
  "data": {
    "id": "nstaff_201",
    "name": "Sarah Ahmed",
    "phone": "+201011223344",
    "gender": "FEMALE",
    "status": "AVAILABLE",
    "years_of_experience": 5,
    "skills": ["ICU", "Pediatrics", "Post-Op Care"],
    "image_url": "https://rojeta.fassla.net/uploads/nursing/sarah.jpg"
  }
}
```

---

### 15.4 Nursing Office Profile & Information (ROJ-045 & ROJ-046)

- **Endpoints:**
  - `GET /api/v1/nursing/profile` (or `GET /api/v1/nursing/office-info`)
  - `PUT /api/v1/nursing/profile` / `POST /api/v1/nursing/profile`

#### Response (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "office_name": "Al-Nour Nursing Care Solutions",
    "license_number": "NUR-LIC-2026-0042",
    "primary_contact_email": "support@alnour-nursing.com",
    "phone_number": "+201002233445",
    "office_description": "Certified home nursing and healthcare provider offering specialized caregivers, ICU nurses, and post-operative attendants across Greater Cairo.",
    "verification_year": "2026",
    "is_verified": true
  }
}
```

---

### 15.5 Working Hours Management (ROJ-045 & ROJ-046)

- **Endpoints:**
  - `GET /api/v1/nursing/working-hours`
  - `PUT /api/v1/nursing/working-hours` / `POST /api/v1/nursing/working-hours`

#### Request / Response Body (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "working_hours": [
      {
        "day": "Monday",
        "is_active": true,
        "start_time": "08:00 AM",
        "end_time": "08:00 PM"
      },
      {
        "day": "Tuesday",
        "is_active": true,
        "start_time": "08:00 AM",
        "end_time": "08:00 PM"
      },
      {
        "day": "Friday",
        "is_active": false,
        "start_time": "09:00 AM",
        "end_time": "05:00 PM"
      }
    ]
  }
}
```

---

### 15.6 App Settings & Preferences (ROJ-045)

- **Endpoints:**
  - `GET /api/v1/nursing/settings`
  - `PUT /api/v1/nursing/settings` / `POST /api/v1/nursing/settings`

#### Request / Response Body (`200 OK`)

```json
{
  "status": "success",
  "data": {
    "email_notifications": true,
    "sms_updates": true,
    "push_notifications": true,
    "appointment_reminders": true,
    "marketing_emails": false
  }
}
```

---

### 15.7 Nursing Bookings Synchronization (ROJ-044, ROJ-045, ROJ-046)

- **Endpoints:**
  - `GET /api/v1/bookings?user_type=nursing`
  - `PATCH /api/v1/bookings/{id}/status`
  - `POST /api/v1/bookings/{id}/confirm-cash-payment`

#### Booking Object for Nursing Care

```json
{
  "id": "book_nur_301",
  "booking_ref_id": "ROJ-NUR-301",
  "type": "nursing_care",
  "patient_name": "Mahmoud Soliman",
  "patient_phone": "+201288776655",
  "patient_address": "Villa 12, Diplomatic District, New Cairo",
  "service_name": "12-Hour Nursing Care",
  "nurse_name": "Sarah Ahmed",
  "booking_date": "2026-09-23",
  "booking_time": "08:00 AM",
  "duration": "12 Hours",
  "price": 600.00,
  "total_price": 600.00,
  "status": "confirmed",
  "payment_status": "paid",
  "payment_method": "credit_card"
}
```

---

## Summary of Client-Side Defensiveness

The Flutter app has been updated to:

- Fall back gracefully across `PUT`, `POST`, and `PATCH` methods on all profile, setting, and home visit endpoints.
- Auto-calculate missing `total_price` as `service_price + home_visit_fee` on the client.
- Display `patient_address` for home visits and `branch_name` for branch visits uniformly.
- Support instant live language toggling (Arabic / English) throughout all Doctor, Lab, Radiology, and Nursing screens.
- Synthesize dashboard upcoming bookings and financial metrics directly from `/bookings` if primary endpoints are unpopulated.
- Provide interactive in-app Cash Payment Confirmation for doctors, radiology, lab, and nursing providers.
- Maintain a strictly layered architecture (Presentation, Domain, Data) with isolated standalone widgets in `widgets/` and zero function-based UI helpers.
