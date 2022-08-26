/// status : 2
/// msg : "用户信息已失效，请重新登录"

class CommonData {
  CommonData({
      num? status, 
      String? msg,}){
    _status = status;
    _msg = msg;
}

  CommonData.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }
  num? _status;
  String? _msg;
CommonData copyWith({  num? status,
  String? msg,
}) => CommonData(  status: status ?? _status,
  msg: msg ?? _msg,
);
  num? get status => _status;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }

}