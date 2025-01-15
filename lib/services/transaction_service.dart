import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TransactionModel>> getTodayTransactions() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    QuerySnapshot snapshot = await _firestore
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .orderBy('date')
        .get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _firestore.collection('transactions').add({
      'isSpend': transaction.isSpend,
      'name': transaction.name,
      'amount': transaction.amount,
      'date': Timestamp.fromDate(transaction.date),
      'note': transaction.note,
    });
  }

  Future<void> updateTransaction({
    required String id,
    required bool isSpend,
    required String name,
    required double amount,
    required String note,
  }) async {
    await _firestore.collection('transactions').doc(id).update({
      'isSpend': isSpend,
      'name': name,
      'amount': amount,
      'note': note,
    });
  }

  Future<void> deleteTransaction(String id) async {
    await _firestore.collection('transactions').doc(id).delete();
  }
}
