import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  bool _loading = false;

  List<TransactionModel> get transactions => _transactions;
  bool get loading => _loading;

  Future<void> fetchTodayTransactions() async {
    _loading = true;
    notifyListeners();

    _transactions = await TransactionService().getTodayTransactions();

    // Tambahkan log untuk memeriksa data transaksi
    for (var transaction in _transactions) {
      print('Transaction: ${transaction.name}, isSpend: ${transaction.isSpend}, amount: ${transaction.amount}');
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> addTransaction({
    required bool isSpend,
    required String name,
    required double amount,
    required String note,
  }) async {
    final newTransaction = TransactionModel(
      id: '', // ID akan dihasilkan oleh Firestore
      isSpend: isSpend,
      name: name,
      amount: amount,
      date: DateTime.now(),
      note: note,
    );
    await TransactionService().addTransaction(newTransaction);
    _transactions.add(newTransaction);
    notifyListeners();
  }
}
