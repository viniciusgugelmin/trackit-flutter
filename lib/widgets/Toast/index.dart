import 'package:fluttertoast/fluttertoast.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class ToastApp {
  static const Toast lengthLong = Toast.LENGTH_LONG;
  static const Toast lengthShort = Toast.LENGTH_SHORT;
  static const ToastGravity gravityTop = ToastGravity.TOP;
  static const ToastGravity gravityCenter = ToastGravity.CENTER;
  static const ToastGravity gravityBottom = ToastGravity.BOTTOM;

  static void show(String message,
      {String type = "success",
      Toast length = lengthLong,
      ToastGravity gravity = gravityTop}) {
    int timeInSecForIosWeb = (length == lengthLong) ? 5 : 1;

    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: type == "success" ? ColorsUtils.darkBlue : ColorsUtils.red,
      textColor: ColorsUtils.white,
      fontSize: 16.0,
      webBgColor: type == "success" ? "#126BA5" : "#F44336",
    );
  }
}
