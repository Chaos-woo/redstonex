import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

import 'history_weather_query_logic.dart';
import 'models/city_history_weather.dart';

class HistoryWeatherQueryPage extends StatelessWidget {
  final logic = XDepends().on<HistoryWeatherQueryLogic>();
  final state = XDepends().on<HistoryWeatherQueryLogic>().state;

  HistoryWeatherQueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = RGB(11, 12, 30).color;

    return Scaffold(
      appBar: RsxAppBar(
        frontColor: Colors.white,
        isBack: true,
        customTitleWidget: Container(
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 48.0),

          /// 省-地区选择器
          child: _provinceCityPicker(context),
        ),
        backgroundColor: bgColor,
      ),
      body: Container(
        height: double.infinity,
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap32,

            /// 日夜天气数据展示
            _dayNightWeatherCarouselWindow(),

            /// 历史时间选择器
            _historyDatePicker(context),

            /// 历史天气查询组件
            _historyWeatherQueryComponent(),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '注：历史天气数据查询：\n    使用Picker组件供用户选择城市，历史时间，再利用网络库Dio查询天气数据，最后使用横幅【GFWidget的GFCarousel】组件分别展示白天和夜间的天气数据',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _provinceCityPicker(BuildContext context) {
    return RsxClickWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 14,
          ),
          Gaps.hGap4,
          GetBuilder<HistoryWeatherQueryLogic>(
            id: logic.weatherCityBuilderId,
            builder: (_) {
              String cityShowText = '设置城市';
              String? pName = state.selectedProvinceCityState.province?.name;
              String? cName = state.selectedProvinceCityState.city?.name;
              if (!pName.oNullOrBlank || !cName.oNullOrBlank) {
                cityShowText = '$pName,$cName';
              }

              return Text(
                cityShowText,
                style: const TextStyle(
                  fontSize: Dimens.fontSp18,
                  color: Colors.white,
                ),
              );
            },
          ),
          const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
      onTap: () {
        /// 点击选择城市
        Pickers.showMultiLinkPicker(
          context,
          data: state.supportProvinceCityState.convertLinkageableProvinceCity(),
          selectData: [
            state.selectedProvinceCityState.province?.name ?? '北京',
            state.selectedProvinceCityState.city?.name ?? '北京',
          ],
          columeNum: 2,
          onConfirm: (List selectData, List<int> selectPosition) {
            logic.selectLatestProvinceCity(selectPosition);
          },
        );
      },
    );
  }

  Widget _dayNightWeatherCarouselWindow() {
    return GetBuilder<HistoryWeatherQueryLogic>(
      id: logic.weatherViewWindowBuilderId,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: XScreen().screenWidth - 80,
          height: XScreen().screenHeight * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: GFCarousel(
            viewportFraction: 1.0,
            height: XScreen().screenHeight * 0.5,
            items: <Widget>[
              _weatherCarousel(true, state.latestQueryWeatherState.weatherCompose.dayWeather),
              _weatherCarousel(false, state.latestQueryWeatherState.weatherCompose.nightWeather),
            ],
            onPageChanged: (index) {
              // setState(() {
              //   index;
              // });
            },
          ),
        );
      },
    );
  }

  Widget _historyDatePicker(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            '当前选中时间: ',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          GetBuilder<HistoryWeatherQueryLogic>(
            id: logic.weatherDatetimeBuilderId,
            builder: (_) {
              return TextButton(
                onPressed: () {
                  DateTime previousDay = XDatetime().previousDay(DateTime.now());
                  Pickers.showDatePicker(
                    context,
                    // 模式，详见下方
                    mode: DateMode.YMD,
                    // 后缀 默认Suffix.normal()，为空的话Suffix()
                    suffix: Suffix(years: ' 年', month: ' 月', days: ' 日'),
                    // 默认选中
                    selectDate: PDuration(year: state.selectDateTime.year, month: state.selectDateTime.month, day: state.selectDateTime.day),
                    minDate: PDuration(year: 2020, month: 1, day: 1),
                    maxDate: PDuration(year: previousDay.year, month: previousDay.month, day: previousDay.day),
                    onConfirm: (PDuration p) {
                      DateTime select = DateTime(p.year!, p.month!, p.day!);
                      logic.cacheSelectHistoryWeatherDate(select);
                    },
                    // onChanged: (p) => print(p),
                  );
                },
                child: Text(
                  XDatetime().yyyyMMddFormat(state.selectDateTime),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _historyWeatherQueryComponent() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              logic.loadCityHistoryWeather(state.selectDateTime);
            },
            child: const Text(
              '查询选中时间的历史天气',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Gaps.hGap16,
          RsxClickWidget(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                  width: 15,
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              ],
            ),
            onTap: () {
              XDialog().showPromptDialog(
                  title: '聚合数据API',
                  content: '''
天气预报API接口
1、权威渠道，准确性高（不清楚）
2、可查询当前天气，未来数天天气（免费的历史天气数据）
3、覆盖面广，覆盖并精确到全国区县及以上城市（可能还行）
                        ''',
                  textConfirm: '了解',
                  onConfirm: () {
                    XNavigator().back();
                  });
            },
          )
        ],
      ),
    );
  }

  Widget _weatherCarousel(bool daytime, CityHistoryWeather cityWeather) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      // padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: XImage().getAssetImageProvider(daytime ? 'assets/images/bg/bg_daytime.jpeg' : 'assets/images/bg/bg_night.jpeg'),
            fit: BoxFit.fill,
          )),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: _weatherCarouselInfo(daytime, cityWeather),
          ),
        ),
      ),
    );
  }

  Widget _weatherCarouselInfo(bool daytime, CityHistoryWeather cityWeather) {
    GlobalKey wChangeTipIconKey = GlobalKey<_WeatherChangeTipIconState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '当前展示城市: ${cityWeather.cityName}',
                style: TextStyle(color: daytime ? Colors.black : Colors.white),
              ),
              RsxClickWidget(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: state.userSelectCityOrDatetimeChange
                      ? WeatherChangeTipIcon(
                          key: wChangeTipIconKey,
                        )
                      : const Spacer(),
                ),
                onTap: () {
                  RsxPopupWindow.show(
                      context: Get.context!,
                      anchor: wChangeTipIconKey.renderBox,
                      child: Container(
                        // width: ScreenUtils.screenWidth - 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: XTheme().isDarkMode() ? XTheme().theme().primaryColorDark : XTheme().theme().primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Text(
                          '小提示: 选择的城市或日期可能发生改变，当前展示数据已经时过境迁',
                          maxLines: 2,
                        ),
                      ));
                },
              )
            ],
          ),
        ),
        Gaps.vGap16,
        SizedBox(
          width: 300,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 70,
                width: 70,
                child: Image(
                  image: XImage().getAssetImageProvider(logic.getWeatherCodeIconPath(cityWeather.weatherId, daytime: daytime)),
                ),
              ),
              Gaps.hGap15,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cityWeather.weather,
                    style: TextStyle(
                      color: daytime ? Colors.grey : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${daytime ? '白天最高温度' : '夜间最低温度'}: ${cityWeather.temp}',
                    style: TextStyle(
                      color: daytime ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '当前展示时间: ${cityWeather.weatherDate}',
                    style: TextStyle(
                      color: daytime ? Colors.grey : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Divider(color: daytime ? Colors.grey : Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '其他信息',
                style: TextStyle(color: daytime ? Colors.grey : Colors.white, fontSize: 10),
              ),
            ),
            Expanded(
              child: Divider(color: daytime ? Colors.grey : Colors.white),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${daytime ? '白天风向' : '夜间风向'}: ${cityWeather.windDirection}',
                  style: TextStyle(
                    color: daytime ? Colors.black : Colors.white,
                    fontSize: 14,
                  ),
                ),
                Gaps.vGap8,
                Text(
                  '${daytime ? '白天风力情况' : '夜间风力情况'}: ${cityWeather.windComp}',
                  style: TextStyle(
                    color: daytime ? Colors.black : Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class WeatherChangeTipIcon extends StatefulWidget {
  const WeatherChangeTipIcon({Key? key}) : super(key: key);

  @override
  State<WeatherChangeTipIcon> createState() => _WeatherChangeTipIconState();
}

class _WeatherChangeTipIconState extends State<WeatherChangeTipIcon> {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.info_rounded,
      color: Colors.red,
      size: 20,
    );
  }
}
