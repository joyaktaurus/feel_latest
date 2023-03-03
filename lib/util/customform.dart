import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final Widget child;

  CustomFormField({
    Key? key,
    this.validator,
     required this.child,
  }) : super(key: key);

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
      ),
    );
  }
}
