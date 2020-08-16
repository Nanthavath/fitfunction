import 'package:fitfunction/screens/homePages/workoutPage/createPlan_page.dart';
import 'package:fitfunction/screens/homePages/workoutPage/myplan.dart';
import 'package:fitfunction/screens/homePages/workoutPage/view_workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    final sharePlan = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                        trailing: Icon(
                          Icons.favorite_border,
                          color: Colors.orange,
                        )),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewWorkoutPage()));
            },
          );
        },
      ),
    );
    final favoriteLis = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
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
                      trailing: Icon(
                        Icons.favorite,
                        color: Colors.orange,
                      )),
                  Text('Level: Beginning'),
                  Text('Type: Beginning'),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewWorkoutPage()));
          },
        );
      },
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
              width: MediaQuery.of(context).size.width / 2.2,
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

    final createButton = Align(
      alignment: Alignment.topRight,
      child: RaisedButton.icon(
        elevation: 1,
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(5),
        icon: Icon(Icons.add,color: Colors.orange,),
        label: Text('ສ້າງແຜນໃຫມ່'),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreatePlan()));
        },
      ),
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
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: <Widget>[
            searchText,
            createButton,
            Container(
              height: 120,
              child: ownList,
            ),
            Container(
              height: 120,
              child: favoriteLis,
            ),
            Expanded(child: sharePlan),
          ],
        ),
      ),
    );
  }
}
