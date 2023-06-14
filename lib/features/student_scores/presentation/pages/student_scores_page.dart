import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/bloc/scores_page_bloc.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/attestation_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/date_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/scores_widget.dart';

class StudentScoresPage extends StatefulWidget {
  const StudentScoresPage({super.key});

  @override
  StudentScoresPageState createState() => StudentScoresPageState();
}

class StudentScoresPageState extends State<StudentScoresPage> {
  void _getInfoSubject(context, {required groupName, required subject}) {
    BlocProvider.of<ScoresPageBloc>(context).add(
      GetInfoSubjectEvent(
        groupName: groupName,
        subject: subject,
      ),
    );
  }

  void _getInfoSchedule(context) {
    BlocProvider.of<ScoresPageBloc>(context).add(
      GetInfoScheduleEvent(),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getInfoSubject(context,
          groupName:
              Provider.of<ProviderScores>(context, listen: false).currentGroup,
          subject: Provider.of<ProviderScores>(context, listen: false)
              .currentSubject);
      // _getInfoSchedule(context);
    });
  }

  @override
  void didChangeDependencies() {
    _getInfoSchedule(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final providerScores = Provider.of<ProviderScores>(context);
    return BlocBuilder<ScoresPageBloc, ScoresPageState>(
      builder: (context, state) {
        if (state is GetInfoSubjectState) {
          providerScores.updateDataMap(studentData: state.data);
          // print('${providerScores.mapData}');
        }
        if (state is GetInfoScheduleState) {
          providerScores.updateLessonsMap(
              lessonData: state.data,
              subject: Provider.of<ProviderScores>(context, listen: false)
                  .currentSubject);
          // print(providerScores.dataForDateWidget());
        }

        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () => context.goNamed('Journal'),
              child: const Image(
                image: AssetImage('assets/images/arrow_left.png'),
              ),
            ),
            automaticallyImplyLeading: false,
            title: Text(
              '${providerScores.currentSubject}',
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return alertDialogforTable(widthScreen, heightScreen);
                    },
                  );
                },
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
          body: Builder(builder: (context) {
            if (providerScores.allStudentDataList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColoredBox(
                        color: const Color(0xffFAFAFA),
                        child: SizedBox(
                          width: widthScreen * 0.31,
                          child: DataTable(
                            horizontalMargin: 8,
                            checkboxHorizontalMargin: 0,
                            headingRowHeight: heightScreen * 0.07,
                            dataRowMinHeight: heightScreen * 0.06,
                            dataRowMaxHeight: heightScreen * 0.06,
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
                            // Имена студентов
                            rows: List<DataRow>.generate(
                              providerScores.allStudentDataList.length,
                              (int index) => DataRow(
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: widthScreen * 0.26,
                                      child: Text(
                                        providerScores
                                            .allStudentDataList[index],
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
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
                        width: widthScreen * 0.49,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowHeight: heightScreen * 0.07,
                            horizontalMargin: 10,
                            dataRowMinHeight: heightScreen * 0.06,
                            dataRowMaxHeight: heightScreen * 0.06,
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
                            // TODO(Sanya) надо сделать генерацию виджетов даты нормальную!
                            columns: List.generate(
                              providerScores.listLessons.length,
                              (index) =>
                                  DataColumn(label: DateWidget(index: index)),
                            ),

                            // оценки
                            rows:
                                // list
                                //     .map(
                                //       (element) => DataRow(
                                //         cells: List.generate(
                                //           list.length,
                                //           (index) => DataCell(
                                //             Text(
                                //               element.toString(),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     )
                                //     .toList()
                                List<DataRow>.generate(
                              // сюда нужно указать количество дат с уроками по предмету
                              // ряд оценки у ученика
                              providerScores.allStudentDataList.length,
                              (int index) => DataRow(
                                cells: List.generate(
                                  providerScores.listLessons.length,
                                  (index) => DataCell(
                                    // Text('${list[index][index]}'),
                                    ScoresWidget(
                                        listStudentTable:
                                            providerScores.allStudentDataList,
                                        index: index),
                                  ),
                                ),
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
                          dataRowMinHeight: heightScreen * 0.06,
                          dataRowMaxHeight: heightScreen * 0.06,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            providerScores.allStudentDataList.length,
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
                          dataRowMinHeight: heightScreen * 0.06,
                          dataRowMaxHeight: heightScreen * 0.06,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            providerScores.allStudentDataList.length,
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
          }),
        );
      },
    );
  }

  AlertDialog alertDialogforTable(double widthScreen, double heightScreen) {
    final provider = Provider.of<ProviderScores>(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: widthScreen * 0.5,
        height: heightScreen * 0.25,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${provider.currentSubject}',
                  style: TextStyle(
                      fontSize: heightScreen * 0.025,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black212525),
                ),
                TextButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(top: heightScreen * 0.7),
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          scrollController:
                              FixedExtentScrollController(initialItem: 1),
                          itemExtent: 30,
                          onSelectedItemChanged: (value) {
                            setState(
                              () {
                                // selectedSubject = [
                                //   'Математика',
                                //   'История',
                                //   'Химия',
                                //   'Русский язык',
                                //   'Физика'
                                // ][value];
                              },
                            );
                          },
                          children: const [
                            Text('Математика'),
                            Text('История'),
                            Text('Химия'),
                            Text('Русский язык'),
                            Text('Физика')
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Выбрать предмет'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Выгрузить в Excel'),
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.greybcc1cd)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ок"))
              ],
            );
          },
        ),
      ),
    );
  }
}
