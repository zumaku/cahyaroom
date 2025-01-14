import 'package:cahyaroom/screens/detail_transaction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTodayTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      body: transactionProvider.loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.pinkAccent,
            ))
          : Column(
              children: [
                // Card untuk Total Pemasukan dan Pengeluaran
                Card(
                  margin: EdgeInsets.all(16),
                  color: Colors.pink[40],
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Hari Ini',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(DateFormat("dd MMM yyyy")
                                .format(DateTime.now()), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.arrow_outward_sharp, color: Colors.red),
                            Text(
                              'Pengeluaran: ${formatCurrency.format(transactionProvider.transactions.where((t) => t.isSpend).fold(0.0, (sum, t) => sum + t.amount))}',
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.arrow_outward_sharp, color: Colors.green),
                            Text(
                              'Pemasukan: ${formatCurrency.format(transactionProvider.transactions.where((t) => !t.isSpend).fold(0.0, (sum, t) => sum + t.amount))}',
                            ),
                          ],
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
                      TransactionModel transaction =
                          transactionProvider.transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction.isSpend
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color:
                              transaction.isSpend ? Colors.red : Colors.green,
                        ),
                        title: Text(transaction.name, style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(
                          transaction.date != null
                              ? DateFormat('h:mm').format(transaction.date)
                              : 'Waktu tidak tersedia',
                        ),
                        // subtitle: TimestampConverter(timestamp: transaction.date,),
                        trailing:
                            Text(formatCurrency.format(transaction.amount), style: TextStyle(fontSize: 14),),
                        onTap: () {
                          // Navigasi ke halaman detail saat item diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTransactionScreen(transaction: transaction),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
