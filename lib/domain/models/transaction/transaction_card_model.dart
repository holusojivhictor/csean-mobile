class TransactionCardModel {
  final int id;
  final String cardId;
  final String transactionId;
  final double amount;
  final String package;
  final String createdAt;

  TransactionCardModel({
    required this.id,
    required this.cardId,
    required this.transactionId,
    required this.amount,
    required this.package,
    required this.createdAt,
  });
}