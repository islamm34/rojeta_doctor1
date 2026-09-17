# توثيق API معامل التحاليل ومراكز الأشعة (Laboratory & Radiology API Documentation)

يقدم هذا المستند توثيقاً شاملاً لكافة واجهات البرمجة (API Endpoints) وتوجيهات لوحة التحكم (Web Dashboard) الخاصة بقطاع **معامل التحاليل الطبية (Laboratory)** و**مراكز الأشعة (Radiology)**، متضمناً طرق الطلب (HTTP Methods)، معاملات الاستعلام (Query Parameters)، جسم الطلب (Request Body)، ونماذج الاستجابة (Response Payload) للعمليات الناجحة والأخطاء.

---

## 🔐 نظام التوثيق والصلاحيات (Authentication & Headers)

تتطلب جميع واجهات API المحمية تمرير رمز الوصول (Bearer Token) في كود الترويسة (Headers):

```http
Authorization: Bearer {YOUR_SANCTUM_TOKEN}
Accept: application/json
Content-Type: application/json
```

---

## 1️⃣ الواجهات العامة وخدمات المرضى (Public & Patient APIs)

### 1.1 عرض كتاّلوج التحاليل الطبية العامة

* **الرابط (Endpoint):** `GET /api/v1/laboratory/tests`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/laboratory/tests`
* **التوثيق:** لا يتطلب توثيق (Public).
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "message": "Laboratory tests catalog retrieved successfully",
  "data": [
    {
      "id": "cbc_test",
      "name": "صورة دم كاملة (CBC)",
      "category": "Hematology",
      "price": 150.00
    },
    {
      "id": "lipid_profile",
      "name": "فحص دهون الدم (Lipid Profile)",
      "category": "Biochemistry",
      "price": 250.00
    }
  ]
}
```

---

### 1.2 عرض كتاّلوج فحوصات الأشعة العامة

* **الرابط (Endpoint):** `GET /api/v1/radiology/scans`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/radiology/scans`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "message": "Radiology scans catalog retrieved successfully",
  "data": [
    {
      "id": "chest_xray",
      "name": "أشعة سينية على الصدر (Chest X-Ray)",
      "category": "X-Ray",
      "price": 300.00
    },
    {
      "id": "brain_mri",
      "name": "رنين مغناطيسي على المخ (Brain MRI)",
      "category": "MRI",
      "price": 1200.00
    }
  ]
}
```

---

### 1.3 جلب قائمة معامل التحاليل المتاحة بالنظام

* **الرابط (Endpoint):** `GET /api/v1/laboratories`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/laboratories`
* **معاملات التصفية (Query Params):**
  * `search` *(اختر)*: اسم المعمل أو المدينة.
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "01a08b8a-4dae-72c8-826f-f55ec7ee6208",
      "name": "معمل النيل للتحاليل الطبية",
      "role": "laboratory",
      "phone_number": "01153077123",
      "rating": 4.9,
      "address": "القاهرة - الدقي"
    }
  ]
}
```

---

### 1.4 جلب فحوصات معمل تحاليل محدد

* **الرابط (Endpoint):** `GET /api/v1/laboratories/{providerId}/tests`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/laboratories/01a08b8a-4dae-72c8-826f-f55ec7ee6208/tests`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "1",
      "name": "فحص السكر التراكمي (HbA1c)",
      "price": 180.00,
      "category": "Diabetes"
    }
  ]
}
```

---

### 1.5 جلب فحوصات مركز أشعة محدد

* **الرابط (Endpoint):** `GET /api/v1/radiology/{providerId}/services`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/radiology/01a08b8a-4dae-72c8-826f-f55ec7ee6208/services`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "10",
      "name": "أشعة تلفزيونية على البطن (Abdominal Ultrasound)",
      "price": 450.00
    }
  ]
}
```

---

### 1.6 تفاصيل المعمل أو مركز الأشعة

* **الرابط (Endpoint):** `GET /api/v1/service-providers/details?id={providerId}`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/service-providers/details?id=01a08b8a-4dae-72c8-826f-f55ec7ee6208`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "message": "Service provider details retrieved successfully",
  "data": {
    "id": "01a08b8a-4dae-72c8-826f-f55ec7ee6208",
    "name": "معمل النيل للتحاليل",
    "role": "laboratory",
    "branches": [
      {
        "id": "b1",
        "name": "فرع الدقي",
        "address": "شارع مصدق - الدقي"
      }
    ],
    "services": [
      {
        "id": "cbc",
        "title": "صورة دم كاملة",
        "price": 150.00
      }
    ]
  }
}
```

---

### 1.7 عرض تقييمات المعمل / الأشعة

