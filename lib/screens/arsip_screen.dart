import 'package:cahyaroom/screens/detail_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';

class ArsipScreen extends StatefulWidget {
  @override
  _ArsipScreenState createState() => _ArsipScreenState();
}

class _ArsipScreenState extends State<ArsipScreen> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactionsByDate(_selectedDate);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
    Provider.of<TransactionProvider>(context, listen: false)
        .fetchTransactionsByDate(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _selectedDate,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pink.shade300,
                shape: BoxShape.circle,
              ),
            ),
          ),
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
              child: SingleChildScrollView(
                  child: Column(
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
                        DateFormat("dd MMM yyyy").format(_selectedDate),
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ),
          Expanded(
            child: transactionProvider.loading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  ))
                : ListView.builder(
                    itemCount: transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      TransactionModel transaction =
                          transactionProvider.transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction.isSpend
                              ? HugeIcons.strokeRoundedMoneySend02
                              : HugeIcons.strokeRoundedMoneyReceive02,
                          color: transaction.isSpend
                              ? Colors.red
                              : Colors.green.shade600,
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                transaction.name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          transaction.date != null
                              ? DateFormat('HH:mm').format(transaction.date)
                              : 'Waktu tidak tersedia',
                        ),
                        trailing: Text(
                          formatCurrency.format(transaction.amount),
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
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
