import 'package:flutter/material.dart';

class UiHelper {
  Widget input(TextEditingController controller, String label,
      {TextInputAction textInputAction = TextInputAction.next,
      String Function(String) validator}) {
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 15),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          textInputAction: textInputAction,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: const Color(0xff1e5aa7),
            fontWeight: FontWeight.w500,
          ),
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus();
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: const Color(0xff252525),
              fontWeight: FontWeight.w500,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD9D9D9),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff1e5aa7),
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorStyle: TextStyle(color: Colors.red, fontSize: 10),
          ),
          validator: (value) {
            if (value.isEmpty) return "$label is required";
            if (validator != null) {
              return validator(value);
            }
            return null;
          },
        ),
      ),
    );
  }
}
