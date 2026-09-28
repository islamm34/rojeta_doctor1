# Nursing Module - Backend API Requirements & Specification

## 1. Overview & Current Issues

During mobile app testing with user role `nursing` (`Mohamed nursing`, ID: `01a0c817-bab9-709e-aa92-779101228927`), the following endpoints returned errors in the backend logs:

| Endpoint | Method | Current Status | Cause & Required Fix |
| :--- | :--- | :--- | :--- |
| `/api/v1/nursing/coverage-areas` | `GET`, `POST`, `DELETE` | `404 NOT_FOUND` | Missing route and controller implementation for nursing coverage zones. |
| `/api/v1/nursing/documents` | `GET`, `POST`, `DELETE` | `404 NOT_FOUND` | Missing route and controller implementation for nursing verification documents. |
| `/api/v1/nursing/payment-settings` | `GET`, `PUT` | `404 NOT_FOUND` | Missing payout & payment settings endpoint for nurses. |
| `/api/v1/doctor/payment-details` | `GET` | `405 METHOD NOT ALLOWED` | Nurse account should have its own dedicated `/nursing/payment-settings` endpoint supporting both `GET` and `PUT`/`POST`. |
| `/api/v1/lab/home-visits/config` | `GET` | `403 FORBIDDEN` | Nursing accounts should not query lab-specific routes; coverage areas should be served via `/api/v1/nursing/coverage-areas`. |

---

## 2. Authentication & Headers

All requests include the standard Sanctum Bearer token and accept JSON:

```http
Authorization: Bearer <TOKEN>
Accept: application/json
Content-Type: application/json
```

---

## 3. Detailed Endpoint Specifications

### Module A: Coverage Areas (`/nursing/coverage-areas`)

Manages the geographical regions, cities, radiuses, and transport/collection fees that the nursing provider covers.

#### 1. Get All Coverage Areas

- **Route:** `GET /api/v1/nursing/coverage-areas`
- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Coverage areas retrieved successfully",
  "data": [
    {
      "id": "1",
      "name": "Nasr City & Heliopolis",
      "city": "Cairo",
      "radius_km": 15,
      "extra_fee": 50.0,
      "is_active": true,
      "nurses_count": 3
    },
    {
      "id": "2",
      "name": "New Cairo (5th Settlement)",
      "city": "Cairo",
      "radius_km": 20,
      "extra_fee": 100.0,
      "is_active": false,
      "nurses_count": 2
    }
  ]
}
```

#### 2. Add New Coverage Area

- **Route:** `POST /api/v1/nursing/coverage-areas`
- **Request Body:**

```json
{
  "name": "Maadi & Helwan",
  "city": "Cairo",
  "radius_km": 12,
  "extra_fee": 60.0,
  "is_active": true
}
```

- **Success Response (`201 Created` or `200 OK`):**

```json
{
  "status": true,
  "message": "Coverage area added successfully",
  "data": {
    "id": "3",
    "name": "Maadi & Helwan",
    "city": "Cairo",
    "radius_km": 12,
    "extra_fee": 60.0,
    "is_active": true,
    "nurses_count": 1
  }
}
```

#### 3. Toggle Coverage Area Status

- **Route:** `PATCH /api/v1/nursing/coverage-areas/{id}/toggle` (or `PATCH /api/v1/nursing/coverage-areas/{id}/status`)
- **Request Body:**

```json
{
  "is_active": false
}
```

- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Coverage area status updated successfully",
  "data": {
    "id": "3",
    "is_active": false
  }
}
```

#### 4. Delete Coverage Area

- **Route:** `DELETE /api/v1/nursing/coverage-areas/{id}`
- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Coverage area deleted successfully"
}
```

---

### Module B: Professional Verification Documents (`/nursing/documents`)

Manages required licenses, syndicates, and identification documents for nursing verification.

#### Document Types Supported

1. `medical_license` / `nursing_license` (Nursing Practice License / ترخيص مزاولة المهنة)
2. `syndicate_card` (Syndicate Card / كارنيه النقابة)
3. `commercial_registration` (Commercial Registration / السجل التجاري)
4. `tax_card` (Tax Card / البطاقة الضريبية)
5. `national_id` (National ID / بطاقة الرقم القومي)

#### Document Statuses

- `verified` (Approved)
- `pending` (Under Review)
- `rejected` (Needs re-upload)
- `not_uploaded` (Not submitted yet)

#### 1. Get Documents List

- **Route:** `GET /api/v1/nursing/documents`
- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Documents retrieved successfully",
  "data": [
    {
      "id": "101",
      "type": "medical_license",
      "title": "Nursing Practice License",
      "description": "Valid practice license issued by Ministry of Health",
      "file_url": "https://rojeta.fassla.net/storage/documents/nurse_license_101.pdf",
      "file_name": "nurse_license_101.pdf",
      "status": "verified",
      "rejection_reason": null,
      "uploaded_at": "2026-02-15T10:30:00Z"
    },
    {
      "id": "102",
      "type": "syndicate_card",
      "title": "Syndicate Membership Card",
      "description": "Annual renewal syndicate ID card",
      "file_url": "https://rojeta.fassla.net/storage/documents/syndicate_102.jpg",
      "file_name": "syndicate_102.jpg",
      "status": "pending",
      "rejection_reason": null,
      "uploaded_at": "2026-03-01T14:20:00Z"
    },
    {
      "id": "103",
      "type": "commercial_registration",
      "title": "Commercial Registration",
      "description": "Official company or nursing bureau registration",
      "file_url": null,
      "file_name": null,
      "status": "not_uploaded",
      "rejection_reason": null,
      "uploaded_at": null
    }
  ]
}
```

