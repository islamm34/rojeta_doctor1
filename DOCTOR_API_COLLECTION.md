# Doctor API Collection & Full Documentation

**Base URL**: `https://rojeta.fassla.net/api/v1`  
**Authentication**: All endpoints (except public authentication) require Bearer Token with `role: doctor`.

```http
Authorization: Bearer <DOCTOR_AUTH_TOKEN>
Accept: application/json
Content-Type: application/json
```

---

## 1. All Enums & Allowed Values (جميع القيم الثابتة)

### 1.1 `AppointmentStatus` (حالات المواعيد)

| Value | Description |
| --- | --- |
| `Pending` / `pending` | موعد في انتظار التأكيد |
| `Confirmed` / `confirmed` | موعد مؤكد ومقبول من الطبيب |
| `Completed` / `completed` | كشف مكتمل وتم الانتهاء منه |
| `Cancelled` / `cancelled` | موعد ملغي |

### 1.2 `VisitType` (نوع الزيارة / الكشف)

| Raw DB Value | Display / Client Value | Description |
| --- | --- | --- |
| `clinic_visit` | `Clinic Visit` | كشف في العيادة |
| `home_visit` | `Home Visit` | كشف منزلي |
| `video_call` | `Video Call` | استشارة أونلاين فيديو |

### 1.3 `DoctorSpecialty` (التخصصات الطبية)

| Enum Key | Display Name |
| --- | --- |
| `cardiology` | Cardiology (أمراض القلب والأوعية الدموية) |
| `pediatrics` | Pediatrics (طب الأطفال وحديثي الولادة) |
| `ophthalmology` | Ophthalmology (طب وجراحة العيون) |
| `orthopedics` | Orthopedics (جراحة العظام والمفاصل) |
| `neurology` | Neurology (المخ والأعصاب) |
| `general` | General Medicine (طب عام) |
| `dermatology` | Dermatology (الجلدية والتناسلية) |
| `dentistry` | Dentistry (طب وجراحة الأسنان) |
| `ent` | ENT (الأنف والأذن والحنجرة) |
| `gynecology` | Gynecology & Obstetrics (النساء والتوليد) |

### 1.4 `DoctorTitle` (الدرجة واللقب العلمي)

| Value | Description |
| --- | --- |
| `Professor` | أستاذ دكتور |
| `Lecturer` | مدرس دكتور |
| `Consultant` | استشاري |
| `Specialist` | أخصائي |

### 1.5 `PaymentType` (نوع وسيلة استلام المستحقات)

| Value | Description |
| --- | --- |
| `bank_transfer` | تحويل بنكي على الحساب |
| `mobile_wallet` | محفظة إلكترونية (فودافون كاش / إنستاباي / إلخ) |

### 1.6 `PaymentMethod` (طريقة دفع الحجز)

| Value | Description |
| --- | --- |
| `cash` | دفع نقدي في العيادة |
| `credit_card` | بطاقة بنكية (فيزا / ماستركارد) |
| `wallet` | محفظة التطبيق |

### 1.7 `BillingCycle` (دورة دفع باقات التسويق)

| Value | Description |
| --- | --- |
| `monthly` | اشتراك شهري |
| `yearly` | اشتراك سنوي |

### 1.8 `WorkingDays` (أيام الأسبوع لجدول المواعيد)

`Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`

### 1.9 `Gender` (الجنس)

`Male`, `Female`

---

## 2. Dashboard & Summary (لوحة التحكم)

### 2.1 Get Doctor Dashboard Stats

- **Method**: `GET`
- **Path**: `/doctor/dashboard`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "todayAppointments": 5,
    "pendingRequests": 2,
    "completedAppointments": 140,
    "newRequests": 3,
    "rating": 4.85,
    "totalEarnings": "45200.00"
  }
}
```

### 2.2 Get Doctor Profile Summary

- **Method**: `GET`
- **Path**: `/doctor/profile/summary`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "name": "Dr. Ahmed Hassan",
    "specialty": "Neurology",
    "imageUrl": "https://rojeta.fassla.net/storage/profiles/avatar.jpg"
  }
}
```

---

## 3. Appointments Management (إدارة المواعيد)

### 3.1 List Appointments

