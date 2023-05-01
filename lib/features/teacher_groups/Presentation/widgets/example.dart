import 'package:flutter/material.dart';

class ThreeColumnScrollableScreen extends StatefulWidget {
  @override
  _ThreeColumnScrollableScreenState createState() => _ThreeColumnScrollableScreenState();
}

class _ThreeColumnScrollableScreenState extends State<ThreeColumnScrollableScreen> {
  List<String> leftColumnData = List.generate(20, (index) => 'Левый элемент $index');
  List<String> rightColumnData = List.generate(20, (index) => 'Правый элемент $index');
  List<String> middleColumnData = List.generate(20, (index) => 'Средний элемент $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(child: Column(children: [Text('data')],)),
              SizedBox(
                height: 1200,
                width: 110,
              
                child: ListView.builder(

                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                      itemCount: leftColumnData.length,
                      itemExtent: 160,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(color:Colors.red,
                              width: 160,height: 25,
                              child: Row(children: [Text(leftColumnData[index])],),),
                            ],
                          ),
                        );
                        
                      },
                    ),),
                
              Expanded(child: Column(children: [Text('data1')],)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            leftColumnData.add('Новый элемент ${leftColumnData.length}');
            rightColumnData.add('Новый элемент ${rightColumnData.length}');
            middleColumnData.add('Новый элемент ${middleColumnData.length}');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
