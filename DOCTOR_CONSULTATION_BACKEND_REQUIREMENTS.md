# Doctor Consultation API Requirements & Bug Fix Specification

## 1. Issue Summary

When a doctor attempts to submit a completed medical consultation and prescription via:

```http
POST /api/v1/doctor/consultation
Authorization: Bearer <doctor_sanctum_token>
Accept: application/json
Content-Type: application/json (or multipart/form-data)
```

with the appointment ID returned by `GET /api/v1/doctor/appointments` (e.g., `appointment_id: 66`), the backend returns a **400 Bad Request** validation failure:

```json
{
  "status": false,
  "message": "Invalid request body",
  "error": "VALIDATION_ERROR",
  "errors": [
    {
      "field": "appointment_id",
      "message": "The selected appointment id is invalid."
    }
  ]
}
```

### Context & Evidence

1. `GET /api/v1/doctor/appointments` successfully returns this exact appointment under the authenticated doctor:

   ```json
   {
     "status": true,
     "message": "Appointments retrieved successfully",
     "data": {
       "data": [
         {
           "id": "66",
           "patient_id": "01a07bab-58a3-7040-8c84-920b7eab5f78",
           "service_type": "Clinic",
           "status": "Confirmed",
           "appointment_date": "2026-09-13",
           "appointment_time": "4:00 PM"
         }
       ]
     }
   }
   ```

2. `PATCH /api/v1/doctor/appointments/66/status` with `{"status": "completed"}` or `{"status": "confirmed"}` also successfully finds and updates appointment 66:

   ```json
   {
     "status": true,
     "message": "Appointment status updated to Confirmed",
     "data": { "id": "66", "status": "Confirmed" }
   }
   ```

3. Therefore, appointment ID `66` exists in the database and belongs to the authenticated doctor. However, the validation rule on `POST /doctor/consultation` is rejecting it.

---

## 2. Root Cause Analysis in Laravel Backend

The error message `"The selected appointment id is invalid."` is Laravel's standard translation for the `exists` validation rule.

This occurs due to one of the following reasons in the `DoctorConsultationRequest` or Controller validation:

### Cause A: Wrong Table in `exists` Rule

- The validation rule may be pointing to a different table:
  - e.g., `'appointment_id' => 'required|integer|exists:consultations,appointment_id'` (checking `consultations` instead of `appointments`), which fails because the consultation hasn't been created yet.
  - Or `'appointment_id' => 'required|integer|exists:bookings,id'` while the table is named `appointments` (or vice versa).

### Cause B: User UUID vs Doctor Profile ID Mismatch

- If the rule uses a scoped query:

  ```php
  Rule::exists('appointments', 'id')->where(function ($query) {
      $query->where('doctor_id', auth()->id());
  })
  ```

  In this system, `auth()->user()->id` is a **UUID** (e.g. `01a07bff-bc98-71c4-828c-ec53a88d60b4`), but the `appointments.doctor_id` column might be an **integer** referencing `doctors.id` (or `doctor_profile_id`). Comparing a string UUID against an integer foreign key results in 0 matches.

### Cause C: Status or Service Type Restrictions

- If the validation rule or query includes `where('status', 'in_progress')` or `where('is_online', true)`, appointments with status `"Confirmed"` or service type `"Clinic"` will be rejected.

---

## 3. Required Backend Fix

### 3.1 Form Request Validation Rules

In `App\Http\Requests\Doctor\DoctorConsultationRequest` (or the corresponding request/controller):

```php
namespace App\Http\Requests\Doctor;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class DoctorConsultationRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check() && auth()->user()->role === 'doctor';
    }

    public function rules(): array
    {
        // Resolve doctor ID (support both user UUID and doctor profile integer ID)
        $user = auth()->user();
        $doctorProfileId = $user->doctor?->id;

        return [
            'appointment_id' => [
                'required',
                'integer',
                Rule::exists('appointments', 'id')->where(function ($query) use ($user, $doctorProfileId) {
                    $query->where(function ($q) use ($user, $doctorProfileId) {
                        $q->where('doctor_id', $user->id);
                        if ($doctorProfileId) {
                            $q->orWhere('doctor_id', $doctorProfileId);
                        }
                    });
                }),
            ],
            'diagnosis' => 'required|string',
            'medication_details' => 'nullable|string',
            'laboratory_tests' => 'nullable|string',
            'radiology_tests' => 'nullable|string',
            'follow_up_date' => 'nullable|date_format:Y-m-d',
            'prescription_pdf' => 'nullable|file|mimes:pdf|max:10240',
            'medical_notes_images' => 'nullable|array',
            'medical_notes_images.*' => 'file|mimes:jpeg,png,jpg,webp|max:10240',
            'laboratory_tests_document' => 'nullable|file|mimes:pdf,jpeg,png,jpg,doc,docx|max:10240',
            'radiology_tests_document' => 'nullable|file|mimes:pdf,jpeg,png,jpg,doc,docx|max:10240',
        ];
    }

    public function messages(): array
    {
        return [
            'appointment_id.required' => 'The appointment ID is required.',
            'appointment_id.exists' => 'The selected appointment does not exist or does not belong to your account.',
            'diagnosis.required' => 'Diagnosis is mandatory to complete a medical consultation.',
            'prescription_pdf.mimes' => 'Prescription attachment must be a PDF file.',
            'medical_notes_images.*.mimes' => 'Medical note images must be of type jpeg, png, jpg, or webp.',
            'laboratory_tests_document.mimes' => 'Laboratory document must be a PDF, DOC, DOCX, or image.',
            'radiology_tests_document.mimes' => 'Radiology document must be a PDF, DOC, DOCX, or image.',
        ];
    }
}
```

