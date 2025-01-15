import 'package:cahyaroom/screens/detail_transaction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 233, 89, 137),
                          const Color.fromARGB(255, 255, 144, 181),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(18),
                    child: SingleChildScrollView(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Hari Ini',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  HugeIcons.strokeRoundedCalendar02,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              DateFormat("dd MMM yyyy").format(DateTime.now()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedArrowUpRight01,
                                color: Colors.white, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Pengeluaran: ${formatCurrency.format(transactionProvider.transactions.where((t) => t.isSpend).fold(0.0, (sum, t) => sum + t.amount))}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        // SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedArrowDownLeft01,
                                color: Colors.white, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Pemasukan: ${formatCurrency.format(transactionProvider.transactions.where((t) => !t.isSpend).fold(0.0, (sum, t) => sum + t.amount))}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    )),
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
                              ? HugeIcons.strokeRoundedMoneySend02
                              : HugeIcons.strokeRoundedMoneyReceive02,
                          color:
                              transaction.isSpend ? Colors.red : Colors.green.shade600,
                        ),
                        title: Flexible(child: Text(transaction.name, style: TextStyle(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
                        subtitle: Text(
                          transaction.date != null
                              ? DateFormat('HH:mm').format(transaction.date)
                              : 'Waktu tidak tersedia',
                        ),
                        // subtitle: TimestampConverter(timestamp: transaction.date,),
                        trailing: Text(
                          formatCurrency.format(transaction.amount),
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          // Navigasi ke halaman detail saat item diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTransactionScreen(
                                  transaction: transaction),
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