- **Method**: `GET`
- **Path**: `/doctor/appointments`
- **Query Parameters**:
  - `page` (int, default: 1)
  - `limit` (int, default: 15)
  - `date` (string, `YYYY-MM-DD`, optional)
  - `status` (`Confirmed`, `Completed`, `Cancelled`, `pending`, optional)
  - `type` (`Clinic Visit`, `Home Visit`, `Video Call`, optional)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "id": "105",
      "patientName": "محمود حسن",
      "patientAge": "34 yrs",
      "patientGender": "Male",
      "appointmentTime": "04:30 PM",
      "appointmentDate": "2026-09-05",
      "type": "Clinic Visit",
      "status": "Confirmed",
      "patientPhone": "01017891903",
      "isUrgent": false,
      "location": "Nasr City",
      "notes": "صداع مستمر منذ أسبوع",
      "feeOriginal": "500 EGP",
      "feeCurrent": "450 EGP",
      "discount": "10%",
      "paymentMethod": "credit_card",
      "isOnline": false
    }
  ],
  "pagination": {
    "total": 45,
    "count": 1,
    "perPage": 15,
    "currentPage": 1,
    "totalPages": 3
  }
}
```

### 3.2 Update Appointment Status

- **Method**: `PATCH`
- **Path**: `/doctor/appointments/{appointmentId}/status`

#### Request Body

```json
{
  "status": "Confirmed"
}
```

*(القيم المسموحة: `Confirmed`, `Completed`, `Cancelled`)*

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Appointment status updated successfully"
}
```

---

## 4. Patients & History (المرضى وسجلاتهم)

### 4.1 List Doctor's Patients

- **Method**: `GET`
- **Path**: `/doctor/patients`
- **Query Parameters**:
  - `page` (int)
  - `limit` (int)
  - `search` (string, اسم المريض أو رقم الهاتف)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "id": "p01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
      "name": "محمود حسن",
      "phone": "01017891903",
      "age": 34,
      "gender": "Male",
      "visitsCount": 3,
      "lastVisitDate": "2026-08-20T14:30:00.000000Z",
      "lastDiagnosis": "الصداع النصفي المزمن"
    }
  ],
  "pagination": { ... }
}
```

### 4.2 Get Patient Details & Medical Record

- **Method**: `GET`
- **Path**: `/doctor/patients/{patientId}`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "basicInfo": {
      "id": "p01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
      "name": "محمود حسن",
      "phone": "01017891903",
      "age": 34,
      "gender": "Male",
      "visitsCount": 3,
      "lastVisitDate": "2026-08-20T14:30:00.000000Z",
      "lastDiagnosis": "الصداع النصفي المزمن"
    },
    "allergies": ["البنسلين", "الأسبرين"],
    "chronicConditions": ["ارتفاع ضغط الدم"],
    "visitHistory": [
      {
        "id": "v12",
        "date": "2026-08-20T14:30:00.000000Z",
        "type": "Clinic Visit",
        "diagnosis": "الصداع النصفي المزمن",
        "prescription": "Panadol Extra 500mg مرتين يومياً بعد الأكل",
        "notes": "إجراء فحص رنين مغناطيسي في حال استمرار الصداع",
        "followUpDate": "2026-09-10T00:00:00.000000Z"
      }
    ],
    "labResults": [
      {
        "id": "lr4",
        "date": "2026-08-15T00:00:00.000000Z",
        "testsPerformed": "CBC, ESR",
        "results": "WBC: 7.2, Hemoglobin: 14.5",
        "notes": "النتائج طبيعية",
        "isNormal": true
      }
    ]
  }
}
```

---

## 5. Consultations & E-Prescriptions (الكشف والروشتة الإلكترونية)

### 5.1 Submit Consultation & Prescription

- **Method**: `POST`
- **Path**: `/doctor/consultation`
- **Content-Type**: `multipart/form-data` أو `application/json`

#### Request Body

```json
{
  "appointment_id": 105,
  "diagnosis": "التهاب الجيوب الأنفية الحاد مصحوب بصداع",
  "medication_details": "1. Augmentin 1g - قرص كل 12 ساعة لمدة 7 أيام\n2. Otrivin Nasal Spray - بخة في كل فتحة أنف مرتين يومياً\n3. Cataflam 50mg - قرص عند اللزوم بعد الأكل",
  "laboratory_tests": "صورة دم كاملة CBC",
  "radiology_tests": "أشعة مقطعية على الجيوب الأنفية CT Paranasal Sinuses",
  "follow_up_date": "2026-09-15",
  "prescription_pdf": "<File Upload - PDF (اختياري)>"
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Consultation submitted successfully",
  "data": {
    "consultationId": "c42"
  }
}
```