### 3.2 Controller Implementation

In `App\Http\Controllers\Doctor\DoctorConsultationController`:

```php
public function store(DoctorConsultationRequest $request)
{
    $validated = $request->validated();

    // 1. Upload prescription PDF if provided
    $pdfPath = null;
    if ($request->hasFile('prescription_pdf')) {
        $pdfPath = $request->file('prescription_pdf')->store('prescriptions', 'public');
    }

    // 2. Upload laboratory tests document if provided
    $labDocPath = null;
    if ($request->hasFile('laboratory_tests_document')) {
        $labDocPath = $request->file('laboratory_tests_document')->store('consultations/lab_tests', 'public');
    }

    // 3. Upload radiology tests document if provided
    $radiologyDocPath = null;
    if ($request->hasFile('radiology_tests_document')) {
        $radiologyDocPath = $request->file('radiology_tests_document')->store('consultations/radiology', 'public');
    }

    // 4. Upload medical notes images if provided
    $notesImagePaths = [];
    if ($request->hasFile('medical_notes_images')) {
        foreach ($request->file('medical_notes_images') as $image) {
            $notesImagePaths[] = $image->store('consultations/notes', 'public');
        }
    }

    // 5. Create or update consultation record
    $consultation = Consultation::updateOrCreate(
        ['appointment_id' => $validated['appointment_id']],
        [
            'doctor_id' => auth()->id(),
            'diagnosis' => $validated['diagnosis'],
            'medication_details' => $validated['medication_details'] ?? null,
            'laboratory_tests' => $validated['laboratory_tests'] ?? null,
            'laboratory_tests_document' => $labDocPath,
            'radiology_tests' => $validated['radiology_tests'] ?? null,
            'radiology_tests_document' => $radiologyDocPath,
            'medical_notes_images' => !empty($notesImagePaths) ? json_encode($notesImagePaths) : null,
            'follow_up_date' => $validated['follow_up_date'] ?? null,
            'prescription_pdf' => $pdfPath,
        ]
    );

    // 6. Mark appointment as Completed
    Appointment::where('id', $validated['appointment_id'])->update([
        'status' => 'Completed',
    ]);

    return response()->json([
        'status' => true,
        'message' => 'Consultation submitted successfully',
        'data' => [
            'consultation_id' => $consultation->id,
            'appointment_id' => $consultation->appointment_id,
            'status' => 'Completed',
        ],
    ], 200);
}
```

---

## 4. API Specification

### Endpoint

- **URL**: `POST /api/v1/doctor/consultation`
- **Authentication**: `Bearer <token>`
- **Content-Type**: `multipart/form-data` OR `application/json`

### Request Parameters

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `appointment_id` | `integer` | **Yes** | The ID of the appointment (e.g., `66`). |
| `diagnosis` | `string` | **Yes** | Clinical diagnosis entered by the doctor. |
| `medication_details` | `string` | No | Prescribed medications, dosages, frequency. |
| `laboratory_tests` | `string` | No | Required lab tests. |
| `laboratory_tests_document` | `file` (`.pdf`, `.doc`, `.docx`, images) | No | Optional attached document or file for required laboratory tests. |
| `radiology_tests` | `string` | No | Required radiology/scans. |
| `radiology_tests_document` | `file` (`.pdf`, `.doc`, `.docx`, images) | No | Optional attached document or file for required radiology tests. |
| `medical_notes_images[]` | `file[]` (`.jpg`, `.png`, `.webp`) | No | Optional array of medical note / handwritten note images. |
| `follow_up_date` | `string` (date `YYYY-MM-DD`) | No | Proposed follow-up date. |
| `prescription_pdf` | `file` (`.pdf`) | No | Optional PDF file of the prescription. |

### Success Response (200 OK)

```json
{
  "status": true,
  "message": "Consultation submitted successfully",
  "data": {
    "consultation_id": 42,
    "appointment_id": 66,
    "status": "Completed"
  }
}
```

### Validation Error Response (400 / 422)

```json
{
  "status": false,
  "message": "Invalid request body",
  "error": "VALIDATION_ERROR",
  "errors": [
    {
      "field": "diagnosis",
      "message": "The diagnosis field is required."
    }
  ]
}
```
