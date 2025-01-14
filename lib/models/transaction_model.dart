import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final bool isSpend;
  final String name;
  final double amount;
  final DateTime date;
  final String? note;

  TransactionModel({
    required this.id,
    required this.isSpend,
    required this.name,
    required this.amount,
    required this.date,
    this.note,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return TransactionModel(
      id: doc.id,
      isSpend: data['isSpend'] ?? true,
      name: data['name'] ?? '',
      amount: data['amount']?.toDouble() ?? 0.0,
      date: (data['date'] as Timestamp).toDate(),
      note: data['note'],
    );
  }
}
