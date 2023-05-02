import 'package:flutter/material.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/add_student_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/attestation_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/date_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/scores_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/student_profile.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  final List<String> allUsers = <String>[
    'Kuzetov Абдурахмангаджи Olegovich',
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
      body: SingleChildScrollView(
        child: Column(
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
                      horizontalMargin: 8,
                      checkboxHorizontalMargin: 0,
                      headingRowHeight: heightScreen * 0.07,
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
                              InkWell(
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
                                // ------------------------------------
                                child: SizedBox(
                                  width: widthScreen * 0.26,
                                  child: Text(
                                    widget.allUsers[index],
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
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
                      headingRowHeight: heightScreen * 0.07,
                      horizontalMargin: 10,

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
                      columnSpacing: widthScreen * 0.05,
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
                        (int index) => DataRow(
                          cells: [
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                            DataCell(ScoresWidget(list: widget.allUsers)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: widthScreen * 0.1,
                  child: DataTable(
                    headingRowHeight: heightScreen * 0.07,
                    horizontalMargin: 7,
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
                        label: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Ср',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
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
                    headingRowHeight: heightScreen * 0.07,
                    horizontalMargin: 7,
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
                        label: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Ат',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
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
      ),
    );
  }
}
