class UserInfo {
  String name;
  String avatar;
  String sign;
  List<String> tags = [];
  UserInfo({required this.name, required this.avatar, required this.sign});
}

class CoralInfo {
  String name;
  String avatar;
  String position;
  String updateTime;
  int score;
  CoralInfo({required this.name, required this.avatar, required this.score, required this.position, required this.updateTime});
}

class CommonData {
  static UserInfo? me;
  static List<CoralInfo> mycorals = [];
}