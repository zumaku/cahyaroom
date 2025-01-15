import 'package:cahyaroom/providers/transaction_provider.dart';
import 'package:cahyaroom/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class DetailTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  DetailTransactionScreen({required this.transaction});

  @override
  _DetailTransactionScreenState createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  late TransactionModel transaction;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          content: Text('Yakin ingin menghapus transaksi ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _deleteTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _deleteTransaction() {
    Provider.of<TransactionProvider>(context, listen: false)
        .deleteTransaction(transaction.id)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaksi berhasil dihapus!'),
          backgroundColor: Colors.pinkAccent,
        ),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan, coba lagi.'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

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
              GestureDetector(
                onTap: () async {
                  final updatedTransaction = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditScreen(transaction: transaction),
                    ),
                  );
                  if (updatedTransaction != null) {
                    setState(() {
                      transaction = updatedTransaction;
                    });
                  }
                },
                child: Icon(
                  HugeIcons.strokeRoundedEdit02,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showDeleteConfirmationDialog(context),
                child: Icon(HugeIcons.strokeRoundedDelete01, color: Colors.black),
              ),
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
                Flexible(
                  child: Text(
                    transaction.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade,
                  ),
                ),
                Icon(
                  transaction.isSpend
                      ? HugeIcons.strokeRoundedMoneySend02
                      : HugeIcons.strokeRoundedMoneyReceive02,
                  color:
                      transaction.isSpend ? Colors.red : Colors.green.shade600,
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedCalendar02,
                  size: 20,
                  color: Colors.pinkAccent,
                ),
                SizedBox(width: 3),
                Text(
                  DateFormat('dd MMMM yyyy, HH:mm').format(transaction.date),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedMoney04,
                  color: Colors.pinkAccent,
                  size: 20,
                ),
                SizedBox(width: 3),
                Text(
                  formatCurrency.format(transaction.amount),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedNoteEdit,
                  color: Colors.pinkAccent,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  "Catatan:",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 4),
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
