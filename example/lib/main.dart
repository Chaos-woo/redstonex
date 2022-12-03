import 'package:flutter/material.dart';
import 'package:redstonex/app-configs/redstonex_initializer.dart';
import 'package:get/get.dart';
import 'package:redstonex/widgets/redstonex_app_bar.dart';

void main() async {
  RsxInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RsxAppBar(centerTitle: widget.title, isBack: false,),
    );
  }
}
