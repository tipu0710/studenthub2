import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/calendar/view/calendar.dart';
import 'package:studenthub2/ui/home/controller/home_controller.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui_helper/custom_icons.dart';
import 'package:studenthub2/ui_helper/effect.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController;
  bool loading = true;
  @override
  void initState() {
    homeController = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<bool>(
          future: homeController.getDashboard(),
          builder: (_, snapshot) {
            int step = 1;
            if (snapshot.hasError) {
              print(snapshot.error);
              //showMessage(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              loading = false;
              step = homeController?.homeModel?.channelList?.length ?? 0;
            }
            return Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  profile(loading),
                  menu(loading),
                  !loading && homeController.homeModel.eventList.length > 0
                      ? announcementTitle('Latest Events', loading)
                      : Container(),
                  event(loading),
                  !loading &&
                          homeController.homeModel.announcementList.length > 0
                      ? announcementTitle('Latest Announcement', loading)
                      : Container(),
                  announcement(loading),
                  step > 0
                      ? announcementTitle("Channel", loading)
                      : Container(),
                  step > 0 ? channelList() : Container(),
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

  Widget channelCard(
      {@required Color cardColor,
      @required miniCardColor,
      @required Channel channel,
      @required loading,
      @required position}) {
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
              child: Center(
                child: Text(
                  loading ? '' : channel.name[0],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channel?.name ?? '',
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
                    loading
                        ? ""
                        : dateTimeFormatter(channel?.lastChanged ?? ""),
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
              ),
            ),
            SizedBox(
              width: 15,
            ),
            UiHelper().button(
                context: context,
                circleRadius: 15,
                title: loading
                    ? ''
                    : channel?.adminChannel?.isAlreadyAdded ?? false
                        ? "LEAVE"
                        : "JOIN",
                onPressed: loading
                    ? null
                    : () async {
                        dynamic b = await homeController.channelJoinLeave(
                            channel.id,
                            channel?.adminChannel?.isAlreadyAdded ?? false,
                            position);
                        if (b != null) {
                          setState(() {
                            homeController.homeModel.channelList[position]
                                .adminChannel = AdminChannel(isAlreadyAdded: b);
                          });
                        }
                      },
                height: 30,
                width: 56,
                fontSize: 8,
                topMargin: 0,
                anim: true,
                bottomMargin: 0,
                color: miniCardColor),
            SizedBox(
              width: 10,
            ),
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
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xfff9f9ff),
                    title: "Merit",
                    icon: CustomIcons.badge,
                    iconColor: Color(0xff1E5AA7),
                    onTap: () {
                      print("Merit");
                    },
                    firstChild: true,
                  ),
                ),
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xffFEF6F4),
                    title: "OneMall",
                    icon: CustomIcons.shopping_bag,
                    iconColor: Color(0xffFF8364),
                    onTap: () {
                      print("OneMall");
                    },
                  ),
                ),
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xffF2F8FC),
                    title: "OneJob",
                    icon: CustomIcons.businessman,
                    iconColor: Color(0xff47D4F9),
                    onTap: () {
                      print("OneJob");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xffFEF6F4),
                    title: "ClubHouse",
                    icon: CustomIcons.reading_book,
                    iconColor: Color(0xffFF8364),
                    onTap: () {
                      print("ClubHouse");
                    },
                    firstChild: true,
                  ),
                ),
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xffF2F8FC),
                    title: "MyCalender",
                    icon: CustomIcons.calendar,
                    iconColor: Color(0xff47D4F9),
                    onTap: () {
                      print("MyCalender");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Calendar()));
                    },
                  ),
                ),
                Flexible(
                  child: menuCard(
                    cardColor: Color(0xfff9f9ff),
                    title: "Lost & Found",
                    icon: CustomIcons.found,
                    iconColor: Color(0xff1E5AA7),
                    onTap: () {
                      print("Lost & Found");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget event(bool loading) {
    return Container(
      height:
          !loading && homeController.homeModel.eventList.length > 0 ? 196 : 0,
      margin: EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemCount: loading ? 1 : homeController.homeModel.eventList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, position) => eventCard(
              loading ? "" : homeController.homeModel.eventList[position].name,
              loading
                  ? null
                  : homeController.homeModel.eventList[position].image,
              position,
              loading)),
    );
  }

  Widget announcement(bool loading) {
    return Container(
      height: !loading && homeController.homeModel.announcementList.length > 0
          ? 196
          : 0,
      margin: EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemCount:
              loading ? 1 : homeController.homeModel.announcementList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, position) => announcementCard(
              loading
                  ? ""
                  : homeController.homeModel.announcementList[position].title,
              loading
                  ? ""
                  : homeController
                      .homeModel.announcementList[position].description,
              loading
                  ? null
                  : homeController.homeModel.announcementList[position].image,
              position,
              loading)),
    );
  }

  Widget eventCard(String title, String image, int position, bool loading) {
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

  Widget announcementCard(String title, String description, String image,
      int position, bool loading) {
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
                child: Container(
                  height: 155,
                  width: 270,
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.white),
                      )),
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
      @required void Function() onTap,
      bool firstChild = false}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 114,
        maxWidth: 106,
      ),
      child: GestureDetector(
        onTap: onTap,
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
      ),
    );
  }

  Widget ad(bool loading) {
    return Container(
      height:
          !loading && homeController.homeModel.eventList.length > 0 ? 196 : 0,
      margin: EdgeInsets.only(top: 40),
      child: ListView.builder(
          itemCount: loading ? 1 : homeController.homeModel.addList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, position) => adCard(
              loading
                  ? null
                  : ApiService.baseUrl +
                      homeController.homeModel.addList[position].image,
              loading ? "" : homeController.homeModel.addList[position].link,
              position,
              loading)),
    );
  }

  Widget adCard(String image, String link, int position, bool loading) {
    return ShimmerLoading(
      isLoading: loading,
      child: GestureDetector(
        onTap: () {
          homeController.launchUrl(link);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          margin: EdgeInsets.only(left: position == 0 ? 20 : 0, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            image: DecorationImage(
              image: loading
                  ? AssetImage("assets/images/test/test1.png")
                  : CachedNetworkImageProvider(image),
              fit: BoxFit.fitWidth,
            ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              loading
                  ? Container(
                      height: 50,
                      width: 50,
                    )
                  : homeController?.homeModel?.institute?.logo != null
                      ? Container(
                          height: 50,
                          width: 50,
                          child: CachedNetworkImage(
                            imageUrl: ApiService.baseUrl +
                                homeController.homeModel.institute.logo,
                            height: 50,
                            width: 50,
                          ),
                        )
                      : Container(),
              SizedBox(
                width: 10,
              ),
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
                      maxLines: 1,
                    ),
                    Text(
                      'Student Id: ${profileModel?.institutionDetails?.matricId ?? 0}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: const Color(0xff727272),
                        height: 2.769230769230769,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image:
                        loading || profileModel.institutionDetails.image == null
                            ? AssetImage('assets/images/user.png')
                            : CachedNetworkImageProvider(ApiService.baseUrl +
                                profileModel.institutionDetails.image),
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

  Widget channelList() {
    return ListView.builder(
      itemCount: loading ? 1 : homeController.homeModel.channelList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, i) => channelCard(
        cardColor: homeController.getColor(i).first,
        miniCardColor: homeController.getColor(i).last,
        channel:
            loading ? Channel() : homeController?.homeModel?.channelList[i],
        loading: loading,
        position: i,
      ),
    );
  }
}
