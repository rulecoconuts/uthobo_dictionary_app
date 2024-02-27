import 'package:fluttertoast/fluttertoast.dart';

class ToastShower {
  Future showToast(String message) async {
    await Fluttertoast.showToast(msg: message);
  }
}
