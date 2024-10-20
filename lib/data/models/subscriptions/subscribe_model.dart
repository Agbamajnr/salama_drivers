class PaystackData {
  final String authorizationUrl;
  final String accessCode;
  final String reference;

  // Constructor to initialize fields
  PaystackData({
    required this.authorizationUrl,
    required this.accessCode,
    required this.reference,
  });

  // A factory constructor to create an instance of PaystackData from a JSON object
  factory PaystackData.fromJson(Map<String, dynamic> json) {
    return PaystackData(
      authorizationUrl: json['authorization_url'],
      accessCode: json['access_code'],
      reference: json['reference'],
    );
  }

  // Convert an instance of PaystackData to JSON format (useful for APIs)
  Map<String, dynamic> toJson() {
    return {
      'authorization_url': authorizationUrl,
      'access_code': accessCode,
      'reference': reference,
    };
  }
}
