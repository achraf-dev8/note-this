import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/main_controller.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Core/Services/transilation.dart';
import 'package:note_this/bindings.dart';
import 'package:note_this/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late  SharedPreferences sharedPrefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetBuilder<MainController>(
      builder: (controller) => GetMaterialApp(     
        themeMode: controller.theme,
        theme: lightTheme,
        darkTheme: darkTheme,
        translations: MyTranslation(),
        locale : getLang(),
        debugShowCheckedModeBanner: false,
        initialBinding: InitBinding(),
        getPages: routes
        ),
    );
  }
}




  

