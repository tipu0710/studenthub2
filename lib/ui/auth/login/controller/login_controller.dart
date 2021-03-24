import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/auth/password/view/password.dart';

class LoginController {
  BuildContext _context;
  LoginController(BuildContext context){
    this._context = context;
  }
  String b = "PwJCA0JG1SJHUYF4cu1rPnif/VcqQMc8oLwgc/bB3s36My5tZDtJdiAzOvfGetSMbw6IzwPtlzvMHts/wZ+dbRHK8BTcbjzHuLRBPC3tGBMehsB7k69NQkg0gIoKp4dqoV1+N+YHXS+ObTgvmu3v+s84kOungqTitaaa3v5BQ8WmzzU2m0Lc2NZmkmFWsU8AUDMmB8HtXsx1rWwBBzBjVmjte0Gd90Ja/TN+jZNtPBtgIJsmgzCVzOgJ2pWyCM2zQvNv6XUiHzqJc/hyy5jo/VD8Ay7pAsjh4ePnSV2SvrMmAvDwPpfmSz0C6XIHcL04EBAoSuXIGr8X69A2MqmXBIB5WaRmhMClsYS9i4+4U4B8Pil2wQ2xWLb0WGOctQ+aHQsZfKWg2f81PlYNTacKeQifmGXNRp6M+909HGBOW+CSNMBDXfKg5ciInQWWsn8GySgLzWl8SjI0/DyBQM3bqE9SKx/KZy6T7jIIz8qSD4iFtQRNP8DCFQPWsxRuU/0ANgpbKorao4oa3AnI1Dg8lg==";
  login() async {
    String s = ProcessData.getDecryptedData(b);
    print(s);
    Navigator.push(_context, MaterialPageRoute(builder: (_)=>Password()));
  }
}
