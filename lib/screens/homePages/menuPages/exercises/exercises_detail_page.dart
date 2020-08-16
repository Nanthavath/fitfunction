import 'package:fitfunction/widgets/backButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExcercisesDetail extends StatefulWidget {
  String exname;
  String url;
  String caption;

  ExcercisesDetail(this.exname, this.url,this.caption);

  @override
  _ExcercisesDetailState createState() => _ExcercisesDetailState(exname, url,caption);
}

class _ExcercisesDetailState extends State<ExcercisesDetail> {
  String exname;
  String url;
  String caption;

  _ExcercisesDetailState(this.exname, this.url,this.caption);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Text(exname),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Image.network(url),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15),
                child: ListView(
                  children: [
                    Text(exname,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(caption),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
