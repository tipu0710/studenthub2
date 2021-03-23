import 'package:studenthub2/service/process/process.dart';

class LoginController {
  String b =
      "MsgozdDtkY+WFyRPyD2mZkVC5VuliYhluKfKkm/HzalbVaeYmJaDmWLvVxh7GrL0Ft0KcbstG3X4+sNopDVPEGaChQjLX20Pb6Yx/gpOf7xjoL8ITjSWYjpdcUBIlXQueN90zUyR5zVTlBylYakDZ5EuSs2/nd8m+SnGtGDPir7VxFkRauGe4J4zASNU2Bn8lBuUYJdV96t+WojXINJoWLKRThz4hfKzM0rhkoqVho6NjB/ySMTrp9RNU8m+anY9+vll11P6Rn28O21lYSTTj7VvYAJzp61KdSz4H98ih0h3ORmRENl7WOtSvXH012ZvWuWK2eCz5O02SCn+NOqvCeAjf8NtVRnE8mt5/tK7KCtSzgVi6pEoADWH644Fr1ulaIxVinTqQ7usgYK5PX7lHoWPRt/VVI4zzxQs3W2P44/CWQdjpBWF3vt1EfqOUgXHwS1PX01ug1O8ibaGDBeq5SG9S5oct44MQUoNFbLflusjALiJc47fU0HbL2GA9J1D";
  login() async {

    String s = ProcessData.getDecryptedData(b);
    print(s);
  }
}
