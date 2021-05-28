import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui_helper/button_anim.dart';

class UiHelper {
  Widget input(TextEditingController controller, String label,
      {TextInputAction textInputAction = TextInputAction.next,
      TextInputType textInputType = TextInputType.text,
      String? Function(String?)? validator,
      Widget? suffixIcon,
      bool? obscureText,
      bool capsOn = false,
      Function(String)? onChange}) {
    if (obscureText == null) {
      obscureText = textInputType == TextInputType.visiblePassword;
    }
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 15),
        child: TextFormField(
          keyboardType: textInputType,
          controller: controller,
          textInputAction: textInputAction,
          obscureText: obscureText ?? false,
          onChanged: onChange,
          inputFormatters: capsOn ? [UpperCaseTextFormatter()] : [],
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
            contentPadding: EdgeInsets.only(left: 10, right: 15),
            suffixIcon: suffixIcon,
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
            if (value!.isEmpty) return "$label is required";
            if (validator != null) {
              return validator(value);
            }
            return null;
          },
        ),
      ),
    );
  }

  static AppBar appBar (BuildContext context,{String? title,
    Function()? onTap}){
    return AppBar(
      backgroundColor: Color(0xfffcfcfc),
      foregroundColor: Color(0xfffcfcfc),
      leading: GestureDetector(
        onTap: onTap ??
                () {
              Parent.tabController!.animateTo(0);
            },
        child: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xffafafaf),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 18,
            ),
          ),
        ),
      ),
      title: Text(
        title ?? '',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: const Color(0xff252525),
          fontWeight: FontWeight.w500,
        ),
        textHeightBehavior:
        TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  Widget button(
      {required BuildContext? context,
      required String title,
      required Function() onPressed,
      bool anim = false,
      double topMargin = 40,
      double bottomMargin = 20,
      Color? color,
      Color? borderColor,
      Color? textColor,
      double? width,
      double? height,
      double circleRadius = 30,
      double? fontSize}) {
    ValueNotifier<AnimState> valueNotifier = ValueNotifier(AnimState.init);
    return anim
        ? LoadingButton(
            key: UniqueKey(),
            width: width ?? 335,
            mainChild: Container(
              height: height ?? 55,
              width: width ?? 335,
              margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  valueNotifier.value = AnimState.loadingStart;
                  try {
                    await onPressed();
                  } catch (e) {
                    print(e);
                    showMessage("Something went wrong!");
                  }
                  valueNotifier.value = AnimState.loadingEnd;
                },
                style: ElevatedButton.styleFrom(
                    primary: color ?? Color(0xff1e5aa7),
                    onPrimary: color ?? Color(0xff1e5aa7),
                    side: BorderSide(
                        color: borderColor ?? Colors.transparent,
                        width: borderColor != null ? 1 : 0)),
                child: ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (_, dynamic value, __) =>
                      value != AnimState.loadingStart
                          ? Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: fontSize ?? 15,
                                  color: textColor ?? Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(),
                ),
              ),
            ),
            secondaryChild: Container(
                margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
                height: circleRadius,
                width: circleRadius,
                child: Center(child: CircularProgressIndicator())),
            valueNotifier: valueNotifier)
        : Container(
            height: height ?? 55,
            width: width ?? 335,
            margin: EdgeInsets.only(top: topMargin, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary: color ?? Color(0xff1e5aa7),
                  onPrimary: color ?? Color(0xff1e5aa7),
                  side: BorderSide(
                      color: borderColor ?? Colors.transparent,
                      width: borderColor != null ? 1 : 0)),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: fontSize ?? 15,
                    color: textColor ?? Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
  }

  Widget _searchListCard<T>(
      {required List<T> data,
      required String? Function(T) titleGetFunction,
      required Function(T) onTap}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, minHeight: 30),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < data.length; i++)
                  ListTile(
                    title: Text(titleGetFunction(data[i])!),
                    onTap: () {
                      onTap(data[i]);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchItem<T>(StreamController streamController,
      {required String? Function(T) titleGetFunction,
      required Function(T) onTap}) {
    return StreamBuilder<List<T>>(
        stream: streamController.stream as Stream<List<T>>?,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return _searchListCard<T>(
                data: snapshot.data!,
                titleGetFunction: titleGetFunction,
                onTap: onTap,
              );
            }
          }
          return Container();
        });
  }

  static showSnackMessage(
      {required BuildContext context,
      required String message,
      String? snackBarActionTitle,
      void Function()? onePressed}) {
    assert((snackBarActionTitle == null && onePressed == null) ||
        (snackBarActionTitle != null && onePressed != null));
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: snackBarActionTitle ?? "",
        onPressed: onePressed ?? () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