---

## 6. Doctor Schedule & Working Hours (جدول المواعيد والإجازات)

### 6.1 Get Doctor Schedule & Vacations

- **Method**: `GET`
- **Path**: `/doctor/schedule`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "working_days": [
      {
        "day_name": "Sunday",
        "is_active": true,
        "time_slots": [
          { "start_time": "10:00 AM", "end_time": "02:00 PM" },
          { "start_time": "06:00 PM", "end_time": "10:00 PM" }
        ]
      },
      {
        "day_name": "Monday",
        "is_active": true,
        "time_slots": [
          { "start_time": "05:00 PM", "end_time": "09:00 PM" }
        ]
      },
      {
        "day_name": "Friday",
        "is_active": false,
        "time_slots": []
      }
    ],
    "vacations": [
      {
        "id": "1",
        "start_date": "2026-09-20",
        "end_date": "2026-09-25"
      }
    ]
  }
}
```

### 6.2 Update Schedule & Vacations

- **Method**: `PUT`
- **Path**: `/doctor/schedule`

#### Request Body

```json
{
  "working_days": [
    {
      "day_name": "Sunday",
      "is_active": true,
      "time_slots": [
        { "start_time": "10:00 AM", "end_time": "02:00 PM" },
        { "start_time": "06:00 PM", "end_time": "10:00 PM" }
      ]
    },
    {
      "day_name": "Monday",
      "is_active": true,
      "time_slots": [
        { "start_time": "05:00 PM", "end_time": "09:00 PM" }
      ]
    },
    {
      "day_name": "Friday",
      "is_active": false,
      "time_slots": []
    }
  ],
  "vacations": [
    {
      "start_date": "2026-09-20",
      "end_date": "2026-09-25"
    }
  ]
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Schedule updated successfully"
}
```

---

## 7. Doctor Profile & Clinics (الملف الشخصي والعيادات)

### 7.1 Get Full Doctor Profile

- **Method**: `GET`
- **Path**: `/doctor/profile`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "id": "doc_01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
    "fullName": "Dr. Ahmed Hassan",
    "email": "dr.ahmed@example.com",
    "phone": "01012345678",
    "specialty": "Neurology",
    "subSpecialty": "Brain & Spine Surgery",
    "yearsOfExperience": "15",
    "about": "استشاري أول جراحة المخ والأعصاب والعمود الفقري بمستشفيات جامعة القاهرة",
    "education": "دكتوراه جراحة المخ والأعصاب - قصر العيني، زميل كلية الجراحين الملكية بإنجلترا",
    "imageUrl": "https://rojeta.fassla.net/storage/profiles/avatar.jpg",
    "isPro": true,
    "clinics": [
      {
        "id": "clinic_1",
        "name": "NeuroCare Specialist Clinic",
        "phone": "0223456789",
        "governorate": "Cairo",
        "city": "Nasr City",
        "fullAddress": "45 شارع عباس العقاد، الدور الرابع",
        "photos": ["https://rojeta.fassla.net/storage/clinics/clinic1.jpg"],
        "consultationTime": 30,
        "workingHours": {
          "Saturday": ["04:00 PM - 09:00 PM"],
          "Monday": ["05:00 PM - 10:00 PM"]
        },
        "clinicVisitPrice": 450.0,
        "followUpPrice": 200.0,
        "homeVisitPrice": 800.0,
        "videoCallPrice": 350.0
      }
    ],
    "services": [
      {
        "id": "srv_1",
        "name": "Clinic Visit",
        "isEnabled": true,
        "price": 450.0,
        "currency": "EGP"
      },
      {
        "id": "srv_2",
        "name": "Home Visit",
        "isEnabled": true,
        "price": 800.0,
        "currency": "EGP"
      },
      {
        "id": "srv_3",
        "name": "Video Call",
        "isEnabled": true,
        "price": 350.0,
        "currency": "EGP"
      }
    ],
    "paymentDetails": {
      "paymentType": "bank_transfer",
      "accountHolderName": "Ahmed Hassan Mohamed",
      "bankName": "CIB - Commercial International Bank",
      "accountNumber": "**** **** **** 5678"
    }
  }
}
```

