import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialVal;
  final IconData? prefixIcons;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? isEmail;
  final bool? isPhone;
  final bool? isPassword;
  final bool? readOnly;


  const TextFieldWidget(
      {this.hintText,
        this.textInputAction,
        this.labelText,
        this.textInputType,
        required this.controller,
        this.prefixIcons,
        this.suffixIcon,
        this.obscureText,
        this.isEmail,
        this.isPhone,
        this.isPassword,
        super.key, this.readOnly, this.initialVal});



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            keyboardAppearance: Brightness.dark,

            // toolbarOptions: ToolbarOptions(
            //   copy: isPassword != true ? true : false,
            //   paste: isPassword != true ? true : false,
            //   cut: isPassword != true ? true : false,
            //   selectAll: isPassword != true ? true : false,
            // ),
            validator: (value) {
              if (isEmail == true &&
                  (value!.isNotEmpty || value.isEmpty) &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return "Enter a Valid Email";
              } else if (isPassword == true && value!.length < 3) {
                return "Password should be 3 letters";
              }else if(isPhone == true && (value!.length < 11 || value.length >11)){
                return "Phone number must be 11 Digits";
              }  else if (value!.isEmpty) {
                return "Fields are mandatory";
              } else {
                return null;
              }
            },
            textInputAction: textInputAction ?? TextInputAction.done,
            keyboardType: textInputType ?? TextInputType.text,
            controller: controller,
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            initialValue: initialVal,
            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.black26, width: 0.5),
              ),
              floatingLabelStyle: const TextStyle(
                height: 2.5,
                letterSpacing: 2.0,
                fontFamily: "gothic",
                color: Colors.black,
              ),
              iconColor: Colors.black,
              filled: true,
              errorStyle: const TextStyle(
                fontFamily: "gothic",
                color: Colors.red,
              ),
              fillColor: Colors.grey[400],
              labelText: labelText ?? "",
              labelStyle: const TextStyle(
                  color: Colors.black54,
                  // fontWeight: FontWeight.w500
              ),
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              hintText: hintText ?? "",
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white60, width: 0.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.white60, width: 2.0),
              ),
              prefixIcon: prefixIcons != null ? Icon(prefixIcons, color: Colors.black38,)  : null,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
