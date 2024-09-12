import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/qrcode/qr_code_with_form.dart';
import 'package:qr_code/qrcode/qr_controller.dart';

void main() {
  runApp(
  ChangeNotifierProvider(
      create: (context) => QrController(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      // Dismiss the keyboard when
      // tapped outside of any text input
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    },
    child:MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QRCodeWithForm(),
    ));
  }
}


