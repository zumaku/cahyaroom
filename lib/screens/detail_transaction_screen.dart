import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class DetailTransactionScreen extends StatelessWidget {
  final TransactionModel transaction;

  // Konstruktor menerima transaksi
  DetailTransactionScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(children: [
              Icon(HugeIcons.strokeRoundedEdit02, color: Colors.black),
              SizedBox(width: 16),
              Icon(HugeIcons.strokeRoundedDelete01, color: Colors.black),
            ]),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            HugeIcons.strokeRoundedLinkBackward,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedCalendar02,
                      size: 18,
                      color: transaction.isSpend ? Colors.pink : Colors.green.shade600,
                    ),
                    SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMMM yyyy, HH:mm').format(transaction.date),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    transaction.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade,
                  ),
                ),
                Icon(
                  transaction.isSpend
                      ? HugeIcons.strokeRoundedMoneySend02
                      : HugeIcons.strokeRoundedMoneyReceive02,
                  color: transaction.isSpend ? Colors.pink : Colors.green.shade600,
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Jumlah:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              formatCurrency.format(transaction.amount),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: transaction.isSpend ? Colors.pink : Colors.green.shade600),
            ),
            SizedBox(height: 20),
            Text(
              "Catatan:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              transaction.note ?? "",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
