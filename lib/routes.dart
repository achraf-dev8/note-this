

import 'package:get/get.dart';
import 'package:note_this/Core/Constant/routes_names.dart';
import 'package:note_this/View/Screens/add_note.dart';
import 'package:note_this/View/Screens/home.dart';
import 'package:note_this/View/Screens/settings.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: AppRoutes.home, page: () => const Home(), transition: Transition.leftToRight),
  GetPage(name: AppRoutes.settings, page: () => const Settings(), transition: Transition.rightToLeft),
  GetPage(name: AppRoutes.addNote, page: () => const AddNote(), transition: Transition.rightToLeft),
];
  

