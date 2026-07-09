import '../models/clinic_model.dart';
import '../models/payment_details_model.dart';
import '../models/profile_model.dart';
import '../models/service_pricing_model.dart';

class ProfileMockData {
  static const ProfileModel mockProfile = ProfileModel(
    id: 'doc_123',
    fullName: 'Dr. Ahmed Hassan',
    email: 'ahmed.hassan@rujeta.com',
    phone: '01111111111',
    specialty: 'Cardiologist',
    subSpecialty: '',
    yearsOfExperience: '',
    about: '',
    education: '',
    imageUrl: '', // You can add a default image URL if needed
    isPro: false,
    clinics: [
      ClinicModel(id: 'clinic_1', name: 'Clinic 1', location: null),
      ClinicModel(id: 'clinic_2', name: 'Clinic 2', location: null),
    ],
    services: [
      ServicePricingModel(
        id: 'srv_1',
        name: 'Clinic Visit',
        isEnabled: true,
        price: 300,
        currency: 'EGP',
      ),
      ServicePricingModel(
        id: 'srv_2',
        name: 'Home Visit',
        isEnabled: true,
        price: 500,
        currency: 'EGP',
      ),
      ServicePricingModel(
        id: 'srv_3',
        name: 'Video Call',
        isEnabled: true,
        price: 200,
        currency: 'EGP',
      ),
      ServicePricingModel(
        id: 'srv_4',
        name: 'Follow-up',
        isEnabled: true,
        price: 150,
        currency: 'EGP',
      ),
    ],
    paymentDetails: PaymentDetailsModel(
      paymentType: 'bank_transfer',
      accountHolderName: 'Ahmed Mohamed',
      bankName: 'Bank Misr',
      accountNumber: '**** **** **** 1234',
    ),
  );
}
