i want to handle logic With UI integration for get profile properly and  remove static data if exist  and depend real API response and  data returen from api


1- end point /api/v1/auth/profile

response will be
{
    "user": {
        "id": "019ef42a-ace4-72d0-bc16-674d1c1999ff",
        "name": "Al Haiah",
        "email": "seada122@gmail",
        "phone_number": "01145079209",
        "role": "laboratory",
        "profile": {
            "id": 13,
            "user_id": "019ef42a-ace4-72d0-bc16-674d1c1999ff",
            "home_sample_collection": 1,
            "collection_fee": "50.00",
            "service_radius_km": 25,
            "tax_id": "TAX-12345",
            "medical_license": "tess125",
            "certificates": [
                "opop"
            ],
            "images": [
                "ood1"
            ],
            "created_at": "2026-06-23 11:08:18",
            "updated_at": "2026-06-23 11:08:18",
            "organization_name": "Al Haiah",
            "organization_type": "Private Lab",
            "organization_number": "01145079209",
            "about": "Brief description about your organization and services",
            "logo": "logo.png",
            "governorate": "Cairo",
            "city": "naser",
            "full_address": "Street, building number, floor",
            "license_number": "14Xt114",
            "working_hours": [
                {
                    "id": 5,
                    "user_id": "019ef42a-ace4-72d0-bc16-674d1c1999ff",
                    "context_type": "laboratory",
                    "day": "Saturday",
                    "from_time": "09:00:00",
                    "to_time": "17:00:00",
                    "is_closed": 0,
                    "created_at": "2026-06-23 11:08:18",
                    "updated_at": "2026-06-23 11:08:18"
                }
            ]
        }
    }
}