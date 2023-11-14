import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_mangemnet_app/APIS/apis.dart';
import 'package:task_mangemnet_app/Screen/addpage.dart';
import 'package:task_mangemnet_app/main.dart';
import 'package:task_mangemnet_app/model/tasklists.dart';
import 'package:task_mangemnet_app/utils/utils.dart';

class ListDisplay extends StatefulWidget {
  late var lists;
  late String titles;

  ListDisplay({super.key, required this.titles, required this.lists});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  late ScaffoldMessengerState scaffoldMessenger;
  String nowdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  @override
  void didChangeDependencies() {
    // Save reference to ScaffoldMessenger during didChangeDependencies
    scaffoldMessenger = ScaffoldMessenger.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.lists.length,
        itemBuilder: (context, index) {
          // log("${widget.lists.length}");
          perc = widget.lists.length == 0 ? 0 : widget.lists.length;
          Color cardColor = _getCardColor(widget.lists[index].date);
          return Slidable(
            // key: Key(),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (contexts) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => addlist(
                                context,
                                widget.titles,
                                true,
                                widget.lists[index].id,
                                widget.lists[index].title,
                                widget.lists[index].description,
                                widget.lists[index].date,
                                
                                )));
                  },
                  backgroundColor: Colors.greenAccent,
                  icon: Icons.edit,
                ),
                SlidableAction(
                  onPressed: (contexts) {
                    APIs.storesubdatabasedeleted(
                            widget.titles, widget.lists[index].id)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Successfully deleted task....."),
                        ),
                      );
                    });
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                )
              ],
            ),
            child: Card(
              elevation: 4,
              child: Container(
                // height: 90,
                width: double.infinity,
                child: ListTile(
                  title: Text(
                    widget.lists[index].title,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.lists[index].description,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  trailing: Text(
                    widget.lists[index].date,
                    style: TextStyle(fontSize: 20, color: cardColor),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Color _getCardColor(String completionDate) {
    // DateTime now = DateTime.now();
    // //  DateTime now = DateFormat("dd-MM-yyyy").parse(DateFormat("dd-MM-yyyy").format(DateTime.now()));
    // log("now: $now");
    // DateTime completionDateTime = DateFormat("dd/MM/yyyy").parse(completionDate);
    // log("completion: $completionDate");
    // if (completionDateTime.isBefore(now)) {
    //   // Completion date is in the past
    //   return Colors.greenAccent;
    // } else if (isSameDay(now, completionDateTime)) {
    //   // Completion date is today
    //   return Colors.redAccent;
    // } else {
    //   // Completion date is in the future
    //   return Colors.lightBlueAccent;
    // }
    // DateTime now = DateTime.now();
     DateTime now = DateFormat("dd-MM-yyyy").parse(DateFormat("dd-MM-yyyy").format(DateTime.now()));

    try {
      DateTime completionDateTime =
          DateFormat("dd-MM-yyyy").parse(completionDate);

      if (completionDateTime.isBefore(now)) {
        // Completion date is in the past
        return Colors.greenAccent;
      } else if (isSameDay(now, completionDateTime)) {
        // Completion date is today
        return Colors.redAccent;
      } else {
        // Completion date is in the future
        return Colors.lightBlueAccent;
      }
    } catch (e) {
      print("Error parsing date: $e");
      // Handle the error or return a default color
      return Colors.grey;
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    // return date1.year == date2.year &&
    //     date1.month == date2.month &&
    //     date1.day == date2.day;
    Duration difference = date1.difference(date2);
    return difference.inDays == 0;
  }
}
