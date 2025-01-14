import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false).fetchTodayTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      body: transactionProvider.loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Card untuk Total Pemasukan dan Pengeluaran
                Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Hari Ini', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(
                          'Pemasukan: Rp ${transactionProvider.transactions.where((t) => !t.isSpend).fold(0.0, (sum, t) => sum + t.amount)}',
                        ),
                        Text(
                          'Pengeluaran: Rp ${transactionProvider.transactions.where((t) => t.isSpend).fold(0.0, (sum, t) => sum + t.amount)}',
                        ),
                      ],
                    ),
                  ),
                ),
                // List Transaksi
                Expanded(
                  child: ListView.builder(
                    itemCount: transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      TransactionModel transaction = transactionProvider.transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction.isSpend ? Icons.arrow_upward : Icons.arrow_downward,
                          color: transaction.isSpend ? Colors.red : Colors.green,
                        ),
                        title: Text(transaction.name),
                        subtitle: Text(transaction.note ?? ''),
                        trailing: Text('Rp ${transaction.amount}'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
