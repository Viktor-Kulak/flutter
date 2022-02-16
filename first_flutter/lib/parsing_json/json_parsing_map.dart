import 'dart:convert';


import 'package:first_flutter/model/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Network {
  final String url;

  Network(this.url);
  Future<PostList> loadPosts() async{
    final response = await get(Uri.parse(url));

    if(response.statusCode == 200){
      return PostList.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to get posts");
    }
  }

}
class JsonParsingMap extends StatefulWidget {
  const JsonParsingMap({Key? key}) : super(key: key);

  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  late Future<PostList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PODO"),
      ),
      body: Center(
        child: Container(

          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<PostList> snapshot) {
                List<Post> allPost;
                if (snapshot.hasData) {
                  allPost = snapshot.data!.posts;
                  return createListView(allPost, context);
                } else {
                  return CircularProgressIndicator();
                }
              }),


        ),

      ),
    );
  }

  Widget createListView(List<Post> data, BuildContext context) {
    return Container(

      child: ListView.builder(
          itemCount: data.length,

          itemBuilder: (context, int index) {
            return Column(
              children: [
                Divider(height: 5.0,),
                ListTile(
                  title: Text("${data[index].title}"),
                  subtitle: Text("${data[index].body}"),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 23,
                        child: Text("${data[index].id}"),
                      )
                    ],
                  ),
                )

              ],
            );
          }

      ),
    );
  }
}
