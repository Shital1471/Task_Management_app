import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_mangemnet_app/APIS/apis.dart';
import 'package:task_mangemnet_app/Screen/addpage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_mangemnet_app/Screen/listdisplay.dart';
import 'package:task_mangemnet_app/main.dart';
import 'package:task_mangemnet_app/model/tasklists.dart';

class TaskPage extends StatefulWidget {
  String texts;
  TaskPage({super.key, required this.texts});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late List<task> items;
  @override
  void didChangeDependencies() {
    // Save reference to ScaffoldMessenger during didChangeDependencies
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    items = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7E80AA),
      appBar: AppBar(
        backgroundColor: Color(0xFF7E80AA),
        leading: IconButton(
          onPressed: () {
            log("$perc");
            APIs.updatetask(widget.texts, perc).then((value) {
              log("$perc");
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,),
        ),
        centerTitle: true,
        title: Text(widget.texts,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return addlist(
                        context, widget.texts, false, "", "", "", "");
                  }).then((value) {});
            },
            icon: Icon(Icons.add,size: 25,color: Colors.black,),
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: StreamBuilder(
              stream: APIs.firestore
                  .collection("users/${widget.texts}/tasks")
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    var list = [];
                    final data = snapshot.data?.docs;
                    list = data!.map((e) => task.fromjson(e.data())).toList();
                    if (list.isNotEmpty) {
                      return  ListDisplay(titles: widget.texts, lists: list);
                    } else {
                      perc = 0;
                      return Center(
                        child: Text(
                          "No task present. Create a new tasks....",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                }
              })),
    );
  }
}