### 7.2 Update Doctor Profile

- **Method**: `PUT`
- **Path**: `/doctor/profile`

#### Request Body

```json
{
  "fullName": "Dr. Ahmed Hassan Mohamed",
  "specialty": "Neurology",
  "subSpecialty": "Brain & Spine Surgery",
  "yearsOfExperience": 16,
  "about": "استشاري أول جراحة المخ والأعصاب والعمود الفقري",
  "education": "دكتوراه قصر العيني، زميل كلية الجراحين الملكية"
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Profile updated successfully"
}
```

### 7.3 Add New Clinic

- **Method**: `POST`
- **Path**: `/doctor/clinics`
- **Content-Type**: `multipart/form-data` أو `application/json`

#### Request Body

```json
{
  "name": "عيادة مصر الجديدة التخصصية",
  "phone": "0224156789",
  "governorate": "Cairo",
  "city": "Heliopolis",
  "fullAddress": "12 شارع الأهرام، الكوربة، مصر الجديدة",
  "consultationTime": 30,
  "clinicVisitPrice": 500,
  "followUpPrice": 250,
  "homeVisitPrice": 900,
  "videoCallPrice": 400,
  "workingHours": {
    "Sunday": ["05:00 PM - 09:00 PM"],
    "Tuesday": ["05:00 PM - 09:00 PM"]
  },
  "photos": ["<files (اختياري)>"]
}
```

#### Response (201 Created)

```json
{
  "status": true,
  "message": "Clinic added successfully",
  "data": {
    "id": "clinic_2"
  }
}
```

### 7.4 Update Existing Clinic

- **Method**: `PUT`
- **Path**: `/doctor/clinics/{clinicId}`

#### Request Body

```json
{
  "name": "عيادة مصر الجديدة التخصصية المحدثة",
  "phone": "01099887766",
  "clinicVisitPrice": 550,
  "followUpPrice": 250
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Clinic updated successfully"
}
```

### 7.5 Update Doctor Services & Pricing

- **Method**: `PUT`
- **Path**: `/doctor/services`

#### Request Body

```json
{
  "services": [
    {
      "id": "srv_1",
      "isEnabled": true,
      "price": 500,
      "currency": "EGP"
    },
    {
      "id": "srv_2",
      "isEnabled": false,
      "price": 800,
      "currency": "EGP"
    }
  ]
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Services updated successfully"
}
```

### 7.6 Update Payment & Bank Details

- **Method**: `PUT`
- **Path**: `/doctor/payment-details`

#### Request Body

```json
{
  "paymentType": "bank_transfer",
  "accountHolderName": "Ahmed Hassan Mohamed",
  "bankName": "Banque Misr",
  "accountNumber": "1234567890123456"
}
```

*(أو `paymentType`: `mobile_wallet` مع رقم الهاتف في `accountNumber`)*

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Payment details updated successfully"
}
```

---

## 8. Analytics & Performance (التحليلات والأرباح)

### 8.1 Get Doctor Analytics

- **Method**: `GET`
- **Path**: `/doctor/analytics`
- **Query Parameters**:
  - `month` (string, e.g. `September 2026`, optional - default current month)

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "monthLabel": "September 2026",
    "totalPatients": 84,
    "newPatients": 35,
    "returningPatients": 49,
    "totalRevenue": 42000.0,
    "expenses": 4200.0,
    "netIncome": 37800.0,
    "avgPerPatient": 500.0,
    "totalAppointments": 92,
    "completedAppointments": 88,
    "cancelledAppointments": 4,
    "patientGrowthPercent": 14.5,
    "revenueGrowthPercent": 18.2,
    "successRate": 95.7
  }
}
```

---

## 9. Marketing & Promotion (التسويق والباقات)

### 9.1 Get Marketing Packages & Active Subscription

