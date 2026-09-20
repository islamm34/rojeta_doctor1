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

## Summary of Field Name Standardization

The client now supports both naming conventions seamlessly:

- CamelCase: `patientName`, `serviceFee`, `platformCommission`, `yourEarning`, `isRead`, `startTime`, `endTime`, `isWorking`
- Snake_case: `patient_name`, `service_fee`, `platform_commission`, `your_earning`, `is_read`, `start_time`, `end_time`, `is_working`
- Response wrappers: Both `{ "data": ... }` and top-level lists/objects are supported.
