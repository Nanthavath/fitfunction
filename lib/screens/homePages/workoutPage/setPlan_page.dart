import 'package:fitfunction/widgets/backButton.dart';
import 'package:fitfunction/widgets/submitButton.dart';
import 'package:flutter/material.dart';

class SetPlan extends StatefulWidget {
  @override
  _SetPlanState createState() => _SetPlanState();
}

List<String> bodyPart = [
  'Back',
  'Chest',
  'Biceps',
  'Triceps',
  'Shoulders',
  'Abs',
  'Upper Leg',
  'Lower Leg'
];

class _SetPlanState extends State<SetPlan> {
  @override
  Widget build(BuildContext context) {
    final searchBox = SizedBox(
      height: 35,
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        cursorColor: Colors.black,
        decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(),
            ),
            contentPadding: EdgeInsets.only(
              top: 1,
              bottom: 1,
              right: 15,
            ),
            hintText: 'ຄົ້ນຫາ'),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyBackButton(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'My Plan',
                    style: TextStyle(fontSize: 25, color: Colors.orange),
                  ),
                ],
              ),
              Text(
                'Monday',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Center(child: searchBox),
              SizedBox(
                height: 15,
              ),
              Text('Body Part'),
              Container(
                  //color: Colors.orange,
                  child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
//                      width: 252 < MediaQuery.of(context).size.width
//                          ? MediaQuery.of(context).size.width
//                          : 252,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(bodyPart.length - 4, (index) {
                          return ChoiceChip(
                            label: Text(bodyPart[index]),
                            labelStyle: TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            selected: false,
                            backgroundColor: Color(0xffededed),
                            onSelected: (isSelected) {
                              setState(
                                () {},
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(bodyPart.length - 4, (index) {
                      return ChoiceChip(
                        label: Text(bodyPart[index + 4]),
                        labelStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        selected: false,
                        backgroundColor: Color(0xffededed),
                        onSelected: (isSelected) {
                          setState(
                            () {},
                          );
                        },
                      );
                    }),
                  ),
                ],
              )),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border:Border(bottom: BorderSide(width: 0.1))
                        ),
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text('Name of Exercises'),
                          subtitle: Text('Type'),
                          trailing: SizedBox(
                            width: 30,
                            height: 30,
                            child: OutlineButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.orange,
                              onPressed: (){},
                            ),
                          )
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: SubmitButton(
                    title: 'ຖັດໄປ',
                    onPressed: (){},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
