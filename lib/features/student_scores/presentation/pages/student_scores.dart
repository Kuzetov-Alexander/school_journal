import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentScores extends StatelessWidget {
  const StudentScores({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ученики',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/Groups');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[],
      ),
    );
  }
}

/// Метод генерирует колонку
// List<Widget> _buildStaticColumn({
//   required int count,
//   required String titleColumn,
//   required double titleWight,
//   required String text,
// }) {
//   return List.generate(
//     count,
//     (index) => index == 0

//         /// Указываем заголовок
//         ? Container(
//             alignment: Alignment.center,
//             width: titleWight,
//             height: 40.0,
//             // color: Colors.amber,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black), color: Colors.amber),
//             child: Text(
//               titleColumn,
//               style: const TextStyle(fontWeight: FontWeight.w700),
//               maxLines: 2,
//             ),
//           )

//         /// колонка после
//         : Container(
//             alignment: Alignment.center,
//             width: titleWight,
//             height: 20.0,
//             // color: Colors.white,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black.withOpacity(0.2)),
//             ),
//             child: Text(
//               '${index + 1}.  $text',
//               style: const TextStyle(fontWeight: FontWeight.w300),
//             ),
//           ),
//   );
// }

// Table
// GridView
/// Генерирует скролящиеся по горизонтали колонки
// List<Widget> _buildRows({required int count}) {
//   return List.generate(
//     count,
//     (index) => Row(children: [
//       ..._buildStaticColumn(
//           count: 1, titleColumn: '---', text: '', titleWight: 20),
//       ..._buildStaticColumn(
//           count: count - 1, titleColumn: '[xxx]', text: '', titleWight: 20)
//     ]),
//   );
// }
