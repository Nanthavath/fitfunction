import 'package:fitfunction/screens/homePages/postPages/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

String urlProfile =
    'https://firebasestorage.googleapis.com/v0/b/fitfunction-8d4d1.appspot.com/o/profiles%2Fprofile.png?alt=media&token=36c01c8f-4ca4-41d5-ac93-b771d9410263';

class _PostPageState extends State<PostPage> {
  Widget circleAvatars(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(urlProfile),
        backgroundColor: Colors.transparent,
      ),
      title: SizedBox(
        height: 30,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "What is on your mind?",
            textAlign: TextAlign.start,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => BuildPost(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 13, top: 8),
            height: 55,
            child: circleAvatars(context),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
