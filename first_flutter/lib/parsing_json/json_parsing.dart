// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class JsonParsingSimple extends StatefulWidget {
//   const JsonParsingSimple({Key? key}) : super(key: key);
//
//   @override
//   _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
// }
//
// class _JsonParsingSimpleState extends State<JsonParsingSimple> {
//   late Future data;
//
//   @override
//   void initState() {
//     super.initState();
//     data = getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Parsing Json"),
//       ),
//       body: Center(
//         child: Container(
//           child: FutureBuilder(
//               future: getData(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 return Text(snapshot.data);
//               }),
//         ),
//       ),
//     );
//   }
//
//   Future getData() async {
//     Future data;
//     String url = "https://jsonplaceholder.typicode.com/posts";
//     Network network = Network(url);
//     data = network.fetchData();
//     //   data.then((value) =>{
//     //    print(value[0]['title'])
//     // });
//     return data;
//   }
// }
//
// class Network {
//   final String url;
//
//   Network(this.url);
//
//   Future fetchData() async {
//     print("$url");
//
//     Response response = await get(Uri.encodeFull(url));
//
//     if (response.statusCode == 200) {
//       print(response.body[0]);
//       return json.decode(response.body);
//     } else {
//       print(response.statusCode);
//     }
//   }
// }
