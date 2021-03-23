import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/university/controller/university_controller.dart';
import 'package:studenthub2/ui/university/view/university_mode.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class University extends StatefulWidget {
  @override
  _UniversityState createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  final TextEditingController _textEditingController = TextEditingController();

  final StreamController<List<UniversityModel>> _streamController =
      StreamController<List<UniversityModel>>.broadcast();

  final UniversityController _universityController = UniversityController();

  UniversityModel _universityModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
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
                child: Image.asset(
              "assets/images/sh.png",
              height: 70,
              width: 70,
            )),
            SizedBox(
              height: 30,
            ),
            sb(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: UiHelper().input(_textEditingController, "University",
                  suffixIcon: Icons.search,
                  textInputAction: TextInputAction.done, onChange: (data) {
                if (data.length > 4) {
                  _universityController.updateController(
                      _streamController, data);
                }
              }),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<List<UniversityModel>>(
                stream: _streamController.stream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return uniListCard(snapshot.data);
                    }
                  }
                  return Container();
                }),
            SizedBox(
              height: 30,
            ),
            UiHelper().button(
                context: context,
                title: "SET",
                onPressed: () {
                  if (_universityModel != null) {
                    _universityController.addToSP(context, _universityModel);
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

  Widget uniListCard(List<UniversityModel> data) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 300,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < data.length; i++)
                ListTile(
                  title: Text(data[i].name),
                  onTap: () {
                    _textEditingController.text = data[i].name;
                    _universityModel = data[i];
                    _streamController.add([]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