* **الرابط (Endpoint):** `GET /api/v1/service-providers/{id}/reviews`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/service-providers/01a08b8a-4dae-72c8-826f-f55ec7ee6208/reviews`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "rev_1",
      "patient_name": "أحمد محمود",
      "rating": 5,
      "comment": "خدمة سريعة ونتائج دقيقة",
      "created_at": "2026-09-15"
    }
  ]
}
```

---

## 2️⃣ إنتاج وإدارة الحجوزات (Bookings API)

### 2.1 إنشاء حجز جديد في معمل تحاليل

* **الرابط (Endpoint):** `POST /api/v1/bookings/laboratory/create`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/bookings/laboratory/create`
* **التوثيق Required:** نعم (`auth:sanctum`).
* **جسم الطلب (Request Body - JSON / Multipart):**

```json
{
  "provider_id": "01a08b8a-4dae-72c8-826f-f55ec7ee6208",
  "provider_name": "معمل النيل للتحاليل الطبية",
  "visit_type": "centerVisit",
  "patient_name": "محمد علي",
  "patient_phone": "01012345678",
  "patient_address": "الجيزة - الدقي",
  "date": "2026-09-20",
  "time": "10:30 AM",
  "selected_items": [
    {
      "title": "صورة دم كاملة (CBC)",
      "price": 150.00
    },
    {
      "title": "فحص وظائف كبد (Liver Function)",
      "price": 250.00
    }
  ],
  "item_ids": ["cbc", "liver_fn"],
  "total_price": 400.00,
  "payment_method": "cash",
  "notes": "يرجى مراعاة الصيام 8 ساعات"
}
```

* **نموذج الاستجابة الناجحة (201 Created / 200 OK):**

```json
{
  "status": "success",
  "message": "Booking confirmed successfully",
  "data": {
    "booking_ref_id": "LAB1726584000",
    "status": "confirmed",
    "payment_status": "pending",
    "total_price": 400.0,
    "service_name": "Lab Tests: صورة دم كاملة (CBC), فحص وظائف كبد (Liver Function)",
    "date": "2026-09-20",
    "time": "10:30:00"
  }
}
```

* **نموذج خطأ التفتيش (400 Bad Request):**

```json
{
  "status": "error",
  "message": "Validation failed",
  "errors": {
    "selected_items": [
      "At least one test or scan must be selected."
    ]
  }
}
```

---

### 2.2 إنشاء حجز جديد في مركز أشعة

* **الرابط (Endpoint):** `POST /api/v1/bookings/radiology/create`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/bookings/radiology/create`
* **جسم الطلب (Request Body):**

```json
{
  "provider_id": "01a08b8a-4dae-72c8-826f-f55ec7ee6208",
  "provider_name": "مركز النيل للأشعة",
  "visit_type": "centerVisit",
  "patient_name": "سارة أحمد",
  "patient_phone": "01198765432",
  "date": "2026-09-22",
  "time": "02:00 PM",
  "selected_items": [
    {
      "title": "رنين مغناطيسي على الركبة (Knee MRI)",
      "price": 1100.00
    }
  ],
  "total_price": 1100.00,
  "payment_method": "credit_card"
}
```

* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": "success",
  "message": "Booking confirmed successfully",
  "data": {
    "booking_ref_id": "RAD1726584500",
    "status": "confirmed",
    "payment_status": "pending",
    "total_price": 1100.0,
    "service_name": "Radiology Scans: رنين مغناطيسي على الركبة (Knee MRI)"
  }
}
```

---

### 2.3 استعراض قائمة الحجوزات (للمعمل / الأشعة)

* **الرابط (Endpoint):** `GET /api/v1/bookings`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/bookings`
* **المعاملات (Query Params):**
  * `status` *(اختر)*: `pending` | `confirmed` | `completed` | `cancelled`
  * `date` *(اختر)*: `2026-09-20`
  * `page` *(اختر)*: `1`
  * `limit` *(اختر)*: `10`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "message": "Success",
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 15,
        "bookingRefId": "LAB1726584000",
        "patientName": "محمد علي",
        "patientPhone": "01012345678",
        "serviceName": "Lab Tests: صورة دم كاملة (CBC)",
        "type": "centerVisit",
        "status": "confirmed",
        "paymentStatus": "pending",
        "date": "2026-09-20",
        "time": "10:30 AM",
        "totalPrice": 400.0
      }
    ],
    "total": 1,
    "per_page": 10
  }
}
```

---

### 2.4 تحديث حالة الحجز (مزود الخدمة)

* **الرابط (Endpoint):** `PATCH /api/v1/bookings/{bookingId}/status`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/bookings/15/status`
* **جسم الطلب (Request Body):**

```json
{
  "status": "completed"
}
```

* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "message": "Booking status updated successfully",
  "data": {
    "id": 15,
    "status": "completed"
  }
}
```

---

## 3️⃣ البيانات المالية والإشعارات (Financial & Notifications)

### 3.1 الملخص المالي للمعمل / مركز الأشعة

* **الرابط (Endpoint):** `GET /api/v1/financial/summary`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/financial/summary`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": {
    "totalIncome": 15000.00,
    "commission": 1500.00,
    "netIncome": 13500.00,
    "pendingPayout": 2000.00
  }
}
```

---

### 3.2 سجل المعاملات والعمليات المالية

* **الرابط (Endpoint):** `GET /api/v1/financial/transactions`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/financial/transactions`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "tx_101",
      "booking_ref_id": "LAB1726584000",
      "service_fee": 400.00,
      "platform_commission": 40.00,
      "earning": 360.00,
      "transaction_date": "2026-09-20 10:30:00"
    }
  ]
}
```

---

### 3.3 جلب التنبيهات والإشعارات

* **الرابط (Endpoint):** `GET /api/v1/notifications/get`
* **المسار الكامل:** `https://rojeta.fassla.net/api/v1/notifications/get`
* **نموذج الاستجابة الناجحة (200 OK):**

```json
{
  "status": true,
  "data": [
    {
      "id": "notif_1",
      "title": "حجز جديد متلقى",
      "body": "قام المريض محمد علي بحجز فحص جديد",
      "read": false,
      "created_at": "2026-09-20 10:31:00"
    }
  ]
}
```

---

## 4️⃣ روابط لوحة التحكم عبر الويب (Web Dashboard Routes)

### 4.1 معمل التحاليل (Laboratory Dashboard)

| الميزّة / الشاشة | المسار (Route Path) | كود الطلب | الوصف |
| :--- | :--- | :--- | :--- |
| الرئيسية والإحصائيات | `GET /dashboard/lab` | HTML View | نظرة عامة على الإيرادات وحجوزات اليوم |
| إدارة الحجوزات | `GET /dashboard/lab/bookings` | HTML View | استعراض وفلترة طلبات الفحوصات |
| تغيير حالة الحجز | `PATCH /dashboard/lab/bookings/{id}/status` | Form Data | قبول/إلغاء/إنهاء حجز |
| قائمة الفحوصات | `GET /dashboard/lab/services` | HTML View | استعراض أسعار وفحوصات المعمل |
| إضافة فحص جديد | `POST /dashboard/lab/services` | Form Data | إضافة تحليل وسعر جديد للمعمل |
| تعديل فحص | `PUT /dashboard/lab/services/{id}` | Form Data | تعديل اسم أو سعر فحص |
| حذف فحص | `DELETE /dashboard/lab/services/{id}` | Form Data | حذف تحليل من قائمة المعمل |
| أقسام المعمل | `GET /dashboard/lab/departments` | HTML View | إدارة الأقسام (كيمياء، هرمونات...) |
| فروع المعمل | `GET /dashboard/lab/branches` | HTML View | إضافة واستعراض فروع المعمل |
| الفحوصات المنزلية | `GET /dashboard/lab/home-visits` | HTML View | إعدادات أسعار وشروط الزيارات المنزلية |
| الحسابات والتقارير | `GET /dashboard/lab/financial` | HTML View | تقارير الأرباح وعمولات المنصة |

---

### 4.2 مركز الأشعة (Radiology Dashboard)

| الميزّة / الشاشة | المسار (Route Path) | كود الطلب | الوصف |
| :--- | :--- | :--- | :--- |
| الرئيسية والإحصائيات | `GET /dashboard/radiology` | HTML View | ملخص حجوزات وأرباح الأشعة |
| إدارة الحجوزات | `GET /dashboard/radiology/bookings` | HTML View | عرض طلبات الأشعة والحالة |
| تغيير حالة حجز | `PATCH /dashboard/radiology/bookings/{id}/status` | Form Data | تحديث حالة الفحص |
| قائمة فحوصات الأشعة | `GET /dashboard/radiology/services` | HTML View | أسعار وفحوصات السونار والرنين |
| إضافة فحص أشعة | `POST /dashboard/radiology/services` | Form Data | إضافة فحص جديد للمركز |
| تعديل فحص أشعة | `PUT /dashboard/radiology/services/{id}` | Form Data | تعديل بيانات وسعر الفحص |
| حذف فحص أشعة | `DELETE /dashboard/radiology/services/{id}` | Form Data | إزالة فحص من القائمة |
| فروع مركز الأشعة | `GET /dashboard/radiology/branches` | HTML View | إدارة الفروع والعناوين |
| تقارير الإيرادات | `GET /dashboard/radiology/financial` | HTML View | استعراض الأرباح وسجل العمليات |
