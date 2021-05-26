import 'package:flutter/material.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, title: "Notifications"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, position) => notificationCard()),
        ),
      ),
    );
  }

  Widget notificationCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      padding: EdgeInsets.only(top: 20, left: 18, right: 18, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xffeeeeee)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Important ',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              color: const Color(0xff252525),
              fontWeight: FontWeight.w500,
              height: 2.4,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              color: const Color(0xff373747),
              height: 1.25,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            '12 DEC 2020',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 10,
              color: const Color(0xff1e5aa7),
              fontWeight: FontWeight.w500,
              height: 3.6,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
