import "package:flutter/material.dart";
import "package:task_mangemnet_app/APIS/apis.dart";
import "package:task_mangemnet_app/Screen/addpage.dart";
import 'package:task_mangemnet_app/Screen/carddisplay.dart';
import "package:task_mangemnet_app/model/user.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> items;
  @override
  void initState() {
    super.initState();
    items = []; // Initialize the items list in the initState method
  }

  @override
  Widget build(BuildContext context) {
    items ??= [];
    return Scaffold(
      
      backgroundColor: Color(0xFF8AABBE),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF99C7CE),
        centerTitle: true,
        title: Text("Task Management App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return addtask(context, items);
              })).then((value) {
            setState(() {});
          });
        },
        child: Image.asset('Images/tab.png'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Text("Important Task 📝",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: StreamBuilder(
                  stream: APIs.firestore.collection("users").snapshots(),
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
                        list =
                            data!.map((e) => users.fromjson(e.data())).toList();
                        var reverse = list.reversed.toList();
                        if (reverse.isNotEmpty) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 200,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 13,
                                      mainAxisSpacing: 10),
                              itemCount: reverse.length,
                              itemBuilder: (context, index) {
                                return CardPage(
                                  items: reverse[index].title,
                                  data: reverse[index].time,
                                  nums: reverse[index].length,
                                  n: reverse.length,
                                  
                                );
                              });
                        } else {
                          return Center(
                            child: Text("No task Found 📝",
                            style: TextStyle(
                              fontSize: 25,
                              color:Colors.black
                            ),
                            ),
                          );
                        }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
