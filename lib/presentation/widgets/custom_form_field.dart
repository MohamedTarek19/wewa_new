import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    super.key,
    required this.title,
    required this.HintText,
    this.obsecure,
    this.visibleOnTap,
    required this.passwordField,
    required this.validation,
    required this.controller,
  });
  String title;
  String HintText;
  bool passwordField;
  bool? obsecure;
  void Function()? visibleOnTap;
  String? Function(String? value)? validation;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.09,
          child: TextFormField(
            controller: controller,
            validator: validation,
            style:  TextStyle(fontSize: 15),
            cursorHeight: 25,
            obscureText: obsecure ?? false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 5),
              filled: true,
              fillColor: Colors.white,
              hintText: HintText,
              suffixIcon: passwordField?IconButton(
                  onPressed: visibleOnTap, icon: const Icon(Icons.visibility)):Icon(Icons.email,color: Colors.transparent,),
              border: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Color(0x77000000), width: 1),
                borderRadius: BorderRadius.circular(5),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Color(0x77000000), width: 1),
                borderRadius: BorderRadius.circular(5),
                gapPadding: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}