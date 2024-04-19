import 'package:demo_task/routes/pages.dart';
import 'package:demo_task/routes/routes.dart';
import 'package:demo_task/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Pages.initialRoute,
      getPages: Routes.pages,
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
    );
  }
}
