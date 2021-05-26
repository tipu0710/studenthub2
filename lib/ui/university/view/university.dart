import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthub2/ui/university/controller/university_controller.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class University extends StatefulWidget {
  final bool fromReg;

  const University({Key? key, this.fromReg = false}) : super(key: key);
  @override
  _UniversityState createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  final TextEditingController _textEditingController = TextEditingController();

  final StreamController<List<UniversityModel>> _streamController =
      StreamController<List<UniversityModel>>.broadcast();

  late UniversityController _universityController;

  UniversityModel? _universityModel;

  @override
  void initState() {
    _universityController = UniversityController(_streamController);
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    _universityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/svg/single_logo.svg",
                height: 70,
                width: 70,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            sb(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: UiHelper().input(_textEditingController, "University",
                  suffixIcon: Icon(Icons.search),
                  textInputAction: TextInputAction.done, onChange: (data) {
                _universityController.updateController(data);
              }),
            ),
            UiHelper().searchItem(_streamController,
                titleGetFunction: (dynamic uni) {
              return uni.name;
            }, onTap: (dynamic uni) {
              _textEditingController.text = uni.name;
              _universityModel = uni;
              _streamController.add([]);
            }),
            SizedBox(
              height: 30,
            ),
            UiHelper().button(
                context: context,
                title: "SET",
                onPressed: () {
                  if (_universityModel != null) {
                    _universityController.addToSP(context, _universityModel!, widget.fromReg);
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget sb() {
    return Center(
      child: Text(
        'StudentHub',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: const Color(0xff252525),
          fontWeight: FontWeight.w500,
          height: 1.8,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),
    );
  }
}
