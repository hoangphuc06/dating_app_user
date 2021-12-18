import 'package:flutter/material.dart';

class SupButton extends StatelessWidget {
  final String name;
  final onpressed;
  const SupButton({
    Key? key,
    required this.name,
    required this.onpressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30.0)
      ),
      child: FlatButton(
        onPressed: onpressed,
        child: Text(
          name,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
