import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:giant/entity/query_bean.dart';
import 'package:giant/entity/city_list.dart' as city;
import 'package:giant/page/city_pick_page.dart';
import 'package:giant/page/store_stock_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var skuController = TextEditingController();
  var userIdController = TextEditingController();
  var dingTalkController = TextEditingController();
  city.Data? currentAreaInfo;
  var result = "";
  var btnState = "开始查询";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Icon(Icons.directions_bike),
                SizedBox(height: 22),
                InkWell(
                  onTap: () async{
                 var data = await  Get.to(const CityPickPager());
                   currentAreaInfo =data;
                 setState(() {
                 });

                  },
                  child: Text(
                    currentAreaInfo?.name??'北京市',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF262626),
                      decoration: TextDecoration.underline,
                    ),

                  ),
                ),
                SizedBox(height: 22),
                Text(
                  'Hi there, welcome!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF262626),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 37, top: 8, bottom: 23),
                  child: Text(
                    'sku与userId在https://www.giant.com.cn/ 官网登录后 就可以查询到，钉钉机器人关键词填写"有货"。',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF262626),
                      height: 1.28,
                    ),
                  ),
                ),
                _textField(
                  hintText: '商品的SKU',
                  prefixIcon:
                  const Icon(Icons.pedal_bike_sharp, color: Color(0xFFA8A8A8)),
                ),
                SizedBox(height: 14),
                _textField1(
                  hintText: '你的userId',
                  prefixIcon: const Icon(Icons.people_rounded, color: Color(0xFFA8A8A8)),
                ),
                SizedBox(height: 14),
                _textField2(
                  hintText: '(选填)钉钉机器人 输入access_token即可',
                  prefixIcon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFA8A8A8)),
                ),
                SizedBox(height: 50),
                _button(text: btnState),
                SizedBox(height: 14),
                Text(result)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({required String text, bool isTransparent = false}) =>
      ElevatedButton(
        onPressed: () {
          // GetIt.I.get<NavigationService>().back();
          Get.to(StoreStockPage(), arguments: QueryBean(currentAreaInfo,userIdController.text,skuController.text,dingTalkController.text));//
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

  Widget _textField({required String hintText, required Widget prefixIcon}) =>
      TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFA8A8A8),
          ),
          prefixIcon: prefixIcon,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
        ),
        controller: skuController,
      );
  Widget _textField1({required String hintText, required Widget prefixIcon}) =>
      TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFA8A8A8),
          ),
          prefixIcon: prefixIcon,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
        ),
        controller: userIdController,
      );
  Widget _textField2({required String hintText, required Widget prefixIcon}) =>
      TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFA8A8A8),
          ),
          prefixIcon: prefixIcon,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD0D0D0))),
        ),
        controller: dingTalkController,
      );


}