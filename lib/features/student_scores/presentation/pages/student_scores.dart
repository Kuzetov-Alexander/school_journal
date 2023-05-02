import 'package:flutter/material.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/add_student_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/attestation_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/date_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/scores_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/student_profile.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key? key,
  }) : super(key: key);

  List allUsers = <String>[
    'Kuzetov Alexander Olegovich',
    'Frolov Alexander Olegovich',
    'Efanov Alexander Olegovich',
    'Kotegov Alexander Olegovich',
    'Miler Alexander Olegovich',
    'Tropin Alexander Olegovich',
    'Kozlov Alexander Olegovich',
    'Okhmak Alexander Olegovich',
    'Chimrov Alexander Olegovich',
    'Prosvirov Alexander Olegovich',
    'Oreckhov Alexander Olegovich',
    'Chuprov Alexander Olegovich',
    'Putin Alexander Olegovich',
  ];

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ученики'),
        centerTitle: true,
        backgroundColor: Colors.white,
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
            onPressed: () {
              showModalBottomSheet(
                // barrierColor:Colors.transparent ,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const AddStudentWidget(),
              );
            },
            icon: const Image(
              image: AssetImage('assets/images/plus.png'),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: const Color(0xffFAFAFA),
                child: SizedBox(
                  width: widthScreen * 0.3,
                  child: DataTable(
                    dataRowHeight: heightScreen * 0.06,
                    // dividerThickness: 0,
                    border: const TableBorder(
                      top: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                      right: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                      bottom: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                    ),
                    // columnSpacing: 10.0,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Имя',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      widget.allUsers.length,
                      (int index) => DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: widthScreen * 0.18,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    // barrierColor:Colors.transparent ,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) =>
                                        const StudentProfile(),
                                  );
                                },
                                child: Text(
                                  '${widget.allUsers[index]}',
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: widthScreen * 0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: heightScreen * 0.06,
                    // dividerThickness: 0,
                    border: const TableBorder(
                      top: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                      verticalInside: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                      bottom: BorderSide(
                        color: AppColors.greyForTable,
                      ),
                    ),
                    columnSpacing: widthScreen * 0.1,
                    columns: const [
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                      DataColumn(label: DateWidget()),
                    ],
                    rows: List<DataRow>.generate(
                      widget.allUsers.length,
                      (int index) => const DataRow(
                        cells: [
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                          DataCell(ScoresWidget()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: widthScreen * 0.1,
                child: DataTable(
                  clipBehavior: Clip.hardEdge,
                  dataRowHeight: heightScreen * 0.06,
                  // dividerThickness: 0,
                  border: const TableBorder(
                    top: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                    left: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                    bottom: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Ср',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    widget.allUsers.length,
                    (int index) => const DataRow(
                      cells: [
                        DataCell(
                          AttestationWidget(
                            grade: '2',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: widthScreen * 0.1,
                child: DataTable(
                  dataRowHeight: heightScreen * 0.06,
                  // dividerThickness: 0,
                  border: const TableBorder(
                    top: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                    left: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                    bottom: BorderSide(
                      color: AppColors.greyForTable,
                    ),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Ат',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    widget.allUsers.length,
                    (int index) => const DataRow(
                      cells: [
                        DataCell(
                          AttestationWidget(
                            grade: '5',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
