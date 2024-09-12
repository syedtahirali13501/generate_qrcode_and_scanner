import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  const MyCustomButton({super.key, this.onTap, required this.buttonText, this.btnColor, this.btnTextColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =  TextStyle(
        color: btnTextColor ?? Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 15
    );
    var screenWidth = MediaQuery.of(context).size.width;
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: screenWidth * 0.45,
          decoration: BoxDecoration(
             border: Border.all(color: borderColor ?? Colors.transparent),
            color: btnColor ?? Colors.white70,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
            child: Center(child: Text(buttonText,style: textStyle,)),
          ),
        ),
      ),
    );
  }
}
