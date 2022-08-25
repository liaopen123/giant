/// status : 1
/// msg : "ok"
/// data : [{"id":1,"code":"110000","parentid":"0","name":"北京市","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":2,"code":"120000","parentid":"0","name":"天津市","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":3,"code":"130000","parentid":"0","name":"河北省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":4,"code":"140000","parentid":"0","name":"山西省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":5,"code":"150000","parentid":"0","name":"内蒙古自治区","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":6,"code":"210000","parentid":"0","name":"辽宁省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":7,"code":"220000","parentid":"0","name":"吉林省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":8,"code":"230000","parentid":"0","name":"黑龙江省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":9,"code":"310000","parentid":"0","name":"上海市","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":10,"code":"320000","parentid":"0","name":"江苏省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":11,"code":"330000","parentid":"0","name":"浙江省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":12,"code":"340000","parentid":"0","name":"安徽省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":13,"code":"350000","parentid":"0","name":"福建省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":14,"code":"360000","parentid":"0","name":"江西省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":15,"code":"370000","parentid":"0","name":"山东省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":16,"code":"410000","parentid":"0","name":"河南省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":17,"code":"420000","parentid":"0","name":"湖北省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":18,"code":"430000","parentid":"0","name":"湖南省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":19,"code":"440000","parentid":"0","name":"广东省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":20,"code":"450000","parentid":"0","name":"广西壮族自治区","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":21,"code":"460000","parentid":"0","name":"海南省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":22,"code":"500000","parentid":"0","name":"重庆市","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":23,"code":"510000","parentid":"0","name":"四川省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":24,"code":"520000","parentid":"0","name":"贵州省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":25,"code":"530000","parentid":"0","name":"云南省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":26,"code":"540000","parentid":"0","name":"西藏自治区","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":27,"code":"610000","parentid":"0","name":"陕西省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":28,"code":"620000","parentid":"0","name":"甘肃省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":29,"code":"630000","parentid":"0","name":"青海省","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":30,"code":"640000","parentid":"0","name":"宁夏回族自治区","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null},{"id":31,"code":"650000","parentid":"0","name":"新疆维吾尔自治区","level":1,"createDate":"2022-06-14 22:45:00","updateDate":null}]

class CityList {
  CityList({
      num? status, 
      String? msg, 
      List<Data>? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  CityList.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Data>? _data;
CityList copyWith({  num? status,
  String? msg,
  List<Data>? data,
}) => CityList(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// code : "110000"
/// parentid : "0"
/// name : "北京市"
/// level : 1
/// createDate : "2022-06-14 22:45:00"
/// updateDate : null

class Data {
  Data({
      num? id, 
      String? code, 
      String? parentid, 
      String? name, 
      num? level, 
      String? createDate, 
      dynamic updateDate,}){
    _id = id;
    _code = code;
    _parentid = parentid;
    _name = name;
    _level = level;
    _createDate = createDate;
    _updateDate = updateDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _parentid = json['parentid'];
    _name = json['name'];
    _level = json['level'];
    _createDate = json['createDate'];
    _updateDate = json['updateDate'];
  }
  num? _id;
  String? _code;
  String? _parentid;
  String? _name;
  num? _level;
  String? _createDate;
  dynamic _updateDate;
Data copyWith({  num? id,
  String? code,
  String? parentid,
  String? name,
  num? level,
  String? createDate,
  dynamic updateDate,
}) => Data(  id: id ?? _id,
  code: code ?? _code,
  parentid: parentid ?? _parentid,
  name: name ?? _name,
  level: level ?? _level,
  createDate: createDate ?? _createDate,
  updateDate: updateDate ?? _updateDate,
);
  num? get id => _id;
  String? get code => _code;
  String? get parentid => _parentid;
  String? get name => _name;
  num? get level => _level;
  String? get createDate => _createDate;
  dynamic get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['parentid'] = _parentid;
    map['name'] = _name;
    map['level'] = _level;
    map['createDate'] = _createDate;
    map['updateDate'] = _updateDate;
    return map;
  }

}