- **Method**: `GET`
- **Path**: `/doctor/marketing/packages`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "packages": [
      {
        "id": 1,
        "nameKey": "Silver Growth Plan",
        "postsPerMonth": 10,
        "monthlyPrice": 800.0,
        "yearlyPrice": 8000.0,
        "isMostPopular": false,
        "platforms": ["Facebook", "Instagram"],
        "features": [
          "10 بوستات شهرياً مصممة باحترافية",
          "نشر عبر فيسبوك وإنستجرام",
          "إدارة الإعلانات الممولة"
        ]
      },
      {
        "id": 2,
        "nameKey": "Gold Pro Plan",
        "postsPerMonth": 25,
        "monthlyPrice": 1500.0,
        "yearlyPrice": 15000.0,
        "isMostPopular": true,
        "platforms": ["Facebook", "Instagram", "TikTok", "LinkedIn"],
        "features": [
          "25 بوست وتصميم شهرياً",
          "فيديوهات Reels طبية قصيرة",
          "ظهور في أعلى نتائج البحث للتخصص"
        ]
      }
    ],
    "activePlan": {
      "packageId": 2,
      "postsUsed": 8,
      "totalPosts": 25,
      "startDate": "2026-09-01T00:00:00.000000Z",
      "endDate": "2026-09-30T23:59:59.000000Z"
    }
  }
}
```

### 9.2 Subscribe to Marketing Package

- **Method**: `POST`
- **Path**: `/doctor/marketing/subscribe`

#### Request Body

```json
{
  "packageId": 2,
  "billingCycle": "monthly"
}
```

*(الـ `billingCycle`: إما `monthly` أو `yearly`)*

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Subscription successful",
  "data": {
    "subscriptionId": "sub_15"
  }
}
```

---

## 10. Notifications (الإشعارات)

### 10.1 List Doctor Notifications

- **Method**: `GET`
- **Path**: `/doctor/notifications`
- **Query Parameters**:
  - `page` (int)
  - `limit` (int)
  - `isRead` (boolean, `true` / `false`)
  - `type` (string)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "id": "101",
      "title": "طلب كشف جديد",
      "body": "قام المريض محمود حسن بحجز موعد كشف عيادة يوم السبت 4:30 مساءً",
      "time": "منذ 10 دقائق",
      "isRead": false,
      "priority": "Normal",
      "type": "appointment_booking"
    }
  ],
  "pagination": { ... }
}
```

### 10.2 Mark Notification as Read

- **Method**: `PATCH`
- **Path**: `/doctor/notifications/{notificationId}/read`

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Notification marked as read"
}
```

---

## 11. Settings (الإعدادات والتفضيلات)

### 11.1 Get Doctor Settings

- **Method**: `GET`
- **Path**: `/doctor/settings`

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "emailNotifications": true,
    "smsNotifications": true,
    "pushNotifications": true,
    "appointmentReminders": true,
    "marketingEmails": false
  }
}
```

### 11.2 Update Doctor Settings

- **Method**: `PUT`
- **Path**: `/doctor/settings`

#### Request Body

```json
{
  "emailNotifications": true,
  "smsNotifications": false,
  "pushNotifications": true,
  "appointmentReminders": true,
  "marketingEmails": false
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Settings updated successfully"
}
```

---

## 12. Doctor Chat & Messaging (محادثات الطبيب والمريض)

### 12.1 Get Doctor Conversations

- **Method**: `GET`
- **Path**: `/doctor/chat/conversations`
- **Query Parameters**:
  - `page` (int, default: 1)
  - `limit` (int, default: 30)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "id": "conv_9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
      "patientId": "01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
      "patientName": "محمود حسن",
      "patientAvatar": "https://rojeta.fassla.net/storage/profiles/patient1.jpg",
      "lastMessage": "تمام يا دكتور هعمل التحاليل المطلوبة وأبعتها لحضرتك",
      "lastMessageTime": "03:45 PM",
      "unreadCount": 2
    }
  ],
  "pagination": {
    "total": 12,
    "perPage": 30,
    "currentPage": 1,
    "totalPages": 1
  }
}
```

### 12.2 Get Messages in Conversation

