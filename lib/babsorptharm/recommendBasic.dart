import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Basic extends StatefulWidget {
  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.black87,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: Container(
                    child: Image(
                      height: 50,
                      width: 50,
                      image: AssetImage('images/app_logo.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'ຂໍ້ແນະນຳ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('ທ່ານມີນ້ຳໜັກມາດຕະຖານ',
                                style: TextStyle(fontSize: 18)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('ພວກເຮົາແນະນຳໃຫ້ທ່ານ',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('1 ສາມາດອອກກຳລັງກາຍໄດ້ຕາມຄວາມຕ້ອງການ'),
                          Text(
                              '2 ຄວບຄຸມອາຫານ, ຫຼີກລ່ຽງອາຫານມັນ, ຫວານ ແລະ ເຄັມ'),
                          Text('3 ດື່ມນ້ຳ 2 ລິດຂຶ້ນໄປ /ມື້'),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Text('ປະເພດ'),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('images/cutting_icon.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text('ຫຼຸດນ້ຳໜັກ')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('images/bulking_icon.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text('ເພີ່ມນ້ຳໜັກ')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('images/general_icon.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text('ທົ່ວໄປ')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('images/sport_icon.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text('ກິລາ')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text('ຄວາມຖີ່'),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: Text('1-7 ມື້/ອາທິດ'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text('ລະດັບ'),
                              Expanded(
                                child: Image(
                                  image: AssetImage('images/beginner.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Expanded(
                                child: Image(
                                  image: AssetImage('images/intermediate.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Expanded(
                                child: Image(
                                  image: AssetImage('images/advance.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text('ເຂົ້າໃຈແລ້ວ'),
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
