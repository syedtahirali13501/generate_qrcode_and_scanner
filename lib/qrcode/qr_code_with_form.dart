import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/qrcode/custom_button_widget.dart';
import 'package:qr_code/qrcode/date_widget.dart';
import 'package:qr_code/qrcode/qr_controller.dart';
import 'package:qr_code/qrcode/textfield_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String? _scannedCode;
//
//   Future<void> _showScannerDialog() async {
//     final code = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Scan QR/Barcode'),
//           content: QrBarCodeScannerDialog(), // Assuming this is a Widget
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//
//     setState(() {
//       _scannedCode = code;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Barcode Scanner Dialog Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _showScannerDialog,
//               child: Text('Scan Barcode/QR Code'),
//             ),
//             if (_scannedCode != null) ...[
//               SizedBox(height: 20),
//               Text('Scanned Code: $_scannedCode'),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

class QRCodeWithForm extends StatefulWidget {
  const QRCodeWithForm({super.key});

  @override
  State<QRCodeWithForm> createState() => _QRCodeWithFormState();
}

class _QRCodeWithFormState extends State<QRCodeWithForm> {
  String? _scannedCode;

  // void _openScanner() async {
  //   // Create and show the QR Code Scanner Dialog
  //   final scannedCode = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Scan QR Code'),
  //         content: QrBarCodeScannerDialog(
  //           onCodeScanned: (code) {
  //             Navigator.of(context).pop(code);
  //           },
  //         ),
  //       );
  //     },
  //   );
  //
  //   // Update the state with the scanned code
  //   setState(() {
  //     _scannedCode = scannedCode;
  //   });
  // }


  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }


  void _scanQRCode(BuildContext context) async {
    await requestCameraPermission();
    final scannedCode = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scan QR Code'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: MobileScanner(
              onDetect: (barcodeCapture) {
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  final String code = barcode.rawValue ?? 'Unknown';
                  Navigator.pop(context, code); // Close dialog and return code
                  break; // Handle only one barcode
                }
              },
            ),
          ),
        );
      },
    );

    if (scannedCode != null && scannedCode.isNotEmpty) {
      // Handle the QR code result
      if (_isURL(scannedCode)) {
        // If the scanned code is a valid URL
        _launchURL(scannedCode); // Open the URL
      } else {
        // If the scanned code is plain text or other data
        _showScannedData(scannedCode); // Show the scanned data
      }
    }
  }

  // Function to show plain text result
  void _showScannedData(String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scanned Data: $data')),
    );
  }

  // Function to open URLs using launchUrl and canLaunchUrl
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  // Function to check if the scanned data is a URL
  bool _isURL(String text) {
    final Uri uri = Uri.tryParse(text) ?? Uri();
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    final formController = Provider.of<QrController>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(title: const Text(
        "Assets Registration", style: TextStyle(color: Colors.white),),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.camera_alt),
          //   onPressed: () {
          //     // _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
          //     //     context: context,
          //     //     onCode: (code) {
          //     //       setState(() {
          //     //         _scannedCode = code;
          //     //       });
          //     //     });
          //     MobileScanner(onDetect: (barcodes) {
          //
          //     },);
          //
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: (){_scanQRCode(context);}
            //     () {
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return
            //         AlertDialog(
            //         title: const Text('Scan QR Code'),
            //         content: SizedBox(
            //           width: double.maxFinite,
            //           height: 400,
            //           child: MobileScanner(
            //             onDetect: (barcodeCapture) {
            //               final List<Barcode> barcodes = barcodeCapture.barcodes;
            //               for (final barcode in barcodes) {
            //                 final String code = barcode.rawValue ?? 'Unknown';
            //                 Navigator.pop(context, code); // Close dialog and return code
            //                 break; // Assuming you only want to handle one barcode
            //               }
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   ).then((code) {
            //     if (code != null) {
            //       setState(() {
            //         _scannedCode = code;
            //       });
            //     }
            //   });
            // },
          ),

        ],
        backgroundColor: Colors.grey,),
      body: SafeArea(child: ListView(
        children: [
          Form(
            key: formController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(controller: formController.assetId,
                  labelText: "Asset ID",
                  textInputType: TextInputType.number,
                  hintText: "Enter Asset ID",),
                TextFieldWidget(controller: formController.assetTitle,
                  labelText: "Asset Title",
                  hintText: "Enter Asset Title",),
                TextFieldWidget(controller: formController.category,
                  labelText: "Category",
                  hintText: "Enter Category",),
                TextFieldWidget(controller: formController.costCenter,
                  labelText: "Cost Center",
                  hintText: "Enter Const Center",),
                TextFieldWidget(controller: formController.model,
                  labelText: "Model",
                  hintText: "Enter Model",),
                TextFieldWidget(controller: formController.manufacturer,
                  labelText: "Manufacturer",
                  hintText: "Enter Manufacturer",),
                TextFieldWidget(controller: formController.serialNo,
                  labelText: "Serial No ",
                  textInputType: TextInputType.number,
                  hintText: "Enter Serial No",),
                TextFieldWidget(controller: formController.physicalLocation,
                  labelText: "Physical Location ",
                  hintText: "Enter Physical Location",),
                MyCustomDatePickerWidget(selectDate: formController.date,
                  onChange: formController.onSelectingDate,
                  title: "Purchase Date : ",),
                MyCustomDatePickerWidget(selectDate: formController.date,
                  onChange: formController.onSelectingDate,
                  title: "Install Date : ",),
                // TextFieldWidget(controller: formController.purchaseData,labelText : "Purchase Date ",hintText: "Enter Purchase Date",),
                // TextFieldWidget(controller: formController.installData,labelText : "Install Date ",textInputType: TextInputType.number,hintText: "Enter Install Date",),
              ],
            ),
          ),


          const SizedBox(height: 20,),

          Row(
            children: [
              MyCustomButton(buttonText: "Register Asset",
                btnColor: Colors.lightGreen,
                onTap: () async {
                  if (formController.formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Form Registered Successfully!'),
                      backgroundColor: Colors.green,
                    ));
                  }
                },),
              MyCustomButton(buttonText: "Generate QR",
                  btnColor: Colors.lightGreen[300],
                  onTap: () {
                    if (formController.formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QRCodeScreen(),
                        ),
                      );
                    }
                  }

              )
            ],
          )
        ],

      )),
    );
  }
}


class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formController = Provider.of<QrController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code for Form Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: formController.formData(),
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Scan the QR code to view the form data.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}