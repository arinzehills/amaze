import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatefulWidget {
  String hintText;
  String? value;
  bool? obscureText;
  bool? autovalidate;
  TextInputType? keyboardType;
  Function()? onTap;
  Function(String)? onChanged;
  // final VoidCallback pressed;
  Widget? suffixIconButton;
  Widget? prefixIcon;
  String? Function(String?)? validator;

  // IconButton(
  //                                             icon: const Icon(Icons.visibility),
  //                                             color:iconsColor,
  //                                             onPressed: () {
  //                                              if(obscureText==true){
  //                                                 setState(() {
  //                                                   obscureText=false;
  //                                                 });
  //                                               }
  //                                               else{
  //                                                 setState(() {
  //                                             obscureText=true;
  //                                               });
  //                                               }
  //                                             },
  //                                         ),

  MyTextField({
    required this.hintText,
    // required this.pressed,
    this.suffixIconButton,
    this.value,
    this.obscureText,
    this.validator,
    this.autovalidate,
    this.onTap,
    this.onChanged,
    this.keyboardType,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      style:
          TextStyle(height: 1, color: Get.isDarkMode ? Colors.grey[700] : null),
      // maxLines: 2,
      // autovalidate: widget.autovalidate!,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,

      obscureText: widget.obscureText ?? false,
      decoration: textFieldDecoration.copyWith(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIconButton,
        // fillColor: myBlue.withOpacity(0.18),
        // suffixIcon: ,
        hintText: widget.hintText,
        // hintStyle: TextStyle(color: myBlue)
      ),
      onChanged: widget.onChanged,
    );
  }
}
