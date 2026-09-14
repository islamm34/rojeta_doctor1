# Doctor Chat Backend Requirements: Initiate Conversation

## 1. Problem Statement

Currently, a **patient** can initiate a conversation with a doctor by calling:

```http
POST /api/v1/chat/conversations
Headers: Authorization: Bearer <patient_token>
Body: { "doctor_id": "<doctor_uuid>" }
```

This inserts a conversation record in the `conversations` table and generates a `conversation_id` UUID.

However, a **doctor** currently **cannot initiate a conversation** with a patient (e.g., from the appointments list or patient details).

- Calling `POST /api/v1/doctor/chat/conversations` returns:

  ```json
  405 Method Not Allowed: "The POST method is not supported for route api/v1/doctor/chat/conversations. Supported methods: GET, HEAD."
  ```

- Calling the patient's `POST /api/v1/chat/conversations` with a doctor token returns:

  ```json
  403 Forbidden: "You do not have permission to access this resource"
  ```

Because no conversation record exists, subsequent calls to:

- `GET /api/v1/doctor/chat/messages?conversation_id=<patient_id>`
- `POST /api/v1/doctor/chat/send-message` with `conversation_id: <patient_id>`
fail with:

```json
404: { "status": false, "message": "Conversation not found", "error": "NOT_FOUND" }
```

---

## 2. Required Endpoint Specification

### `POST /api/v1/doctor/chat/conversations`

### Headers

| Header | Value | Description |
| :--- | :--- | :--- |
| `Authorization` | `Bearer <doctor_token>` | Authenticated Doctor Sanctum Token |
| `Accept` | `application/json` | |
| `Content-Type` | `application/json` | |

### Request Body

```json
{
  "patient_id": "01a07bab-58a3-7040-8c84-920b7eab5f78"
}
```

### Validation Rules

- `patient_id`: `required|uuid|exists:users,id` (or the appropriate patients/users table).

---

## 3. Business & Controller Logic

1. Retrieve authenticated doctor's ID:

   ```php
   $doctorId = $request->user()->id; // or doctor profile id
   ```

2. Find existing conversation between this doctor and patient:

   ```php
   $conversation = Conversation::where('doctor_id', $doctorId)
       ->where('patient_id', $request->patient_id)
       ->first();
   ```

3. If not found, create a new conversation:

   ```php
   if (!$conversation) {
       $conversation = Conversation::create([
           'doctor_id' => $doctorId,
           'patient_id' => $request->patient_id,
           'type' => 'doctor', // or clinic/doctor
           // other defaults
       ]);
       $statusCode = 201;
   } else {
       $statusCode = 200;
   }
   ```

4. Return the conversation object (matching `GET /doctor/chat/conversations` schema).

---

## 4. Expected Response Format

### Success (200 OK / 201 Created)

```json
{
  "status": true,
  "message": "Conversation retrieved or created successfully",
  "data": {
    "id": "01a09ad4-a53b-7002-b94a-4c58ade33fbe",
    "patient_id": "01a07bab-58a3-7040-8c84-920b7eab5f78",
    "patient_name": "Mohamed Mostafa",
    "patient_avatar": null,
    "last_message": null,
    "last_message_at": null,
    "last_message_time": null,
    "unread_count": 0,
    "created_at": "2026-09-13T12:53:42+00:00"
  }
}
```

### Error Responses

#### Validation Error (422 / 400)

```json
{
  "status": false,
  "message": "Invalid request body",
  "error": "VALIDATION_ERROR",
  "errors": [
    {
      "field": "patient_id",
      "message": "The patient id field must be a valid UUID."
    }
  ]
}
```

#### Unauthorized (401)

```json
{
  "status": false,
  "message": "Unauthenticated.",
  "error": "UNAUTHORIZED"
}
```

---

## 5. Complementary Improvement (Optional but Recommended)

**Auto-create conversation on appointment booking:**
When a patient confirms/books an appointment with a doctor, automatically initialize an empty conversation row between them in the `conversations` table. That way:

- The doctor can message the patient immediately upon viewing the appointment.
- The patient can message the doctor immediately.
- Neither side faces `Conversation not found` (404).

---

## 6. Suggested Laravel Implementation Snippet

### Route (`routes/api.php`)

```php
Route::middleware(['auth:sanctum', 'doctor'])->prefix('doctor/chat')->group(function () {
    Route::get('conversations', [DoctorChatController::class, 'getConversations']);
    Route::post('conversations', [DoctorChatController::class, 'startConversation']); // <-- ADD THIS ROUTE
    Route::get('messages', [DoctorChatController::class, 'getMessages']);
    Route::post('send-message', [DoctorChatController::class, 'sendMessage']);
    Route::post('mark-read', [DoctorChatController::class, 'markAsRead']);
});
```

### Controller Method (`DoctorChatController.php`)

```php
public function startConversation(Request $request)
{
    $validator = Validator::make($request->all(), [
        'patient_id' => 'required|uuid',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => false,
            'message' => 'Invalid request body',
            'error' => 'VALIDATION_ERROR',
            'errors' => $validator->errors(),
        ], 422);
    }

    $doctorId = $request->user()->id;
    $patientId = $request->input('patient_id');

    $conversation = Conversation::firstOrCreate(
        [
            'doctor_id' => $doctorId,
            'patient_id' => $patientId,
        ],
        [
            'created_at' => now(),
            'updated_at' => now(),
        ]
    );

    return response()->json([
        'status' => true,
        'message' => 'Conversation retrieved or created successfully',
        'data' => new DoctorConversationResource($conversation),
    ], $conversation->wasRecentlyCreated ? 201 : 200);
}
```

---

## 7. Flutter App Status

- The Flutter doctor app (`rojeta_doctor`) has already been wired with `DoctorChatRepository.getOrCreateConversation(patientId: ...)`.
- It immediately invokes `POST /api/v1/doctor/chat/conversations` upon tapping the chat button on any appointment or patient details card.
- In case the endpoint is still returning `405 Method Not Allowed` prior to deployment, the app smoothly catches it, checks existing conversations, and suppresses any noisy error banners.
- Once the backend is deployed, the app will instantly and automatically acquire the valid conversation UUID with 0 changes needed on the mobile side.
