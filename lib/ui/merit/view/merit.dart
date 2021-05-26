import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/home/model/merit_model.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Merit extends StatelessWidget {
  final List<MeritPointModel> meritList;
  Merit({Key? key, required this.meritList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, onTap: () {
        Navigator.pop(context);
      }, title: "Merit"),
      body: ListView.builder(
        itemCount: meritList.length,
        itemBuilder: (context, position) => channelCard(
            cardColor: getColor(position).first,
            miniCardColor: getColor(position).last,
            merit: meritList[position]),
      ),
    );
  }

  Widget channelCard(
      {required Color cardColor,
      required Color miniCardColor,
      required MeritPointModel merit}) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          boxShadow: [
            BoxShadow(
              color: miniCardColor.withOpacity(0.3),
              offset: Offset(0, 6),
              blurRadius: 6,
            )
          ],
          color: cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: miniCardColor,
              ),
              child: Center(
                child: Text(
                  merit.eventName![0],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    merit.eventName ?? '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0xff252525),
                      fontWeight: FontWeight.w500,
                      height: 2.5714285714285716,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Points:  " + "${merit.meritPointCollected ?? ''}",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: const Color(0xff555555),
                      fontWeight: FontWeight.w500,
                      height: 2.5714285714285716,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }

  final List<List<Color>> _colorList = [
    [Color(0xffEEF6FF), Color(0xff5F9DEE)],
    [Color(0xffF2FCFF), Color(0xff78cce2)],
    [Color(0xffe7e0ff), Color(0xff967fe2)],
    [Color(0xfffee0ff), Color(0xffd07fe2)],
    [Color(0xffffe0e0), Color(0xffe27f7f)],
    [Color(0xfffff6e0), Color(0xffe2c67f)],
    [Color(0xfff1ffe0), Color(0xffa5e27f)],
    [Color(0xffe0fff2), Color(0xff7fe2c3)],
    [Color(0xffe0f8ff), Color(0xff7fc3e2)],
  ];

  List<Color> getColor(int position) {
    return _colorList[position % _colorList.length];
  }
}
