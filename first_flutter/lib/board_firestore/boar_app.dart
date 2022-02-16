import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter/board_firestore/ui/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  var firestoreDb = FirebaseFirestore.instance.collection("board").snapshots();
  late TextEditingController  nameInputController;
  late TextEditingController  titleInputController;
  late TextEditingController  descriptionInputController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = new TextEditingController();
    titleInputController = new TextEditingController();
    descriptionInputController= new TextEditingController();
  }
  
  
@override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Community Board"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {_showDialog(context);},
          child: const Icon(FontAwesomeIcons.pen),
        ),
        body: StreamBuilder(
            stream: firestoreDb,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return CustomCard(snapshot: snapshot.data, index : index);
                   // return Text(snapshot.data.docs[index]['description']);
                  });
            }));

  }
  _showDialog(BuildContext context) async{
    await showDialog(builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(10),
      content: Column(
        children: [
          Text("Please fill out the form."),
          Expanded(child: TextField(
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(
              labelText: "Your name"
            ),
            controller: nameInputController,
          )),
        Expanded(child: TextField(
          autofocus: true,
          autocorrect: true,
          decoration: InputDecoration(
              labelText: "Title"
          ),
          controller: titleInputController,)),
          Expanded(child: TextField(
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(
                labelText: "Description"
            ),
            controller: descriptionInputController,))
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
                      if (titleInputController.text.isNotEmpty &&
                          nameInputController.text.isNotEmpty &&
                          descriptionInputController.text.isNotEmpty) {
                        FirebaseFirestore.instance.collection("board").add({
                          "name": nameInputController.text,
                          "title": titleInputController.text,
                          "description": descriptionInputController.text,
                          "timestamp": new DateTime.now()
                        }).then((response) {
                          print(response.id);
                          Navigator.pop(context);
                          nameInputController.clear();
                          titleInputController.clear();
                          descriptionInputController.clear();
                        }).catchError((error) => print(error));
                      }
                    },
                    child: Text("Save"))
              ],
            ), context: context);

  }
}
