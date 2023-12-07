import 'package:flutter/material.dart';

CustomSnak({String? title}) {
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: const EdgeInsets.only(
      bottom: 30,
      right: 10,
      left: 10,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xffeeeeee),
    elevation: 5,
    content: Text(
      title ?? '',
      style: TextStyle(color: Colors.red[900]),
    ),
  );
}