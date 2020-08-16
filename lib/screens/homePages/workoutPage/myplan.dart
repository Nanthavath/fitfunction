import 'package:flutter/material.dart';

class MyPlanPage extends StatefulWidget {
  @override
  _MyPlanPageState createState() => _MyPlanPageState();
}

class _MyPlanPageState extends State<MyPlanPage> {
  String profileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('My Plan'),
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 20),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.orange,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'My Plan',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.orange,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // border:
                      //     Border.all(color: AppColors.Yellow_COLOR, width: 2.0)),
                    ),
                    child: ClipOval(
                      child: Container(
                          height: 105,
                          width: 105,
                          color: Colors.grey[200],
                          child: profileImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : Image.network(
                                  profileImage,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (context, child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                )),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Routine:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Type:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(
                          10.0) //                 <--- border radius here
                      ),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 23),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                    ),
                    height: 110,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter name',
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'day',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.wallpaper,
                                  color: Colors.orange,
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                        PopupMenuButton(
                            onSelected: (value) {},
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 2,
                                    child: Text('Edit Recipe'),
                                  ),
                                  PopupMenuItem(
                                    value: 3,
                                    child: Text('Delete'),
                                  ),
                                ])
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
