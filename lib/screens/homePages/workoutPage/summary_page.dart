import 'package:commons/commons.dart';
import 'package:fitfunction/screens/homePages/workoutPage/createPlan_page.dart';
import 'package:fitfunction/screens/homePages/workoutPage/setPlan_page.dart';
import 'package:fitfunction/screens/homePages/workoutPage/workout_page.dart';
import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/circularProgress.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  MyBackButton(),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    '${workoutModel.namePlan}',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Text(
                'Finalize',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: workoutModel.dayPerWeek,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Day-${index + 1}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(Icons.more_vert),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Text(summeryData[index].days),
                              Row(
                                children: [
                                  Image.asset(
                                    'images/dumbbell.png',
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    summeryData[index]
                                        .selectedExercises
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.orange),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: SubmitButton(
                  title: 'Finish',
                  onPressed: () {
                    workoutModel.upLoadToDatabase().then((value) {
                      successDialog(context, 'ສຳເລັດແລ້ວ', neutralAction: () {
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (BuildContext context) => WorkoutPage()));
                        Navigator.maybePop(context).then((value) {
                          Navigator.maybePop(context)
                              .then((value) => Navigator.pop(context));
                        });
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
