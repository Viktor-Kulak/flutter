import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot<Map<String, dynamic>> snapshot;

  final int index;

  const CustomCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.docs[index].data();
    var docsID = snapshot.docs[index].id;

    late TextEditingController nameInputController =
        TextEditingController(text: snapshotData["name"]);
    late TextEditingController titleInputController =
        TextEditingController(text: snapshotData["title"]);
    late TextEditingController descriptionInputController =
        TextEditingController(text: snapshotData["description"]);

    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        snapshotData["timestamp"].seconds * 1000);

    var dateFormatted = new DateFormat("EEEE , MMM d ").format(timeToDate);
    return Column(
      children: [
        Container(
          height: 190,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                ListTile(
                    title: Text(snapshotData["title"]),
                    subtitle: Text(snapshotData["description"]),
                    leading: CircleAvatar(
                      radius: 34,
                      child: Icon(Icons.account_circle),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("By :${snapshotData["name"]}  "),
                      Text(dateFormatted),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await showDialog(
                              builder: (context) => AlertDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    content: Column(
                                      children: [
                                        Text(
                                            "Please fill out the form to update."),
                                        Expanded(
                                            child: TextField(
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                              labelText: "Your name"),
                                          controller: nameInputController,
                                        )),
                                        Expanded(
                                            child: TextField(
                                          autofocus: true,
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                              labelText: "Title"),
                                          controller: titleInputController,
                                        )),
                                        Expanded(
                                          child: TextField(
                                            autofocus: true,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                labelText: "Description"),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            nameInputController.clear();
                                            titleInputController.clear();
                                            descriptionInputController.clear();

                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      FlatButton(
                                          onPressed: () {
                                            if (titleInputController
                                                    .text.isNotEmpty &&
                                                nameInputController
                                                    .text.isNotEmpty &&
                                                descriptionInputController
                                                    .text.isNotEmpty) {
                                              FirebaseFirestore.instance
                                                  .collection("board")
                                                  .doc(docsID)
                                                  .update({
                                                "name":
                                                    nameInputController.text,
                                                "title":
                                                    titleInputController.text,
                                                "description":
                                                    descriptionInputController
                                                        .text,
                                                "timestamp": new DateTime.now()
                                              }).then((response) {
                                                Navigator.pop(context);
                                              });
                                              // FirebaseFirestore.instance.collection("board")
                                              //     .add({
                                              //   "name": nameInputController.text,
                                              //   "title": titleInputController.text,
                                              //   "description": descriptionInputController
                                              //       .text,
                                              //   "timestamp": new DateTime.now()
                                              // }).then((response) {
                                              //   print(response.id);
                                              //   Navigator.pop(context);
                                              //   nameInputController.clear();
                                              //   titleInputController.clear();
                                              //   descriptionInputController.clear();
                                              // }).catchError((error) => print(error));
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  ),
                              context: context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 15,
                        )),
                    SizedBox(
                      height: 19,
                    ),
                    IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("board")
                              .doc(docsID)
                              .delete();
                        },
                        icon: Icon(
                          FontAwesomeIcons.trashAlt,
                          size: 15,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),

        // T
      ],
    );
  }
}
