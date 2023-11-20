import 'package:flutter/material.dart';

class CustomSignIn_UpTwo extends StatelessWidget {
  CustomSignIn_UpTwo({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
  });
  String title;
  Widget? customizeChild;
  void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.white,
        minimumSize:
        Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.074),
        maximumSize:
        Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.074),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xff0CB502),
          ),
        ),
        backgroundColor: const Color(0xffffffff),
      ),
      onPressed: ontap,
      child: customizeChild??Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xff0CB502),
        ),
      ),
    );
  }
}

class CustomSignIn_UpOne extends StatelessWidget {
  CustomSignIn_UpOne({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
  });
  String title;
  Widget? customizeChild;
  void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          elevation: 5,
          minimumSize:
          Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.074),
          maximumSize:
          Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*0.074),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xff0CB502),
        ),
        onPressed: ontap,
        child: customizeChild??Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}