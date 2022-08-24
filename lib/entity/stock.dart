/// status : 1
/// msg : "ok"
/// data : {"stock":1,"type":0,"ava_stock":"5"}

class Stock {
  Stock({
      num? status, 
      String? msg, 
      Data? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  Stock.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _msg;
  Data? _data;
Stock copyWith({  num? status,
  String? msg,
  Data? data,
}) => Stock(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// stock : 1
/// type : 0
/// ava_stock : "5"

class Data {
  Data({
      num? stock, 
      num? type, 
      String? avaStock,}){
    _stock = stock;
    _type = type;
    _avaStock = avaStock;
}

  Data.fromJson(dynamic json) {
    _stock = json['stock'];
    _type = json['type'];
    _avaStock = json['ava_stock'];
  }
  num? _stock;
  num? _type;
  String? _avaStock;
Data copyWith({  num? stock,
  num? type,
  String? avaStock,
}) => Data(  stock: stock ?? _stock,
  type: type ?? _type,
  avaStock: avaStock ?? _avaStock,
);
  num? get stock => _stock;
  num? get type => _type;
  String? get avaStock => _avaStock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock'] = _stock;
    map['type'] = _type;
    map['ava_stock'] = _avaStock;
    return map;
  }

}