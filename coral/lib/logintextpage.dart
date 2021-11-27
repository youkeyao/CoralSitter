import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coral/common.dart';

class LoginTextPage extends StatefulWidget {
  const LoginTextPage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _LoginTextPageState createState() => _LoginTextPageState();
}

class _LoginTextPageState extends State<LoginTextPage> {
  Color? background = Colors.blueAccent[700];
  // focus
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();

  final TextEditingController _userNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _warnText = '';
  bool _isShowPwd = false;
  bool _isShowClear = false;

  @override
  void initState() {
    super.initState();
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
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
    _userNameController.dispose();
    super.dispose();
  }

  // focus listen
  Future<void> _focusNodeListener() async{
    if(_focusNodeUserName.hasFocus){
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      _focusNodeUserName.unfocus();
    }
  }

  String? validateNull(value){
    if (value.isEmpty) {
      return '输入不能为空';
    }
    return null;
  }

  void login() {
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();

    _formKey.currentState!.save();
    if (_username == '' || _password == '') {
      _warnText = "输入不能为空";
    }
    else {
      if (_username == "1" && _password == "2") {
        CommonData.me = UserInfo(name: "Dolnna", avatar: "https://pic1.zhimg.com/v2-45cb7bd2ae4a16036acbebe4f2677560_r.jpg?source=1940ef5c", sign: "今天也是热爱珊瑚的一天");
        CommonData.me?.tags = ["外向开朗", "热情", "心思细腻"];
        CommonData.mycorals.add(CoralInfo(name: "泡泡", avatar: "https://pic1.zhimg.com/v2-45cb7bd2ae4a16036acbebe4f2677560_r.jpg?source=1940ef5c", position: "凤凰岛西侧海域", score: 96, updateTime: "2020.12.10"));
        Navigator.of(context).pop();
        widget.callback();
      }
      else {
        _warnText = "用户名或密码错误";
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
    return ScreenUtilInit(
      designSize: const Size(100, 100),
      builder: () => Scaffold(
        backgroundColor: background,
        // cancel keyboard
        body: GestureDetector(
          onTap: (){
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
          },
          child: ListView(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(5),),
              Icon(Icons.flutter_dash, color: Colors.white, size: ScreenUtil().setWidth(40),),
              SizedBox(height: ScreenUtil().setHeight(5),),
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
                      Container(
                        width: ScreenUtil().setWidth(90),
                        margin: EdgeInsets.all(ScreenUtil().setHeight(1)),
                        child: Text(_warnText, textAlign: TextAlign.left, style: const TextStyle(color: Color(0xffff1100), fontSize: 14),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(3),),
              // login button
              Container(
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                  onPressed: login,
                  child: Text("Log in", style: TextStyle(fontSize: 15, color: background),)
                )
              ),
              Container(
                height: ScreenUtil().setHeight(4),
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: TextButton(
                  onPressed: () {},
                  child: const Text("have no account?", style: TextStyle(fontSize: 12, color: Colors.white30),)
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}