class UserInfo {
  String name; // 用户名称
  String avatar; // 用户头像
  String sign; // 用户签名
  List<String> tags = []; // 用户标签
  UserInfo({required this.name, required this.avatar, required this.sign});
}

class CoralInfo {
  String name; // 珊瑚名称
  String avatar; // 珊瑚头像
  String position; // 珊瑚地址
  String positionImage; // 珊瑚地址图片
  String updateTime; // 珊瑚状态更新时间
  String tags; // 珊瑚标签
  String species; // 珊瑚种类
  int score; // 珊瑚得分
  Map<String, String> monitor = {};
  Map<String, String> grow = {};
  CoralInfo({required this.name, required this.avatar, required this.score, required this.position, required this.updateTime, required this.tags, required this.positionImage, required this.species, required this.monitor, required this.grow});
}

class CommonData {
  static UserInfo? me;
  static List<CoralInfo> mycorals = [];
}