#### 2. Upload Document

- **Route:** `POST /api/v1/nursing/documents` (or `POST /api/v1/nursing/documents/upload`)
- **Content-Type:** `multipart/form-data`
- **Form Fields:**
  - `document_type`: string (e.g. `medical_license`, `syndicate_card`, `commercial_registration`, `tax_card`, `national_id`)
  - `file`: binary file (PDF, PNG, JPG, JPEG — max 10MB)
- **Success Response (`200 OK` or `201 Created`):**

```json
{
  "status": true,
  "message": "Document uploaded successfully and is under review",
  "data": {
    "id": "104",
    "type": "medical_license",
    "title": "Nursing Practice License",
    "file_url": "https://rojeta.fassla.net/storage/documents/nurse_license_104.pdf",
    "file_name": "nurse_license_104.pdf",
    "status": "pending",
    "rejection_reason": null,
    "uploaded_at": "2026-09-28T17:25:00Z"
  }
}
```

#### 3. Delete / Re-upload Document

- **Route:** `DELETE /api/v1/nursing/documents/{id}`
- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Document deleted successfully"
}
```

---

### Module C: Payment & Payout Settings (`/nursing/payment-settings`)

Configures how earnings and booking payouts are disbursed to the nurse or nursing office.

#### Supported Payment Types

- `bank_transfer`
- `mobile_wallet`

#### Supported Wallet Providers

- `instapay`
- `vodafone_cash`
- `orange_cash`
- `etisalat_cash` / `we_pay`

#### Supported Payout Schedules

- `weekly`
- `biweekly`
- `monthly`

#### 1. Get Payment Settings

- **Route:** `GET /api/v1/nursing/payment-settings`
- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Payment settings retrieved successfully",
  "data": {
    "payment_type": "bank_transfer",
    "account_holder_name": "Mohamed Nursing Services",
    "bank_name": "National Bank of Egypt (NBE)",
    "account_number": "12345678901234",
    "iban": "EG380002000123456789012345678",
    "swift_code": "NBEGEGCX",
    "wallet_provider": "instapay",
    "wallet_number": "01153077553",
    "is_auto_payout": true,
    "payout_schedule": "weekly"
  }
}
```

#### 2. Update Payment Settings

- **Route:** `PUT /api/v1/nursing/payment-settings` (or `POST /api/v1/nursing/payment-settings`)
- **Request Body (Bank Transfer Example):**

```json
{
  "payment_type": "bank_transfer",
  "account_holder_name": "Mohamed Nursing Care",
  "bank_name": "Banque Misr",
  "account_number": "98765432109876",
  "iban": "EG120003000987654321098765432",
  "swift_code": "BMISEGCX",
  "is_auto_payout": true,
  "payout_schedule": "biweekly"
}
```

- **Request Body (Mobile Wallet Example):**

```json
{
  "payment_type": "mobile_wallet",
  "wallet_provider": "vodafone_cash",
  "wallet_number": "01012345678",
  "is_auto_payout": true,
  "payout_schedule": "weekly"
}
```

- **Success Response (`200 OK`):**

```json
{
  "status": true,
  "message": "Payment settings updated successfully",
  "data": {
    "payment_type": "mobile_wallet",
    "wallet_provider": "vodafone_cash",
    "wallet_number": "01012345678",
    "is_auto_payout": true,
    "payout_schedule": "weekly"
  }
}
```

---

## 4. Suggested Laravel `routes/api.php` Structure

```php
Route::middleware(['auth:sanctum', 'role:nursing'])->prefix('nursing')->group(function () {
    // Coverage Areas
    Route::get('/coverage-areas', [NursingCoverageAreaController::class, 'index']);
    Route::post('/coverage-areas', [NursingCoverageAreaController::class, 'store']);
    Route::patch('/coverage-areas/{id}/toggle', [NursingCoverageAreaController::class, 'toggleStatus']);
    Route::patch('/coverage-areas/{id}/status', [NursingCoverageAreaController::class, 'toggleStatus']);
    Route::delete('/coverage-areas/{id}', [NursingCoverageAreaController::class, 'destroy']);

    // Documents
    Route::get('/documents', [NursingDocumentController::class, 'index']);
    Route::post('/documents', [NursingDocumentController::class, 'upload']);
    Route::post('/documents/upload', [NursingDocumentController::class, 'upload']);
    Route::delete('/documents/{id}', [NursingDocumentController::class, 'destroy']);

    // Payment Settings
    Route::get('/payment-settings', [NursingPaymentController::class, 'show']);
    Route::put('/payment-settings', [NursingPaymentController::class, 'update']);
    Route::post('/payment-settings', [NursingPaymentController::class, 'update']);
});
```
