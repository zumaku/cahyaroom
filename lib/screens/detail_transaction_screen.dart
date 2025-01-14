import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class DetailTransactionScreen extends StatelessWidget {
  final TransactionModel transaction;

  // Konstruktor menerima transaksi
  DetailTransactionScreen({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Tombol kembali untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan jenis transaksi (Pemasukan/Pengeluaran)
            Text(
              transaction.isSpend ? 'Pengeluaran' : 'Pemasukan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Menampilkan Nama Transaksi
            Text(
              'Nama: ${transaction.name}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Menampilkan Jumlah Transaksi
            Text(
              'Jumlah: ${formatCurrency.format(transaction.amount)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Menampilkan Tanggal Transaksi
            Text(
              'Tanggal: ${DateFormat('dd MMMM yyyy, HH:mm').format(transaction.date)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Menampilkan Catatan Transaksi (jika ada)
            Text(
              'Catatan: ${transaction.note ?? 'Tidak ada catatan'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
