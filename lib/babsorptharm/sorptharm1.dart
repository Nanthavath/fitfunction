import 'package:fitfunction/babsorptharm/recommendAdvance.dart';
import 'package:fitfunction/babsorptharm/recommendBasic.dart';
import 'package:fitfunction/babsorptharm/recommendIntermediate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Soptharm1 extends StatefulWidget {
  @override
  _Soptharm1State createState() => _Soptharm1State();
}

List f = [
  'ບໍ່ເຄີຍອອກກຳລັງກາຍ',
  'ອກກຳລັງກາຍເປັນປົກກະຕິ',
  '1-2 ມື້/ອາທິດ',
  '3-6 ມື້/ອາທິດ',
  'ທຸກໆມື້'
];

String selectFrequency = '';
String weigth;
String heigth;

class _Soptharm1State extends State<Soptharm1> {
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
                              'ແບບສອບຖາມ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(fontSize: 20),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  new RegExp('[\\.|\\0-9]'))
                            ],
                            decoration: InputDecoration(
                              hintText: 'ນ້ຳໜັກ',
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: OutlineInputBorder(),
                              suffixText: 'Kg',
                            ),
                            onChanged: (value) => weigth = value,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  new RegExp('[\\.|\\0-9]'))
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'ລວງສູງ',
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: OutlineInputBorder(),
                              suffix: Text('cm'),
                            ),
                            onChanged: (value) => heigth = value,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('ຄວາມຖື່ໃນການອອກກຳລັງກາຍ',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              f.length,
                              (index) {
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Radio(
                                        value: f[index],
                                        groupValue: selectFrequency,
                                        onChanged: (value) {
                                          setState(() {
                                            selectFrequency = value;
                                          });
                                        },
                                      ),
                                      Text(f[index]),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                      double result = 0.0;
                      result = (double.parse(weigth) *
                          double.parse(weigth) /
                          double.parse(heigth));

                      if (result < 25) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Basic(),
                        ));
                      } else if (result > 30) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Intermediate(),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Advance(),
                        ));
                      }
                    },
                    child: Text('ຖັດໄປ'),
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
