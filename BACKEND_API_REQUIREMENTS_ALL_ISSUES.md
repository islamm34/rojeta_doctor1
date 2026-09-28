# Backend API Requirements & Specification Document

**Project:** Rojeta Healthcare Platform (Patient App & Doctor/Provider App)  
**Date:** September 2026  
**Document Version:** 1.0.0  

---

## 1. Executive Summary

This document outlines the backend API specifications, database schema alignments, endpoint contracts, and validation rules required to support the Rojeta Patient App and Doctor/Provider App. The frontend mobile applications have been updated to seamlessly communicate with these contracts.

---

## 2. Patient App Requirements & Endpoints

### 2.1 [ROJ-003 & ROJ-004] Doctor Available Schedules & Preview Calculation

#### ROJ-003 & ROJ-004 Schedule Calculation Issue

- Appointment preview was hardcoded to "Tomorrow 4 PM" and available booking days did not dynamically mirror the doctor's active schedule configured in the dashboard.

#### ROJ-003 & ROJ-004 Required Backend Contract

`GET /api/v1/service-providers/details?id={doctorId}&type=clinic`

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "id": "doc_102",
    "name": "Dr. Ahmed Mansour",
    "specialty": "Cardiology",
    "consultation_fee": 350.0,
    "next_available_slot": "2026-09-28 16:00:00",
    "work_locations": [
      {
        "id": "loc_1",
        "name": "Heart Center Clinic",
        "address": "15 Al-Ahram St, Heliopolis, Cairo",
        "latitude": 30.0881,
        "longitude": 31.3283,
        "consultation_fee": 350.0,
        "working_days": ["Sunday", "Monday", "Wednesday", "Thursday"],
        "available_time_slots": [
          "04:00 PM",
          "04:30 PM",
          "05:00 PM",
          "05:30 PM",
          "06:00 PM"
        ]
      }
    ]
  }
}
```

---

### 2.2 [ROJ-006] Nursing Service Provider & Booking Lifecycle

#### ROJ-006 Nursing Service Issues

1. Nurse provider cards displayed static fallback metrics (0 nurses, static rating).
2. Booking a nurse triggered a PHP `failed to open stream` error when processing file uploads.
3. Bookings defaulted incorrectly to active/confirmed rather than remaining `pending` until accepted.

#### ROJ-006 Nursing Endpoints

- `GET /api/v1/nursing/offices`
- `POST /api/v1/bookings/nursing/create`

#### GET /api/v1/nursing/offices Response (200 OK)

```json
{
  "success": true,
  "data": [
    {
      "id": "nurse_office_1",
      "office_name": "Al-Amal Home Nursing",
      "rating": 4.8,
      "reviews_count": 124,
      "nurses_count": 18,
      "experience_years": 8,
      "since_year": 2018,
      "service_areas": "Cairo, Giza, New Cairo",
      "price": 250.0,
      "discount_percent": 10,
      "feature_badges": ["24/7 Available", "Licensed Nurses", "ICU Certified"]
    }
  ]
}
```

#### POST /api/v1/bookings/nursing/create

**Request Body (JSON / Multipart):**

```json
{
  "service_id": "srv_4",
  "service_title": "Elderly Care & Monitoring",
  "office_id": "nurse_office_1",
  "office_name": "Al-Amal Home Nursing",
  "selected_date": "2026-09-30",
  "selected_time": "10:00 AM",
  "selected_days": 3,
  "area": "Nasr City",
  "address": "Building 12, Makram Ebeid St, Apt 4",
  "patient_phone": "+201012345678",
  "patient_condition": "Post-surgery recovery requiring daily wound care",
  "total_price": 750.0,
  "payment_method": "cash",
  "provider_type": "nursing",
  "status": "pending"
}
```

**PHP / Laravel Backend Requirement:**

- Verify `request()->hasFile('prescription_file')` or `request()->hasFile('attachment')` before calling `Storage::putFile()` or `fopen()`. Do not call `fopen()` on string URLs or empty strings.
- Initial booking record must be created with `status = 'pending'` (or `waiting_approval`).

---

### 2.3 [ROJ-047 & ROJ-048] Ambulance Fleet Dynamic Sync & Booking

#### ROJ-047 & ROJ-048 Ambulance Sync Issues

- Inactive or draft ambulance vehicles appeared in the Patient App even when deactivated in the dashboard.

#### ROJ-047 & ROJ-048 Ambulance Backend Contract

`GET /api/v1/service-providers?type=ambulance&active_only=true`

**Database Query:**

```sql
SELECT id, name, vehicle_number, driver_name, phone, equipment_level, base_price, is_active, status 
FROM ambulances 
WHERE is_active = 1 AND status = 'available';
```

---

### 2.4 [ROJ-050] Hospital Role & Provider Classification (Nurses vs Doctors)

#### ROJ-050 Hospital Staff Classification Issue

- Adding a nurse inside a hospital categorized them under doctors, enabling doctor-style clinic bookings for nurses.

#### ROJ-050 Required Role Separation

- Hospital staff query must filter by `staff_type` / `role`:
  - `GET /api/v1/hospital/{id}/doctors` -> returns only practitioners with role `doctor`.
  - `GET /api/v1/hospital/{id}/nurses` -> returns staff with role `nurse` or `nursing`.
- Clinic booking endpoints (`POST /api/v1/bookings/clinic`) must reject staff IDs that belong to non-doctor roles.

---

### 2.5 [ROJ-052] Booking Details Provider Location & Maps Integration

#### ROJ-052 Required Fields in Appointment & Booking Endpoints

`GET /api/v1/appointments/{id}` & `GET /api/v1/bookings/{id}`

```json
{
  "success": true,
  "data": {
    "id": "apt_9921",
    "doctor_name": "Dr. Sarah Khalil",
    "location_name": "Al-Shorouk Medical Center",
    "location_address": "Building 5, Street 90 North, New Cairo",
    "latitude": 30.0271,
    "longitude": 31.4912,
    "google_maps_url": "https://www.google.com/maps/search/?api=1&query=30.0271,31.4912",
    "status": "confirmed",
    "payment_status": "paid",
    "consultation_fee": 400.0
  }
}
```

---

## 3. Doctor / Provider App Requirements & Endpoints

### 3.1 [ROJ-013] Doctor Profile & Financial Details Persistence

#### ROJ-013 Doctor Profile Endpoints

- `GET /api/v1/doctor/profile`
- `PUT /api/v1/doctor/profile`
- `PUT /api/v1/doctor/payment-details`

#### PUT /api/v1/doctor/profile Request Body

```json
{
  "full_name": "Dr. Ahmed Mansour",
  "email": "dr.ahmed@example.com",
  "phone_number": "+201012345678",
  "specialty": "Cardiology",
  "sub_specialty": "Interventional Cardiology",
  "years_of_experience": "12",
  "bio": "Consultant Cardiologist with extensive international training.",
  "education": "MD, Cairo University; Fellowship, Royal College of Physicians",
  "payment_details": {
    "payment_type": "bank_transfer",
    "account_holder_name": "Ahmed Mansour",
    "bank_name": "CIB Egypt",
    "account_number": "100029384756"
  }
}
```

#### PUT /api/v1/doctor/payment-details Request Body (For Mobile Wallet)

```json
{
  "payment_type": "mobile_wallet",
  "account_holder_name": "Ahmed Mansour",
  "bank_name": null,
  "account_number": "+201012345678",
  "wallet_number": "+201012345678"
}
```

---

### 3.2 [ROJ-028] Lab & Radiology Home Visits Coverage Areas

#### ROJ-028 Home Visits Config Endpoint

`POST /api/v1/lab/home-visits/config/update`

**Request Body:**

```json
{
  "is_service_visible": true,
  "collection_fee": 150.0,
  "minimum_booking_amount": 300.0,
  "service_areas": [
    {
      "id": "area_1",
      "name": "Nasr City & Heliopolis",
      "radius_km": 20,
      "techs_available": 4
    },
    {
      "id": "area_2",
      "name": "New Cairo & 5th Settlement",
      "radius_km": 15,
      "techs_available": 3
    }
  ],
  "weekday_slots": [
    {
      "id": "slot_1",
      "time": "09:00 AM - 11:00 AM",
      "status": "active"
    },
    {
      "id": "slot_2",
      "time": "12:00 PM - 02:00 PM",
      "status": "ready"
    }
  ]
}
```

---

### 3.3 [ROJ-043] Radiology Center Upcoming Bookings Consistency

#### ROJ-043 Radiology Center Upcoming Bookings Endpoint

`GET /api/v1/bookings?user_type=radiology` & `GET /api/v1/lab/dashboard`

**Requirements:**

- Ensure `/bookings?user_type=radiology` queries the same table / status index as `/lab/dashboard`'s `upcoming_booking`.
- Do not apply conflicting status filters between dashboard summary and bookings list.

---

### 3.4 [ROJ-046 & ROJ-045] Nurse Provider Staff Management (Fixing "Column Not Found")

#### ROJ-046 & ROJ-045 Nurse Staff Management Endpoints

- `GET /api/v1/nursing/staff`
- `POST /api/v1/nursing/staff`
- `PUT /api/v1/nursing/staff/{id}`
- `DELETE /api/v1/nursing/staff/{id}`

#### ROJ-046 & ROJ-045 Nurse Staff Database Issue

- Backend threw `SQL error: column not found` due to unhandled keys or camelCase / snake_case column discrepancies in `nursing_staff` table.

#### Required Table Schema (`nursing_staff`)

| Column Name | Type | Nullable | Notes |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT / UUID | No | Primary Key |
| `office_id` / `provider_id` | BIGINT | No | Foreign Key |
| `name` / `full_name` | VARCHAR(255) | No | Staff Member Name |
| `gender` | ENUM('MALE', 'FEMALE') | No | Default 'MALE' |
| `status` | ENUM('AVAILABLE', 'BUSY', 'ON_DUTY', 'ON_LEAVE') | No | Default 'AVAILABLE' |
| `years_of_experience` | INT | Yes | Default 0 |
| `phone` | VARCHAR(50) | Yes | Contact Number |
| `skills` | JSON / TEXT | Yes | Array of skill strings |
| `services` | JSON / TEXT | Yes | Array of linked service IDs |
| `image_url` | VARCHAR(500) | Yes | Profile photo path |

#### POST /api/v1/nursing/staff Request

```json
{
  "name": "Mona El-Sayed",
  "gender": "FEMALE",
  "status": "AVAILABLE",
  "years_of_experience": 5,
  "phone": "+201123456789",
  "skills": ["ICU Care", "IV Cannulation", "Wound Dressing"],
  "services": ["Elderly Care", "Post-Op Recovery"]
}
```

---

### 3.5 [ROJ-049] Hospital Account Mobile Login Permissions

#### ROJ-049 Hospital Login Permission Issue

- Logging in with a Hospital account returned `403 Forbidden: You don't have permission to access this resource`.

