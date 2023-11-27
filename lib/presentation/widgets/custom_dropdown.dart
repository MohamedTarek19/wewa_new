import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDownIcons extends StatelessWidget {
  CustomDropDownIcons({super.key,
    required this.value,
    required this.list
  });

  Map<String,String>? value;
  List<Map<String,String>>? list;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Container(
          padding: EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
              color: Colors.transparent,

              borderRadius: BorderRadius.circular(5)
          ),
          child: DropdownButton<Map<String,String>?>(
              underline: const SizedBox(),
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(5),
              items: list?.map<DropdownMenuItem<Map<String,String>?>>((e) {
                return DropdownMenuItem<Map<String,String>?>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 3,),
                      SvgPicture.asset(e.entries.first.value,fit: BoxFit.fitWidth,),
                      Text(e.entries.first.key)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  value = val!;
                });
              }),
        );
      },
    );
  }
}