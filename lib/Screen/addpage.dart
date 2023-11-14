import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_mangemnet_app/APIS/apis.dart';
import 'package:task_mangemnet_app/main.dart';
import 'package:task_mangemnet_app/model/tasklists.dart';
import 'package:task_mangemnet_app/utils/utils.dart';

Widget addtask(BuildContext context, List li) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingCOntroller = TextEditingController();
  return AlertDialog(
    content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Title",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _textEditingCOntroller,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Title...",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancle",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
                    )),
                TextButton(
                    onPressed: () {
                      li.add(_textEditingCOntroller.text);
                      APIs.storeDatabase(_textEditingCOntroller.text, 0)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Successfully created task title...."),
                          ),
                        );
                        ;
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
                    )),
              ],
            )
          ],
        )),
  );
}

Widget addlist(BuildContext context, String items, bool isUpdate, String id,
    String a, String b, String c) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  if (isUpdate) {
    _title.text = a;
    _desc.text = b;
    formattedDate = c;
  }
  int nums = 0;
  return AlertDialog(
    content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUpdate ? "Update List" : "Add List",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _title,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Title...",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _desc,
                maxLines: null,
                maxLength: 50,
                decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Description...",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Choose the date to complete the task ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                    onPressed: () async {
                      DateTime? datepicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(3000));
                      log("$datepicked");
                      formattedDate =
                          DateFormat('dd-MM-yyyy').format(datepicked!);
                    },
                    icon: Icon(Icons.calendar_month_outlined)),
                Text(
                  isUpdate ? formattedDate : "dd/mm/yyyy",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancle",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      )),
                  TextButton(
                      onPressed: () {
                        isUpdate
                            ? APIs.updatedatabase(items, _title.text,
                                    _desc.text, formattedDate, id)
                                .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Successfully updated  task ...."),
                                  ),
                                );
                              })
                            :
                            // list.add(task(
                            //     id: "hhhhh",
                            //     title: _title.text,
                            //     Description: _desc.text,
                            //     date: "5666"));
                            APIs.storesubdatabase(items, _title.text,
                                    _desc.text, formattedDate)
                                .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Successfully created task ...."),
                                  ),
                                );
                              });

                        Navigator.pop(context);
                      },
                      child: Text(
                        isUpdate ? "update" : "Add",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent),
                      )),
                ],
              )
            ],
          ),
        )),
  );
}


