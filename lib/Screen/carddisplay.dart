import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mangemnet_app/APIS/apis.dart';
import 'package:task_mangemnet_app/Screen/taskpage.dart';
import 'package:task_mangemnet_app/listcolors.dart';
import 'package:task_mangemnet_app/main.dart';
import 'package:task_mangemnet_app/model/user.dart';
import 'package:task_mangemnet_app/utils/utils.dart';

class CardPage extends StatefulWidget {
  String items;
  String data;
  int nums;
  int n;
  CardPage(
      {super.key, required this.items, required this.data, required this.nums,required this.n});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int n = -1;
  @override
  void didChangeDependencies() {
    // Save reference to ScaffoldMessenger during didChangeDependencies
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    // n = widget.n % colors.length -1;
  }

  // int percentage = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your are sure this task is deleted?",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                )),
                            TextButton(
                                onPressed: () {
                                  APIs.taskdeleted(widget.items).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Successfully deleted task title...."),
                                      ),
                                    );
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ))
                          ],
                        )
                      ]),
                ),
              );
            });
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => TaskPage(
                      texts: widget.items,
                    )));
        setState(() {});
      },
      child: Card(
        color: colors[0],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          margin: EdgeInsets.only(right: 5),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.greenAccent,
                              image: DecorationImage(
                                  image: AssetImage("Images/progress.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          (widget.nums * 10).toString(),
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      widget.items,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage("Images/calendar.png"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        DateFormat("dd/MM/yyyy").format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(widget.data))),
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
