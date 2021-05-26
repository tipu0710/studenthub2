import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/home/model/scholarship_model.dart';
import 'package:studenthub2/ui/scholarship/view/single_scholarship.dart';
import 'package:studenthub2/ui_helper/hero_route.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Scholarship extends StatelessWidget {
  final List<ScholarshipModel> scholarshipList;
  const Scholarship({Key? key, required this.scholarshipList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, onTap: () {
        Navigator.pop(context);
      }, title: "Scholarship"),
      body: ListView.builder(
        itemCount: scholarshipList.length,
        itemBuilder: (context, position) =>
            scholarshipCard(context, scholarshipList[position], position),
      ),
    );
  }

  Widget scholarshipCard(
      BuildContext context, ScholarshipModel? scholarshipModel, int position) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(
          HeroRoute(
            builder: (_) => SingleScholarship(
              scholarshipModel: scholarshipModel,
              position: position,
            ),
          ),
        );
      },
      child: Container(
        height: 195,
        width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 6),
                blurRadius: 6,
              )
            ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 195,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: const Color(0xffffffff),
                  border:
                      Border.all(width: 1.0, color: const Color(0xffeeeeee)),
                ),
              ),
            ),
            Hero(
              tag: "${scholarshipModel?.id ?? "null"}i$position",
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 155,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (scholarshipModel?.image == null
                          ? AssetImage("assets/images/test/an_1.png")
                          : CachedNetworkImageProvider(
                              ApiService.baseUrl + scholarshipModel!.image!,
                            )) as ImageProvider<Object>,
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                ),
              ),
            ),
            Hero(
              tag: "title" + "${scholarshipModel?.id ?? "null"}t$position",
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 0.0, bottom: 10, right: 10, left: 25),
                    child: Text(
                      scholarshipModel?.name ?? "",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: const Color(0xff252525),
                        fontWeight: FontWeight.w500,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
