import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

import '../entity/city_list.dart';

class CityPickPager extends StatefulWidget {
  const CityPickPager({Key? key}) : super(key: key);

  @override
  _CityPickPagerState createState() => _CityPickPagerState();
}

class _CityPickPagerState extends State<CityPickPager> {
  late String provinceName = "";
  late String cityName = "";
  late String areaName = "";

  List<Data>? provinceList;
  List<Data>? cityList;
  List<Data>? areaList;
  List<String> provinceNameList = ['全国'];
  List<String> cityNameList = [];
  List<String> areaNameList = [];

  @override
  void initState() {
    super.initState();
    getCountryInfo("1", null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Icon(Icons.directions_bike),
            SizedBox(height: 22),
            Text(
              '选择城市',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF262626),
              ),

            ),
            _provinceSelector(),
            _citySelector(),
            _areaSelector(),
            SizedBox(height: 40),
            _button(text: "确认"),
          ],
        ),
      ),
    );
  }

  Widget _provinceSelector() {
    if (provinceList == null) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            padding: const EdgeInsets.all(15),
            borderRadius: BorderRadius.circular(5),
            border: const BorderSide(color: Colors.black12, width: 1),
            dropdownButtonColor: Colors.white,
            value: provinceName,
            onChanged: (newValue) {
              setState(() {
                provinceName = newValue.toString();
                getCityInfos();
              });
            },
            items: provinceNameList
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      );
    }
  }

  Widget _citySelector() {
    if (cityList == null) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Text(""),
      );
    } else {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            padding: const EdgeInsets.all(15),
            borderRadius: BorderRadius.circular(5),
            border: const BorderSide(color: Colors.black12, width: 1),
            dropdownButtonColor: Colors.white,
            value: cityName,
            onChanged: (newValue) {
              setState(() {
                cityName = newValue.toString();
                getAreaInfos();
              });
            },
            items: cityNameList
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      );
    }
  }
  Widget _areaSelector() {
    if (areaList == null) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Text(""),
      );
    } else {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            padding: const EdgeInsets.all(15),
            borderRadius: BorderRadius.circular(5),
            border: const BorderSide(color: Colors.black12, width: 1),
            dropdownButtonColor: Colors.white,
            value: areaName,
            onChanged: (newValue) {
              setState(() {
                areaName = newValue.toString();
                getStoreInfo();
              });
            },
            items: areaNameList
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      );
    }
  }
  Widget _button({required String text, bool isTransparent = false}) =>
      ElevatedButton(
        onPressed: () {
          // GetIt.I.get<NavigationService>().back();

          //getHttp();
        },
        style: ElevatedButton.styleFrom(
          primary: isTransparent ? Colors.transparent : const Color(0xFF0043CE),
          elevation: 0,
          shadowColor: Colors.transparent,
          fixedSize: Size(342, 64),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isTransparent
                ? const Color(0xFF0043CE)
                : const Color(0xFFF4F4F4),
          ),
        ),
      );

  void getCountryInfo(String action, Data? cityInfo) async {
    FormData formData = FormData.fromMap({"action": action, "code": cityInfo?.code??""});
    var response = await Dio().post(
        'https://e-gw.giant.com.cn/index.php/api/get_base_area',
        data: formData);
    Map<String, dynamic> date = convert.jsonDecode(response.data.toString());
    if (action == "1") {
      //province list
      provinceList = CityList.fromJson(date).data;
      setState(() {
        provinceName = "全国";
        for (var element in provinceList ?? []) {
          provinceNameList.add(element.name ?? "");
        }
      });
    } else if (action == "2") {
      //city list
      setState(() {
       cityList = CityList.fromJson(date).data;
       cityNameList.clear();
       for (var element in cityList ?? []) {
         if (element.name==cityList![0].name) {
           cityName = element.name;
         }
         cityNameList.add(element.name ?? "");
       }
      });
    } else if (action == "3") {
      //area list
      setState(() {
       areaList = CityList.fromJson(date).data;
       areaList?.insert(0, cityInfo!);
       areaNameList.clear();
       for (var element in areaList ?? []) {
         if (element.name==areaList![0].name) {
           areaName = element.name;
         }
         areaNameList.add(element.name ?? "");
       }
      });
    }
  }

  void getCityInfos() {
    if (provinceName != "全国") {
      var provinceInfo =
          provinceList?.firstWhere((element) => element.name == provinceName);
      getCountryInfo("2", provinceInfo);
    }
  }

  void getAreaInfos() {
    var cityInfo = cityList?.firstWhere((element) => element.name == cityName);
    getCountryInfo("3", cityInfo);
  }

  void getStoreInfo() {

  }
}
