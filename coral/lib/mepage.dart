import 'package:flutter/material.dart';

import 'package:coral/common.dart';
import 'package:coral/settingpage.dart';

class MeBox extends StatelessWidget {
  const MeBox({ Key? key, required this.user }) : super(key: key);
  final UserInfo user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(user.avatar, width: 80, height: 80,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(user.name, style: const TextStyle(fontSize: 25,),),
                const Text('other'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({ Key? key, required this.task }) : super(key: key);
  final String task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task, style: const TextStyle(fontSize: 15),),
          TextButton(
            onPressed: () {},
            child: const Text("去完成")
          ),
        ],
      ),
    );
  }
}

class MePage extends StatefulWidget {
  const MePage({ Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  UserInfo user = CommonData.me!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('我的'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage(callback: widget.callback))),
            icon: const Icon(Icons.settings)
          )
        ],
        backgroundColor: Colors.white60,
        foregroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          MeBox(user: CommonData.me!,),
          const TaskItem(task: "task1"),
          const TaskItem(task: "task2"),
          const TaskItem(task: "task3"),
          const TaskItem(task: "task4"),
        ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // if (CommonData.me != null) user = CommonData.me!;
  }
}