- **Method**: `GET`
- **Path**: `/doctor/chat/messages`
- **Query Parameters**:
  - `conversation_id` (UUID, required)
  - `page` (int)
  - `limit` (int)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "id": "msg_101",
      "senderId": "01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
      "senderRole": "patient",
      "content": "يا دكتور الصداع خف شوية بس لسه فيه دوخة",
      "createdAt": "2026-09-03T13:20:00Z",
      "isMe": false
    },
    {
      "id": "msg_102",
      "senderId": "doc_01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
      "senderRole": "doctor",
      "content": "استمر على العلاج واشرب سوائل كافية وهنتابع نتيجة التحاليل",
      "createdAt": "2026-09-03T13:25:00Z",
      "isMe": true
    }
  ],
  "pagination": {
    "total": 24,
    "perPage": 20,
    "currentPage": 1,
    "totalPages": 2
  }
}
```

### 12.3 Send Message

- **Method**: `POST`
- **Path**: `/doctor/chat/send-message`

#### Request Body

```json
{
  "conversation_id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
  "content": "أهلاً بك، تم الاطلاع على التحاليل وهي مطمئنة جداً"
}
```

#### Response (201 Created)

```json
{
  "status": true,
  "message": "Message sent successfully",
  "data": {
    "id": "msg_103",
    "conversationId": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
    "senderId": "doc_01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
    "content": "أهلاً بك، تم الاطلاع على التحاليل وهي مطمئنة جداً",
    "createdAt": "2026-09-03T15:45:00Z",
    "isMe": true
  }
}
```

### 12.4 Mark Conversation as Read

- **Method**: `POST`
- **Path**: `/doctor/chat/mark-read`

#### Request Body

```json
{
  "conversation_id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a"
}
```

#### Response (200 OK)

```json
{
  "status": true,
  "message": "Conversation marked as read",
  "data": {
    "conversation_id": "9d8e7f6a-5b4c-3d2e-1f0a-9b8c7d6e5f4a",
    "unread_count": 0
  }
}
```

---

## 13. Financials & Wallet Transactions (المعاملات المالية والمحفظة)

### 13.1 Financial Summary

- **Method**: `GET`
- **Path**: `/financial/summary`
- **Query Parameters**:
  - `startDate` (`YYYY-MM-DD`, optional)
  - `endDate` (`YYYY-MM-DD`, optional)

#### Response (200 OK)

```json
{
  "status": true,
  "data": {
    "totalIncome": 45000.0,
    "completedAppointments": 90,
    "commission": 4500.0,
    "netIncome": 40500.0
  }
}
```

### 13.2 Financial Transactions List

- **Method**: `GET`
- **Path**: `/financial/transactions`
- **Query Parameters**:
  - `page` (int)
  - `limit` (int)
  - `status` (string, `completed`, `pending`, optional)
  - `startDate` (`YYYY-MM-DD`, optional)
  - `endDate` (`YYYY-MM-DD`, optional)

#### Response (200 OK)

```json
{
  "status": true,
  "data": [
    {
      "patientName": "محمود حسن",
      "visitType": "clinic_visit",
      "status": "completed",
      "date": "2 Sep 2026",
      "time": "04:30 PM",
      "serviceFee": 500.0,
      "platformCommission": 50.0,
      "yourEarning": 450.0
    }
  ],
  "pagination": {
    "total": 90,
    "perPage": 15,
    "currentPage": 1,
    "totalPages": 6
  }
}
```

---

## 14. Doctor Authentication & Onboarding (تسجيل ودخول الطبيب)

### 14.1 Doctor Registration

- **Method**: `POST`
- **Path**: `/auth/register`

#### Request Body

```json
{
  "name": "Dr. Ahmed Hassan",
  "email": "dr.ahmed@example.com",
  "phone_number": "01012345678",
  "password": "Password123!",
  "password_confirmation": "Password123!",
  "role": "doctor",
  "specialty": "Neurology",
  "sub_specialty": "Spine Surgery",
  "title": "Consultant",
  "experience_years": 15,
  "medical_license": "DOC-EG-998877"
}
```

#### Response (201 Created)

```json
{
  "message": "User registered successfully",
  "token": "105|aBcDeFgHiJkLmNoP...",
  "user": {
    "id": "01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
    "name": "Dr. Ahmed Hassan",
    "email": "dr.ahmed@example.com",
    "phone_number": "01012345678",
    "role": "doctor"
  }
}
```

### 14.2 Doctor Login

- **Method**: `POST`
- **Path**: `/auth/login`

#### Request Body

```json
{
  "phone_number": "01012345678",
  "password": "Password123!"
}
```

#### Response (200 OK)

```json
{
  "message": "Login successful",
  "token": "106|zYxWvUtSrQpOnMlK...",
  "user": {
    "id": "01a05c09-8e1e-7040-a6b5-a7d9234e92ad",
    "name": "Dr. Ahmed Hassan",
    "email": "dr.ahmed@example.com",
    "phone_number": "01012345678",
    "role": "doctor"
  }
}
```