#### ROJ-049 Required Backend Fix in AuthController@login / Role Middleware

1. Accept `role = 'hospital'`, `'hospital_admin'`, `'medical_center'`, or `'center'`.
2. Generate Sanctum / Passport token with hospital access abilities (`['provider:access', 'hospital:access']`).
3. Return user data containing:

```json
{
  "success": true,
  "token": "128|AbCdEf123456...",
  "user": {
    "id": 45,
    "name": "Al-Salam International Hospital",
    "email": "info@alsalamhospital.com",
    "phone": "+20225240250",
    "role": "hospital",
    "user_type": "hospital",
    "permissions": ["manage_hospital", "view_bookings", "manage_staff"]
  }
}
```

---

## 4. Summary of Mobile App Alignments Completed

| App | Feature / Screen | Changes Applied |
| :--- | :--- | :--- |
| **Patient App** | `appointment_details_page.dart` & `detail_info_tile.dart` | Added interactive tap behavior to Location tile that opens Google Maps. |
| **Patient App** | `nursing_service_model.dart` | Added multi-key parser for rating, reviews count, nurses count, and experience years. |
| **Patient App** | `nursing_booking_request_model.dart` | Formatted payload with aliases, sanitized null conditions, and ensured default `pending` status. |
| **Doctor App** | `payment_details_section.dart` & `profile_page.dart` | Added text controllers and persistence pipeline for years of experience, bank transfer, and mobile wallet details. |
| **Doctor App** | `home_visits_page.dart` & `add_service_area_dialog.dart` | Added dialog to configure service locations, radius in km, and tech counts with full Bloc event handling. |
| **Doctor App** | `booking_remote_datasource.dart` | Unified and deduplicated upcoming bookings between Home dashboard and Bookings list. |
| **Doctor App** | `nursing_dashboard_header.dart` | Added navigation to notification center on bell icon tap. |
| **Doctor App** | `nursing_staff_tab.dart` & `nursing_add_staff_page.dart` | Added complete Edit and Delete staff dialogs and actions with Bloc state integration. |
