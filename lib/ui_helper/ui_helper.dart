import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui_helper/button_anim.dart';

class UiHelper {
  Widget input(TextEditingController controller, String label,
      {TextInputAction textInputAction = TextInputAction.next,
      TextInputType textInputType = TextInputType.text,
      String Function(String) validator,
      IconData suffixIcon,
      Function(String) onChange}) {
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.only(top: 15),
        child: TextFormField(
          keyboardType: textInputType,
          controller: controller,
          textInputAction: textInputAction,
          obscureText: textInputType == TextInputType.visiblePassword,
          onChanged: onChange,
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
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
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

  Widget back(BuildContext context, {String title, Function() onTap}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 35),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap ??
                  () {
                    Parent.tabController.animateTo(0);
                  },
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
            SizedBox(
              width: title == null ? 0 : 20,
            ),
            Text(
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
            )
          ],
        ),
      ),
    );
  }

  Widget button(
      {@required BuildContext context,
      @required String title,
      @required Function() onPressed,
      bool anim = false,
      double topMargin = 40,
      Color color,
      double width,
      double height,
      double fontSize}) {
    ValueNotifier<AnimState> valueNotifier = ValueNotifier(AnimState.init);
    return anim
        ? LoadingButton(
            key: UniqueKey(),
            mainChild: Container(
              height: height ?? 55,
              width: width ?? 335,
              margin: EdgeInsets.only(top: topMargin, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  valueNotifier.value = AnimState.loadingStart;
                  try{
                    await onPressed();
                  }catch (e){
                    print(e);
                  }
                  valueNotifier.value = AnimState.loadingEnd;
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    color ?? Color(0xff1e5aa7),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    color ?? Color(0xff1e5aa7),
                  ),
                ),
                child: ValueListenableBuilder(
                  valueListenable: valueNotifier,
                  builder: (_, value, __) => value != AnimState.loadingStart
                      ? Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: fontSize ?? 15,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                              height: 0.8,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
            secondaryChild: Container(
                margin: EdgeInsets.only(top: topMargin, bottom: 20),
                height: 30,
                width: 30,
                child: CircularProgressIndicator()),
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
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  color ?? Color(0xff1e5aa7),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  color ?? Color(0xff1e5aa7),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: fontSize ?? 15,
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

  Widget _searchListCard<T>(
      {@required List<T> data,
      @required String Function(T) titleGetFunction,
      @required Function(T) onTap}) {
    assert(data != null);
    assert(titleGetFunction != null);
    assert(onTap != null);
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
                    title: Text(titleGetFunction(data[i])),
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
      {@required String Function(T) titleGetFunction,
      @required Function(T) onTap}) {
    assert(titleGetFunction != null);
    assert(onTap != null);
    return StreamBuilder<List<T>>(
        stream: streamController.stream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return _searchListCard<T>(
                data: snapshot.data,
                titleGetFunction: titleGetFunction,
                onTap: onTap,
              );
            }
          }
          return Container();
        });
  }
}
