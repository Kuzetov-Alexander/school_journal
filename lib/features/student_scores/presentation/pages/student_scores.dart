import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class LandingPage extends StatefulWidget {
  final columns = 10;
  final rows = 20;

  LandingPage({
    Key? key,
  }) : super(key: key);

  /// Создание колонок с строками
  List<List<String>> makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      // Для каждой колонки создаются строки
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('L$j : T$i');
      }
      output.add(row);
    }
    return output;
  }

  List allUsers = <String>[
    'Kuzetov Alexander Olegovich',
    'Frolov ',
    'Efanov ',
    'Kotegov ',
    'Miler',
    'Tropin ',
    'Kozlov ',
    'Okhmak ',
    'Chimrov ',
    'Prosvirov ',
    'Oreckhov ',
    'Chuprov',
    'Putin ',
    'Putin ',
    'Putin ',
    'Putin ',
    'Putin ',
    'Putin ',
    'Putin ',
    'Putin ',
  ];

  /// Simple generator for column title
  List<String> makeTitleColumn() =>
      List.generate(columns, (i) => 'День\n    $i');

  /// Simple generator for row title
  List<String> makeTitleRow() => List.generate(rows, (i) => '${allUsers[i]}');

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ученики'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Image(
              image: AssetImage('assets/images/button_arrow.png'),
              color: Colors.black,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Image(
              image: AssetImage('assets/images/plus.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(
                height: 1200,
                width: 260,
                child: StickyHeadersTable(
                  columnsLength: widget.makeTitleColumn().length,
                  rowsLength: widget.makeTitleRow().length,
                  columnsTitleBuilder: (i) =>
                      Text(widget.makeTitleColumn()[i]),
                  rowsTitleBuilder: (i) => Text(widget.makeTitleRow()[i]),
                  contentCellBuilder: (i, j) => Text(widget.makeData()[i][j]),
                  legendCell: const Text('Имя'),
                ),
              ),
              Column(children: [
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.green,
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
