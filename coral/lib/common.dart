class UserInfo {
  String name;
  String avatar;
  UserInfo({required this.name, required this.avatar});
}

class CommonData {
  static UserInfo? me;
}