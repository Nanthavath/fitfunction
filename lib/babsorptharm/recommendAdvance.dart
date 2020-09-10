import 'package:fitfunction/screens/homePages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Advance extends StatefulWidget {
  @override
  _AdvanceState createState() => _AdvanceState();
}

class _AdvanceState extends State<Advance> {
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
                            child: Text('ທ່ານມີນ້ຳໜັກເກີນມາດຕະຖານໄປຫຼາຍ',
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
                          Text(
                              '1 ອອກກຳລັງກາຍເບົາໆ ໂດຍສະເພາະການອອກກຳລັງກາຍທີ່ໃຊ້ສ່ວນຂາເປັນຫຼັກ'),
                          Text(
                              '2 ຄວບຄຸມອາຫານ, ຫຼີກລ່ຽງອາຫານມັນ, ຫວານ ແລະ ເຄັມ'),
                          Text('3 ດື່ມນ້ຳ 2 ລິດຂຶ້ນໄປ /ມື້'),
                          Text(
                              '4 ການອອກກຳລັງກາຍຄວນເລີ່ມຈາກ ການອອກກຳລັງກາຍທີ່ໃຊ້ເວລາດົນເຊັ່ນ:ຍ່າງ, ໂຍຄະ...'),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Text('ປະເພດ'),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
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
                                child: Text('1-3 ມື້/ອາທິດ'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ລະດັບ'),
                              SizedBox(
                                width: 40,
                              ),
                              Image(
                                image: AssetImage('images/beginner.png'),
                                width: 40,
                                height: 40,
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
