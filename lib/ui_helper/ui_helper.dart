import 'package:flutter/material.dart';

class UiHelper {
  Widget input(TextEditingController controller, String label,
      {TextInputAction textInputAction = TextInputAction.next,
      TextInputType textInputType = TextInputType.text,
      String Function(String) validator}) {
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 15),
        child: TextFormField(
          keyboardType: textInputType,
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

  Widget back(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffecebef),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_sharp,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
      {@required BuildContext context,
      @required String title,
      @required Function() onPressed,
      double topMargin = 40}) {
    return Container(
      height: 55,
      width: 335,
      margin: EdgeInsets.only(top: topMargin, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Color(0xff1e5aa7),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xff1e5aa7),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w500,
              height: 0.8,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
