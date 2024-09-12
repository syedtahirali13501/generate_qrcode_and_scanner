import 'package:flutter/material.dart';

class MyCustomDatePickerWidget extends StatelessWidget {
  final selectDate;
  final onChange;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final String? title;
  final dateExpansion;
  final dateStart;

  const MyCustomDatePickerWidget({
    super.key,
    required this.selectDate,
    required this.onChange,
    this.backGroundColor,
    this.borderColor,
    this.title,
    this.dateExpansion,
    this.dateStart, this.textColor,

    // this.dateExpansion,
    // this.dateStart
  });

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                    primary: Colors.blue, onPrimary: Colors.white)),
            child: child!);
      },
      context: context,
      initialDate: selectDate,
      firstDate: dateStart ?? DateTime(2010, 12, 31),
      lastDate: dateExpansion ?? DateTime(2050, 12, 31),
    );
    if (picked != null && picked != selectDate) {
      onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mobileScreen = MediaQuery.of(context).size.shortestSide < 600;

    TextStyle textStyle =  TextStyle(
      fontWeight: FontWeight.w600,
      color: textColor ?? Colors.black54,
      fontFamily: "celias",
    );


    //card to show the date

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
              width: double.infinity, // for mobile its 160 and others its 300
              height: 50.0,
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    // border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 150.0, minHeight: 25.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "Date: ",
                          style: textStyle,
                        ),
                        Text(
                          "${selectDate.toLocal()}".split(' ')[0],
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
