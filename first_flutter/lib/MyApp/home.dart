import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BizzCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(onPressed:()=>debugPrint("Lock") , icon: Icon(Icons.email)),
          IconButton(onPressed: ()=> debugPrint("Vity"), icon: Icon(Icons.account_circle))
        ],
      ),
      backgroundColor: Colors.cyan,
      body: Container(

        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[ _getCard(), _getAvatar()],

        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
        width: 350,
        height: 200,
        margin: EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(15.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Viktor Kulak",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepOrange,
                  fontStyle: FontStyle.italic),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget> [
                Icon(Icons.assignment_ind),
                Text(
                  "INS: c_r_a_z_y_p_o_e_t",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ));
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.black, width: 1.2),
          image: const DecorationImage(
              image: NetworkImage("https://picsum.photos/seed/picsum/300/300"),
              fit: BoxFit.cover)),
    );
  }
}
