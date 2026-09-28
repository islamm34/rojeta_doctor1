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
      paymentType:
          (json['payment_type'] ?? json['paymentType'] ?? 'bank_transfer')
              .toString(),
      accountHolderName:
          (json['account_holder_name'] ??
                  json['accountHolderName'] ??
                  json['holder_name'] ??
                  json['account_name'])
              as String?,
      bankName: (json['bank_name'] ?? json['bankName']) as String?,
      accountNumber:
          (json['account_number'] ??
                  json['accountNumber'] ??
                  json['wallet_number'] ??
                  json['mobile_wallet_number'] ??
                  json['phone'])
              as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_type': paymentType,
      'paymentType': paymentType,
      'account_holder_name': accountHolderName,
      'accountHolderName': accountHolderName,
      'bank_name': bankName,
      'bankName': bankName,
      'account_number': accountNumber,
      'accountNumber': accountNumber,
      'wallet_number': accountNumber,
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
