import 'package:get/get.dart';


class DarkModeController extends GetxController{
bool val;
final Function(bool) changeVal;

DarkModeController(this.val, this.changeVal);

change(bool val){
  this.val = val;
  update();
  changeVal(val);
}



}