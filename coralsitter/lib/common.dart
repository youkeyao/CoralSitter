import 'package:flutter/material.dart';

import 'package:coralsitter/pages/adoptpage.dart';
import 'package:coralsitter/pages/boxresultpage.dart';
import 'package:coralsitter/pages/chooseboxpage.dart';
import 'package:coralsitter/pages/coralcardspage.dart';
import 'package:coralsitter/pages/coralcompletepage.dart';
import 'package:coralsitter/pages/coralidentitypage.dart';
import 'package:coralsitter/pages/coralpage.dart';
import 'package:coralsitter/pages/coralresultpage.dart';
import 'package:coralsitter/pages/logintextpage.dart';
import 'package:coralsitter/pages/matchpage.dart';
import 'package:coralsitter/pages/openboxpage.dart';
import 'package:coralsitter/pages/settingpage.dart';
import 'package:coralsitter/pages/speciespage.dart';

class MyRouter {
  static const adopt = 'adopt';
  static const boxresult = 'boxresult';
  static const choosebox = 'choosebox';
  static const coralcards = 'coralcards';
  static const coralcomplete = 'coralcomplete';
  static const coralidentity = 'coralidentity';
  static const coral = 'coral';
  static const coralresult = 'coralresult';
  static const logintext = 'logintext';
  static const match = 'match';
  static const openbox = 'openbox';
  static const setting = 'setting';
  static const species = 'species';

  static final Map<String, WidgetBuilder> routes = {
    adopt: (context) => const AdoptPage(),
    boxresult: (context) => const BoxResultPage(),
    choosebox: (context) => const ChooseBoxPage(),
    coralcards: (context) => const CoralCardsPage(),
    coralcomplete: (context) => const CoralCompletePage(),
    coralidentity: (context) => const CoralIdentityPage(),
    coral: (context) => const CoralPage(),
    coralresult: (context) => const CoralResultPage(),
    logintext: (context) => const LoginTextPage(),
    match: (context) => const MatchPage(),
    openbox: (context) => const OpenBoxPage(),
    setting: (context) => const SettingPage(),
    species: (contet) => const SpeciesPage(),
  };
}

class UserInfo {
  String name; // 用户名称
  String avatar; // 用户头像
  String sign; // 用户签名
  List<String> tags; // 用户标签
  UserInfo({required this.name, required this.avatar, required this.sign, required this.tags});
}

class CoralSpecies {
  String species;
  String speciesen;
  List<String> tags;
  String classification;
  String classificationen;
  int difficulty;
  String growspeed;
  String current;
  String light;
  String feed;
  String color;
  List<String> attention;
  CoralSpecies({required this.species, required this.speciesen, required this.tags, required this.classification, required this.classificationen, required this.difficulty, required this.growspeed, required this.current, required this.light, required this.feed, required this.color, required this.attention});
}

class CoralInfo {
  int id;
  String name; // 珊瑚名称
  String avatar; // 珊瑚头像
  String position; // 珊瑚地址
  String updateTime; // 珊瑚状态更新时间
  String light; // 光照强度
  String temp; // 海水气温
  String microelement; // 微量元素
  int size; //大小
  double lastmeasure; //距离上次测量
  double growth; // 平均每月增长
  int score; // 珊瑚得分
  String birthtime;
  String adopttime;
  CoralSpecies species;
  CoralInfo({required this.id, required this.name, required this.avatar, required this.position, required this.updateTime, required this.light, required this.temp, required this.microelement, required this.size, required this.lastmeasure, required this.growth, required this.score, required this.birthtime, required this.adopttime, required this.species});
}

class CommonData {
  static UserInfo? me;
  static List<CoralInfo> mycorals = [];
  static String server = "192.168.10.7:3000";
  static int themeColor = 0xFF0058ea;
}