import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';

class QrController {
  Future<bool> joinEvent(String id) async {
    print(DataProcess.getEncryptedData(id));
    Response response = await ApiService.postMethod(
        "https://studenthub.smartcampus.com.my/api/Home/DashboardMobileApi/EventCheckin?input=${DataProcess.getEncryptedData(id)}",
        allowFullUrl: false,
        allowToken: true);

    DataModel dataModel = DataModel.fromJson(response.data);
    print(response.data);
    if (dataModel.hasError) {
      showMessage(
          dataModel.errors.isEmpty
              ? "Something went wrong!"
              : dataModel.errors.first,
          toastPosition: ToastPosition.center);
      print(dataModel.errors);
      return false;
    } else {
      print(DataProcess.getDecryptedData(dataModel.data));
      showMessage("JOINED");
      Parent.tabController.animateTo(0);
      return true;
    }
  }
}
