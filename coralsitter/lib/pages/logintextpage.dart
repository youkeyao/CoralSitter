import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:coralsitter/common.dart';

class LoginTextPage extends StatefulWidget {
  const LoginTextPage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _LoginTextPageState createState() => _LoginTextPageState();
}

class _LoginTextPageState extends State<LoginTextPage> {
  Color? background = Color(CommonData.themeColor);
  // focus
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();
  final FocusNode _focusNodeConfirmPassWord = FocusNode();

  final TextEditingController _userNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _confirmPwd = '';
  String _warnText = '';
  bool _isShowPwd = false;
  bool _isShowConfirmPwd = false;
  bool _isShowClear = false;
  bool _isLogin = true;

  @override
  void initState() {
    super.initState();
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    _focusNodeConfirmPassWord.addListener(_focusNodeListener);
    _userNameController.addListener((){
      if (_userNameController.text.isNotEmpty) {
        _isShowClear = true;
      }
      else {
        _isShowClear = false;
      }
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _focusNodeConfirmPassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // focus listen
  Future<void> _focusNodeListener() async{
    if(_focusNodeUserName.hasFocus){
      _focusNodePassWord.unfocus();
      _focusNodeConfirmPassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      _focusNodeUserName.unfocus();
      _focusNodeConfirmPassWord.unfocus();
    }
    if (_focusNodeConfirmPassWord.hasFocus) {
      _focusNodeUserName.unfocus();
      _focusNodePassWord.unfocus();
    }
  }

  String? validateNull(value){
    if (value.isEmpty) {
      return '输入不能为空';
    }
    return null;
  }

  void login() async {
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();
    _focusNodeConfirmPassWord.unfocus();

    _formKey.currentState!.save();
    if (_username == '' || _password == '') {
      _warnText = "输入不能为空";
    }
    else {
      try {
        Uri uri = Uri.parse('http://' + CommonData.server + '/login');
        http.Response response = await http.post(
          uri,
          body: {
            'username': _username,
            'password': _password
          },
        );
        Map<dynamic, dynamic> responseData = json.decode(response.body);

        if (responseData['success']) {
          // CommonData.me = UserInfo(name: "Dolnna", avatar: "https://pic1.zhimg.com/v2-45cb7bd2ae4a16036acbebe4f2677560_r.jpg?source=1940ef5c", sign: "今天也是热爱珊瑚的一天");
          // CommonData.me?.tags = ["外向开朗", "热情", "心思细腻"];
          CommonData.me = UserInfo(
            name: responseData['username'],
            avatar: 'http://' + CommonData.server + '/static/user_avatar/' + responseData['username'] + '.jpg',
            sign: responseData['sign'],
            tags: responseData['tags'].split('-'),
          );
          responseData['mycorals'].forEach((coral) => {
            CommonData.mycorals.add(
              CoralInfo(
                name: coral['coralname'],
                avatar: 'http://' + CommonData.server + '/static/coral_avatar/' + coral['coralname'] + '.jpg',
                position: coral['position'],
                updateTime: coral['updatetime'],
                tags: coral['tags'].split('-'),
                species: coral['species'],
                light: coral['light'],
                temp: coral['temp'],
                microelement: coral['microelement'],
                size: coral['size'],
                lastmeasure: coral['lastmeasure'],
                growth: coral['growth'],
                score: coral['score'],
              )
            )
          });
          /*CommonData.mycorals.add(
            CoralInfo(
              name: "泡泡",
              avatar: "https://pic1.zhimg.com/v2-45cb7bd2ae4a16036acbebe4f2677560_r.jpg?source=1940ef5c",
              position: "凤凰岛西侧海域",
              tags: "好强 / 敏感 / 易碎 / 丰满 / 易满足",
              score: 96,
              updateTime: "2020.12.10",
              positionImage: "http://via.placeholder.com/500x250",
              species: "气泡珊瑚",
              monitor: {
                "光照强度": "充足",
                "海水气温": "温暖",
                "微量元素": "偏少"
              },
              grow: {
                "大小": "14",
                "距离上次测量": "+0.2",
                "平均每月增长": "0.15",
              },
            )
          );
          CommonData.mycorals.add(
            CoralInfo(
              name: "嘻嘻",
              avatar: "https://pic1.zhimg.com/v2-45cb7bd2ae4a16036acbebe4f2677560_r.jpg?source=1940ef5c",
              position: "渤海海域东侧",
              tags: "好强 / 敏感 / 易碎 / 丰满 / 易满足",
              score: 89,
              updateTime: "2020.12.10",
              positionImage: "http://via.placeholder.com/500x250",
              species: "气泡珊瑚",
              monitor: {
                "光照强度": "充足",
                "海水气温": "温暖",
                "微量元素": "偏少"
              },
              grow: {
                "大小": "14",
                "距离上次测量": "+0.2",
                "平均每月增长": "0.15",
              },
            )
          );*/
          Navigator.of(context).pop();
          widget.callback();
        }
        else {
          _warnText = "用户名或密码错误";
        }
      }
      catch(e) {
        _warnText = "连接服务器失败";
        print(e);
      }
    }
    
    setState(() {
    });
  }

  void signUp() async {
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();
    _focusNodeConfirmPassWord.unfocus();

    _formKey.currentState!.save();
    if (_username == '' || _password == '' || _confirmPwd == '') {
      _warnText = "输入不能为空";
    }
    else if (_password != _confirmPwd) {
      _warnText = "输入密码不一致";
    }
    else {
      try {
        Uri uri = Uri.parse('http://' + CommonData.server + '/signup');
        http.Response response = await http.post(
          uri,
          body: {
            'username': _username,
            'password': _password
          },
        );
        Map<dynamic, dynamic> responseData = json.decode(response.body);

        if (responseData['success']) {
          CommonData.me = UserInfo(
            name: responseData['username'],
            avatar: 'http://' + CommonData.server + '/static/user_avatar/' + responseData['username'] + '.jpg',
            sign: responseData['sign'],
            tags: responseData['tags'].split('-'),
          );
          Navigator.of(context).pop();
          widget.callback();
        }
        else {
          _warnText = "注册失败";
        }
      }
      catch(e) {
        _warnText = "连接服务器失败";
        print(e);
      }
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget userInput = TextFormField(
      controller: _userNameController,
      focusNode: _focusNodeUserName,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "username",
        labelStyle: const TextStyle(color: Colors.white),
        hintText: "",
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.person, color: Colors.white,),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        // clear button
        suffixIcon: (_isShowClear) ? IconButton(
          icon: const Icon(Icons.clear, color: Colors.white,),
          onPressed: (){
            _userNameController.clear();
          },
        ) : null,
      ),
      onSaved: (String? value){
        _username = value!;
      },
    );

    Widget pswInput = TextFormField(
      focusNode: _focusNodePassWord,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "password",
        labelStyle: const TextStyle(color: Colors.white),
        hintText: "",
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.lock, color: Colors.white,),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        // show password
        suffixIcon: IconButton(
          icon: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
          onPressed: (){
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        )
      ),
      obscureText: !_isShowPwd,
      onSaved: (String? value){
        _password = value!;
      },
    );

    Widget confirmPswInput = TextFormField(
      focusNode: _focusNodeConfirmPassWord,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "confirm password",
        labelStyle: const TextStyle(color: Colors.white),
        hintText: "",
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.lock, color: Colors.white,),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        // show password
        suffixIcon: IconButton(
          icon: Icon((_isShowConfirmPwd) ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
          onPressed: (){
            setState(() {
              _isShowConfirmPwd = !_isShowConfirmPwd;
            });
          },
        )
      ),
      obscureText: !_isShowConfirmPwd,
      onSaved: (String? value){
        _confirmPwd = value!;
      },
    );

    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: background,
        // cancel keyboard
        body: GestureDetector(
          onTap: (){
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
            _focusNodeConfirmPassWord.unfocus();
          },
          child: ListView(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(8),),
              Image(image: const AssetImage('assets/icons/icon.png'), height: ScreenUtil().setHeight(20),),
              SizedBox(height: ScreenUtil().setHeight(8),),
              // input
              Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: background
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      userInput,
                      pswInput,
                      _isLogin ? const SizedBox() : confirmPswInput,
                      Container(
                        width: ScreenUtil().setWidth(90),
                        margin: EdgeInsets.all(ScreenUtil().setHeight(1)),
                        child: Text(_warnText, textAlign: TextAlign.left, style: const TextStyle(color: Color(0xffff1100), fontSize: 14),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5),),
              // login button
              Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                  onPressed: _isLogin ? login : signUp,
                  child: Text(_isLogin ? "Log in" : "Sign up", style: TextStyle(fontSize: 15, color: background),)
                )
              ),
              Container(
                height: ScreenUtil().setHeight(4),
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin ? "have no account?" : "already have an account?", style: TextStyle(fontSize: 12, color: Colors.white30),)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}