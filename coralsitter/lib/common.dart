import 'dart:ffi';

class UserInfo {
  String name; // 用户名称
  String avatar; // 用户头像
  String sign; // 用户签名
  List<String> tags; // 用户标签
  UserInfo({required this.name, required this.avatar, required this.sign, required this.tags});
}

// class CoralInfo {
//   String name; // 珊瑚名称
//   String avatar; // 珊瑚头像
//   String position; // 珊瑚地址
//   String positionImage; // 珊瑚地址图片
//   String updateTime; // 珊瑚状态更新时间
//   String tags; // 珊瑚标签
//   String species; // 珊瑚种类
//   int score; // 珊瑚得分
//   Map<String, String> monitor = {}; // 珊瑚监测数据
//   Map<String, String> grow = {}; // 珊瑚成长数据
//   CoralInfo({required this.name, required this.avatar, required this.score, required this.position, required this.updateTime, required this.tags, required this.positionImage, required this.species, required this.monitor, required this.grow});
// }

class CoralInfo {
  String name; // 珊瑚名称
  String avatar; // 珊瑚头像
  String position; // 珊瑚地址
  String updateTime; // 珊瑚状态更新时间
  List<String> tags; // 珊瑚标签
  String species; // 珊瑚种类
  String light;
  String temp;
  String microelement;
  int size;
  double lastmeasure;
  double growth;
  int score; // 珊瑚得分
  CoralInfo({required this.name, required this.avatar, required this.position, required this.updateTime, required this.tags, required this.species, required this.light, required this.temp, required this.microelement, required this.size, required this.lastmeasure, required this.growth, required this.score});
}

class CommonData {
  static UserInfo? me;
  static List<CoralInfo> mycorals = [];
  static String server = "192.168.10.7:3000";
}