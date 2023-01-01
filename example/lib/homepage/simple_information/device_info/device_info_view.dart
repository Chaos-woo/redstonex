import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'device_info_logic.dart';

class DeviceInfoPage extends StatelessWidget {
  final logic = Depends.on<DeviceInfoLogic>();
  final state = Depends.on<DeviceInfoLogic>().state;

  DeviceInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RsxAppBar(
        title: '设备信息',
        titleColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo, Colors.orange, Colors.red, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GetBuilder<DeviceInfoLogic>(
          builder: (_) => RsxScrollView(
            children: <Widget>[
              _infoLabel('手机信息'),
              Gaps.vGap10,
              _mobilePhoneInfoBuilder(),
              Gaps.vGap16,
              _infoLabel('包信息'),
              Gaps.vGap10,
              _appPackageInfoBuilder1(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobilePhoneInfoBuilder() {
    List<Widget> infoBuilders = [
      _infoCard('Brand', state.brand),
      _infoCard('Board', state.board),
      _infoCard('Model', state.deviceModel),
      _infoCard('Industrial', state.industrialDesignName),
      _infoCard('Display', state.displayName),
      _infoCard('Manufacturer', state.manufacturer),
      _infoCard('Host', state.host),
      _infoCard('OS', state.androidBaseOS),
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: infoBuilders.length,
      itemBuilder: (context, index) {
        return infoBuilders[index];
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        crossAxisCount: 3,
      ),
    );
  }

  Widget _appPackageInfoBuilder1() {
    List<Widget> infoBuilders = [
      _infoCard('Name', state.appName),
      _infoCard('Version', state.appVersion),
      _infoCard('Build number', state.buildNumber),
      _infoCard('Package', state.packageName),
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: infoBuilders.length,
      itemBuilder: (context, index) {
        return infoBuilders[index];
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        crossAxisCount: 3,
      ),
    );
  }

  Widget _infoCard(String label, String? text) {
    return RsxCard(
      color: Colors.white,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  text ?? '--',
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLabel(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            )),
        const Spacer(),
      ],
    );
  }
}
