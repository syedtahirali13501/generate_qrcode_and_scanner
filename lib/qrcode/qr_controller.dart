import 'package:flutter/cupertino.dart';

class QrController extends ChangeNotifier{
  final TextEditingController assetId = TextEditingController();
  final TextEditingController assetTitle = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController costCenter = TextEditingController();
  final TextEditingController model = TextEditingController();
  final TextEditingController manufacturer = TextEditingController();
  final TextEditingController serialNo = TextEditingController();
  final TextEditingController purchaseData = TextEditingController();
  final TextEditingController installData = TextEditingController();
  final TextEditingController physicalLocation = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  DateTime date = DateTime.now();

  onSelectingDate(newDate){
    date = newDate;

    notifyListeners();
  }



formData(){
 return '''
Asset ID: ${assetId.text}
Asset Title: ${assetTitle.text}
Category: ${category.text}
Cost Center: ${costCenter.text}
Model: ${model.text}
Manufacturer: ${manufacturer.text}
Serial No: ${serialNo.text}
Purchase Date: ${purchaseData.text}
Install Date: ${installData.text}
Physical Location: ${physicalLocation.text}
''';
}




  @override
  void dispose() {
    assetId.dispose();
    assetTitle.dispose();
    category.dispose();
    costCenter.dispose();
    model.dispose();
    manufacturer.dispose();
    serialNo.dispose();
    purchaseData.dispose();
    installData.dispose();
    physicalLocation.dispose();
    super.dispose();
  }
}