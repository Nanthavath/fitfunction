import 'package:fitfunction/screens/homePages/workoutPage/myPlan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteLis = ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          color: Colors.blue,
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          color: Colors.orange,
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
        ),
      ],
    );

    final ownList = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Image.asset(
                        'images/person.png',
                        width: 20,
                      ),
                      title: Text(
                        'My Plan$index',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(Icons.more_vert)),
                  Text('Level: Beginning'),
                  Text('Type: Beginning'),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyPlanPage()));
          },
        );
      },
    );

    final createButton = RaisedButton.icon(
      elevation: 1,
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(5),
      icon: Icon(Icons.add),
      label: Text('ສ້າງແຜນໃຫມ່'),
      onPressed: () {},
    );

    final searchText = SizedBox(
      height: 35,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'ຄົ້ນຫາ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              32.0,
            ),
            borderSide: BorderSide(width: 1),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
        ),
      ),
    );
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            searchText,
            Align(
              alignment: Alignment.bottomRight,
              child: createButton,
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                Container(
                  height: 150,
                  child: ownList,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 100,
                  child: favoriteLis,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
