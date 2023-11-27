import 'package:flutter/material.dart';
import 'package:wewa/presentation/widgets/custom_dropdown.dart';

class CustomPhoneFormField extends StatelessWidget {
  CustomPhoneFormField({
    super.key,
    required this.title,
    required this.HintText,
    required this.validation,
    required this.controller,
    required this.val,
    required this.list,
  });

  String title;
  String HintText;
  String? Function(String? value)? validation;
  TextEditingController controller;
  Map<String, String>? val;
  List<Map<String, String>>? list;

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
          height: MediaQuery.of(context).size.height * 0.09,
          child: TextFormField(
            controller: controller,
            validator: validation,
            style: TextStyle(fontSize: 15),
            cursorHeight: 25,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 5),
              filled: true,
              fillColor: Colors.white,
              hintText: HintText,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0x77000000), width: 1),
                borderRadius: BorderRadius.circular(5),
                gapPadding: 10,
              ),
              prefixIcon: SizedBox(
                width: MediaQuery.of(context).size.width*0.25,

                child: CustomDropDownIcons(
                  value: val,
                  list: list,
                ),
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
