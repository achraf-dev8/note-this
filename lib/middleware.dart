

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleWare extends GetMiddleware{

 int? get priorety => 1;

 @override
 RouteSettings? redirect(String? route){

  return null;
 }
 

} 