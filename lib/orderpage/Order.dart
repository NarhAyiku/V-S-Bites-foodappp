class Order {
  final double amount;
  final String method;
  final String phoneNumber;
  final String timestamp;
  final List<dynamic> cartDetails;

  Order({
    required this.amount,
    required this.method,
    required this.phoneNumber,
    required this.cartDetails,
    required this.timestamp,
  });



factory Order.fromJson(Map<String, dynamic> json) {
  return Order(
    amount: json['amount']?.toDouble() ?? 0.0,
    method: json['method'] ?? '',
    phoneNumber: json['phone_number'] ?? '',
    cartDetails: json['cartDetails'] ?? [], // ✅ null-safe default
    timestamp: json['timestamp'] ?? '',
  );
}

}
