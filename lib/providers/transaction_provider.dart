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
}
