class PaymentDetailsModel {
  final String paymentType; // 'bank_transfer', 'mobile_wallet'
  final String? accountHolderName;
  final String? bankName;
  final String? accountNumber;

  const PaymentDetailsModel({
    required this.paymentType,
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
  });

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsModel(
      paymentType: json['paymentType'] as String? ?? 'bank_transfer',
      accountHolderName: json['accountHolderName'] as String?,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentType': paymentType,
      'accountHolderName': accountHolderName,
      'bankName': bankName,
      'accountNumber': accountNumber,
    };
  }

  PaymentDetailsModel copyWith({
    String? paymentType,
    String? accountHolderName,
    String? bankName,
    String? accountNumber,
  }) {
    return PaymentDetailsModel(
      paymentType: paymentType ?? this.paymentType,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }
}
