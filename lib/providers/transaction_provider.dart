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
      print(
          'Transaction: ${transaction.name}, isSpend: ${transaction.isSpend}, amount: ${transaction.amount}');
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

  Future<void> updateTransaction({
    required String id,
    required bool isSpend,
    required String name,
    required double amount,
    required String note,
  }) async {
    await TransactionService().updateTransaction(
      id: id,
      isSpend: isSpend,
      name: name,
      amount: amount,
      note: note,
    );
    await fetchTodayTransactions(); // Perbarui data lokal setelah update
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    await TransactionService().deleteTransaction(id);
    await fetchTodayTransactions(); // Perbarui data setelah penghapusan
    notifyListeners();
  }

  Future<void> fetchTransactionsByDate(DateTime date) async {
    _loading = true;
    notifyListeners();

    _transactions = await TransactionService().getTransactionsByDate(date);

    _loading = false;
    notifyListeners();
  }
}
