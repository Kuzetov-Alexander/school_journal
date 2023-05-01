import 'package:flutter/material.dart';
import 'package:school_journal/common/color.dart';

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
           
              children: [
                ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    width: 80,
                    child: DataTable(
                      dataRowHeight: 25,
                      dividerThickness: 0,
                      border: const TableBorder(
                        verticalInside: BorderSide(
                          color: AppColors.gray5a5a5a,
                          width: 2,
                        ),
                      ),
                      columnSpacing: 10.0,
                      columns: const [
                        DataColumn(
                          label: Text('Имя'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        10,
                        (int index) => DataRow(
                          cells: [
                            DataCell(Text('Name ${index + 1}')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 230,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 25,
                      dividerThickness: 0,
                      border: const TableBorder(
                        verticalInside: BorderSide(
                          color: AppColors.gray5a5a5a,
                          width: 2,
                        ),
                      ),
                      columnSpacing: 10.0,
                      columns: const [
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(label: Text('Date 1')),
                        DataColumn(label: Text('Date 2')),
                        DataColumn(label: Text('Date 3')),
                        DataColumn(label: Text('Date 1')),
                        DataColumn(label: Text('Date 2')),
                        DataColumn(label: Text('Date 3')),
                        DataColumn(label: Text('Date 4')),
                        DataColumn(label: Text('Date 5')),
                        DataColumn(label: Text('Rating 1')),
                        DataColumn(label: Text('Rating 2')),
                      ],
                      rows: List<DataRow>.generate(
                        10,
                        (int index) => DataRow(
                          cells: [
                            DataCell(Text('Name ${index + 1}')),
                            const DataCell(Text('Date 1')),
                            const DataCell(Text('Date 2')),
                            const DataCell(Text('Date 3')),
                            const DataCell(Text('Date 4')),
                            const DataCell(Text('Date 2')),
                            const DataCell(Text('Date 3')),
                            const DataCell(Text('Date 4')),
                            const DataCell(Text('Date 5')),
                            const DataCell(Text('Rating 1')),
                            const DataCell(Text('Rating 2')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
               SizedBox(
                width: 70,
                 child: DataTable(
                        dataRowHeight: 25,
                        dividerThickness: 0,
                        border: const TableBorder(
                          verticalInside: BorderSide(
                            color: AppColors.gray5a5a5a,
                            width: 2,
                          ),
                        ),
                        columnSpacing: 15.0,
                        columns: const [
                          DataColumn(label: Text('СР')),
                          DataColumn(label: Text('АТ')),
                        ],
                        rows: List<DataRow>.generate(
                          10,
                          (int index) => const DataRow(
                            cells: [
                              DataCell(Text('2')),
                              DataCell(Text('5')),
                            ],
                          ),
                        ),
                      ),
               ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
