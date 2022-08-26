import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

import 'package:giant/data/store_json.dart';
import 'package:giant/entity/query_bean.dart';
import 'package:giant/entity/stock.dart';
import 'package:giant/entity/store_list.dart';
import 'package:giant/entity/city_list.dart' as city;

import '../entity/CommonData.dart';
import '../entity/store_stock_wrapper.dart';

class StoreStockPage extends StatefulWidget {
  const StoreStockPage({Key? key}) : super(key: key);

  @override
  _StoreStockPageState createState() => _StoreStockPageState();
}

class _StoreStockPageState extends State<StoreStockPage> {
  QueryBean queryBean = Get.arguments;

  List<StoreStockWrapper> storeStocks = [];

  @override
  void initState() {
    super.initState();
    getStoreInfo();
  }

  var index = 0;

  String result = "正在加载...";

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
                Text(result,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF262626),
                  ),
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: storeStocks.length,
                    itemBuilder: (context, index) => _buildItem(index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getStoreInfo() async {
    storeStocks.clear();
    if (queryBean.cityInfo == null) {
      //纯北京
      Map<String, dynamic> data = convert.jsonDecode(storeJson);
      formatStoreData(data);
    } else {
      //外地
      var province = "";
      var city = "";
      var area = "";
      if(queryBean.cityInfo?.level==2){
        province =  queryBean.cityInfo?.parentid ?? "";
        city =  queryBean.cityInfo?.code ?? "";
      }else{
        area =  queryBean.cityInfo?.code ?? "";
      }
      dio.FormData formData = dio.FormData.fromMap({
        "per_page": 100,
        "page": "1",
        "user_long": "",
        "user_lat": "",
        "province": province,
        "city": city,
        "area": area,
      });
      var response = await dio.Dio().post(
          'https://e-gw.giant.com.cn/index.php/api/store_list',
          data: formData);
      print("storeInfo:${response.data.toString()}");
      Map<String, dynamic> data = convert.jsonDecode(response.data.toString());
      formatStoreData(data);
    }
    //得到所有的店铺  开始查询库存
    getHttp();
  }

  void getHttp() async {
    // storeList.data?.forEach((element) {
    //   element.code;
    // });
    if (index >= storeStocks.length) {
      index = 0;
    }
    var store = storeStocks[index].store;
    try {
      dio.FormData formData = dio.FormData.fromMap({
        "sku": queryBean.sku,
        "shopno": store.code??"",
        "user_id": queryBean.userId
      });
      var response = await dio.Dio().post(
          'https://e-gw.giant.com.cn/index.php/api/sku_stock',
          data: formData);
      Map<String, dynamic> date = convert.jsonDecode(response.data.toString());
      print("stock:${response.data.toString()}");

      var commonData = CommonData.fromJson(date);
      if(commonData.status==1){
        var skuQueryResult = Stock.fromJson(date);
        if (skuQueryResult.data!=null&&skuQueryResult.data!.stock! <= 0) {
          setState(() {
            storeStocks[index].stock = "${skuQueryResult.data?.stock}";
            if("-1"==storeStocks[index].stock){
              storeStocks[index].stock = "0";//避免-1 让用户因为是1
            }
            refreshQueryState(index);
          });

          Future.delayed(const Duration(seconds: 3), () {
            index++;
            getHttp();
          });
        } else if(skuQueryResult.data!.stock! > 0){
          final player = AudioPlayer();
          await player.setSource(AssetSource('sound/alert.mp3'));
          await player.setReleaseMode(ReleaseMode.loop);
          setState(() {
            if (queryBean.dingTalk.isNotEmpty) {
              sendDingTalk(store.name);
            }
            result = "${store.name} 有库存 有货了 快去！！！！";
          });
        }
      }else{
        setState(() {
          if (queryBean.dingTalk.isNotEmpty) {
            sendDingTalk("${commonData.msg??""},还没");
          }
          result = commonData.msg??"";
        });
      }


    } catch (e) {
      print(e);
    }
  }

  void sendDingTalk(String? name) async {
    var response = await dio.Dio().post(
        'https://oapi.dingtalk.com/robot/send?access_token=${queryBean.dingTalk}',
        data: {
          "msgtype": "text",
          "text": {"content": "$name有货了，快去！！"}
        });
    print(response.data.toString());
  }

  _buildItem(int index) {
    return ListTile(
      leading: Offstage(
        offstage: !storeStocks[index].isQuerying,
        child: SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
      title: Text("${storeStocks[index].store.name}"),
       subtitle: Text("${storeStocks[index].store.addr1}"),
       trailing: Text("库存:${storeStocks[index].stock}"),
    );
  }

  void formatStoreData(Map<String, dynamic> data) {
    var storeList = StoreList.fromJson(data);
    if (storeList.data?.isEmpty??true) {
      setState(() {
        result ="当前城市 还没有门店";
      });
    }else{
      setState(() {
        result ="";
      });
    }
    storeList.data?.forEach((element) {
      storeStocks.add(StoreStockWrapper(element, "-", false));
    });
  }

  void refreshQueryState(int index) {
    storeStocks[index].isQuerying = false;
    if (index+1 >= storeStocks.length) {
      storeStocks[0].isQuerying = true;
    } else {
      storeStocks[index+1].isQuerying = true;
    }
  }
}
