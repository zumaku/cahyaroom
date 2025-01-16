import 'dart:math';

import 'package:flutter/material.dart';

class RandomImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int randomNumber = Random().nextInt(4) + 1; // Angka acak antara 1 dan 4
    final String imagePath = 'assets/images/cahya$randomNumber.png';

    return Image.asset(imagePath);
  }
}
