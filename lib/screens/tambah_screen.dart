import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart'; // Pastikan menggunakan paket Huge Icons
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class TambahScreen extends StatefulWidget {
  @override
  _TambahScreenState createState() => _TambahScreenState();
}

class _TambahScreenState extends State<TambahScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSpend = true;
  String _name = '';
  double _amount = 0.0;
  String _note = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<TransactionProvider>(context, listen: false)
          .addTransaction(
        isSpend: _isSpend,
        name: _name,
        amount: _amount,
        note: _note,
      )
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaksi berhasil ditambahkan!'),
            backgroundColor: Colors.pinkAccent,
          ),
        );
        _formKey.currentState!.reset();
        setState(() {
          _isSpend = true;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan, coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Tombol untuk Pengeluaran/Pemasukan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRadioButton('Pengeluaran', true,
                        HugeIcons.strokeRoundedMoneySend02),
                    SizedBox(width: 10),
                    _buildRadioButton('Pemasukan', false,
                        HugeIcons.strokeRoundedMoneyReceive02),
                  ],
                ),

                SizedBox(height: 20),
                _buildTextInput(
                  label: 'Nama Transaksi',
                  icon: HugeIcons.strokeRoundedWallet01,
                  onSaved: (value) => _name = value!,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nama transaksi wajib diisi'
                      : null,
                ),
                SizedBox(height: 20),
                _buildTextInput(
                  label: 'Jumlah',
                  icon: HugeIcons.strokeRoundedMoney04,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _amount = double.parse(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah wajib diisi';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Masukkan jumlah yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildTextInput(
                  label: 'Catatan',
                  icon: HugeIcons.strokeRoundedNoteEdit,
                  onSaved: (value) => _note = value ?? '',
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: _isSpend ? Colors.pink : Colors.green,
                    foregroundColor: Colors.white,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _isSpend ? Colors.pink : Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(child: Text('Tambahkan')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(String title, bool value, IconData icon) {
    final bool isSelected = _isSpend == value;
    final Color selectedColor = value ? Colors.pink : Colors.green;
    final Color unselectedColor = Colors.grey;

    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isSelected ? selectedColor.withOpacity(0.1) : Colors.white,
          side: BorderSide(
            color: isSelected ? selectedColor : unselectedColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            _isSpend = value;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        labelStyle:TextStyle(color: Colors.grey), // Warna label saat tidak fokus
        floatingLabelStyle: TextStyle(color: _isSpend ? Colors.pink : Colors.green),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _isSpend ? Colors.pinkAccent : const Color.fromARGB(255, 104, 213, 108), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      cursorColor: Colors.grey, // Warna cursor menjadi pink
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
