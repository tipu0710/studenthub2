import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/home/controller/home_controller.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui_helper/custom_icons.dart';
import 'package:studenthub2/ui_helper/effect.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController;
  @override
  void initState() {
    homeController = HomeController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<bool>(
          future: homeController.getDashboard(),
          builder: (_, snapshot) {
            int step = 1;
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              loading = false;
              step = homeController.homeModel.channelList.length;
            }
            return Container(
              margin: EdgeInsets.only(top: 35),
              child: Column(
                children: [
                  profile(loading),
                  menu(loading),
                  !loading && homeController.homeModel.eventList.length > 0
                      ? announcementTitle('Latest Announcement', loading)
                      : Container(),
                  announcement(loading),
                  step > 0
                      ? announcementTitle("Channel", loading)
                      : Container(),
                  for (int i = 0; i < step; i++)
                    orientationCard(
                        cardColor: homeController.getColor(i).first,
                        miniCardColor: homeController.getColor(i).last,
                        title: loading
                            ? ""
                            : homeController?.homeModel?.channelList[i].name ??
                                "",
                        subtitle: loading
                            ? ""
                            : homeController
                                    ?.homeModel?.channelList[i].lastChanged ??
                                "",
                        loading: loading),
                  ad(loading),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget orientationCard(
      {@required Color cardColor,
      @required miniCardColor,
      @required String title,
      @required String subtitle,
      @required loading}) {
    return ShimmerLoading(
      isLoading: loading,
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: cardColor,
        ),
        child: Row(
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: miniCardColor,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    color: const Color(0xff727272),
                    fontWeight: FontWeight.w500,
                    height: 3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget menu(bool loading) {
    return ShimmerLoading(
      isLoading: loading,
      child: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuCard(
                    cardColor: Color(0xfff9f9ff),
                    title: "Merit",
                    icon: CustomIcons.badge,
                    iconColor: Color(0xff1E5AA7),
                    firstChild: true),
                menuCard(
                    cardColor: Color(0xffFEF6F4),
                    title: "OneMall",
                    icon: CustomIcons.shopping_bag,
                    iconColor: Color(0xffFF8364)),
                menuCard(
                    cardColor: Color(0xffF2F8FC),
                    title: "OneJob",
                    icon: CustomIcons.businessman,
                    iconColor: Color(0xff47D4F9)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuCard(
                    cardColor: Color(0xffFEF6F4),
                    title: "ClubHouse",
                    icon: CustomIcons.reading_book,
                    iconColor: Color(0xffFF8364),
                    firstChild: true),
                menuCard(
                    cardColor: Color(0xffF2F8FC),
                    title: "MyCalender",
                    icon: CustomIcons.calendar,
                    iconColor: Color(0xff47D4F9)),
                menuCard(
                    cardColor: Color(0xfff9f9ff),
                    title: "Lost & Found",
                    icon: CustomIcons.found,
                    iconColor: Color(0xff1E5AA7)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget announcement(bool loading) {
    return Container(
      height:
          !loading && homeController.homeModel.eventList.length > 0 ? 196 : 0,
      margin: EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemCount: loading ? 1 : homeController.homeModel.eventList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, position) => announcementCard(
              loading ? "" : homeController.homeModel.eventList[position].name,
              loading
                  ? null
                  : homeController.homeModel.eventList[position].image,
              position,
              loading)),
    );
  }

  Widget announcementCard(
      String title, String image, int position, bool loading) {
    print(image);
    return ShimmerLoading(
      isLoading: loading,
      child: Container(
        height: 195,
        width: 270,
        margin: EdgeInsets.only(right: 20, left: position == 0 ? 20 : 0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 195,
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: const Color(0xffffffff),
                  border:
                      Border.all(width: 1.0, color: const Color(0xffeeeeee)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 155,
                width: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image == null
                        ? AssetImage("assets/images/test/an_1.png")
                        : CachedNetworkImageProvider(
                            ApiService.baseUrl + image,
                          ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(17.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 10, left: 15),
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0xff252525),
                      fontWeight: FontWeight.w500,
                      height: 2.5714285714285716,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget announcementTitle(String title, bool loading) {
    return ShimmerLoading(
      isLoading: loading,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              color: const Color(0xff252525),
              fontWeight: FontWeight.w500,
              height: 1.8,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  Widget menuCard(
      {@required Color cardColor,
      @required String title,
      @required IconData icon,
      @required Color iconColor,
      bool firstChild = false}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 114,
        maxWidth: 106,
      ),
      child: Container(
        width: 106.0,
        height: 114.0,
        margin: EdgeInsets.only(left: firstChild ? 0 : 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: cardColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 35,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xff252525),
                  fontWeight: FontWeight.w500,
                  height: 2.769230769230769,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ad(bool loading) {
    return Container(
      height: 115,
      margin: EdgeInsets.only(top: 40),
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, position) => adCard(
              "assets/images/test/test${position + 1}.png", position, loading)),
    );
  }

  Widget adCard(String image, int position, bool loading) {
    return ShimmerLoading(
      isLoading: loading,
      child: Container(
        width: 183,
        height: 114,
        margin: EdgeInsets.only(left: position == 0 ? 20 : 0, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: const Color(0xfff3f1ec),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget profile(bool loading) {
    return GestureDetector(
      onTap: loading
          ? null
          : () {
              Parent.tabController.animateTo(1);
            },
      child: ShimmerLoading(
        isLoading: loading,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loginInfo.name,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: const Color(0xff252525),
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Student Id: ${profileModel?.id ?? 0}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: const Color(0xff727272),
                        height: 2.769230769230769,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: const AssetImage('assets/images/test/pp.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
