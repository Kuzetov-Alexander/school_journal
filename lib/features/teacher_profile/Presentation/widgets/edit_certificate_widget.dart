import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';

class EditCertificateWidget extends StatefulWidget {
  const EditCertificateWidget({super.key});

  @override
  State<EditCertificateWidget> createState() => _EditCertificateWidgetState();
}

class _EditCertificateWidgetState extends State<EditCertificateWidget> {
  List<double> selectedSubject = [
    0.5,
    1,
    1.5,
    2,
    2.5,
    3,
    3.5,
    4,
    4.5,
    5,
    5.5,
    6,
    6.5,
    7,
    7.5,
    8,
    8.5,
    9,
    9.5,
    10
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      height: heightScreen * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: heightScreen * 0.012, bottom: heightScreen * 0.006),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: widthScreen * 0.06),
                Text(
                  'Аттестация',
                  style: TextStyle(
                      fontSize: heightScreen * 0.021,
                      fontWeight: FontWeight.w700),
                ),
                const Expanded(child: SizedBox.shrink()),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffEEEEEE),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Image(
                    image: AssetImage('assets/images/close_icon.png'),
                  ),
                ),
                SizedBox(width: widthScreen * 0.06),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            height: heightScreen * 0.001,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heightScreen * 0.025),
                Text(
                  'Суммарная оценка успеваемости ученика',
                  style: TextStyle(
                      fontSize: heightScreen * 0.018,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: heightScreen * 0.025),
                SizedBox(
                  height: heightScreen * 0.065,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffF3F3F3)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Баллов за посещение',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.025),
                SizedBox(
                  height: heightScreen * 0.065,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffF3F3F3)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Баллов за каждую 5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.025),
                SizedBox(
                  height: heightScreen * 0.065,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffF3F3F3)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Баллов за каждую 4',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.025),
                SizedBox(
                  height: heightScreen * 0.065,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffF3F3F3)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Баллов за каждую 3',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.025),
                SizedBox(
                  height: heightScreen * 0.065,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffF3F3F3)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Баллов за каждую 2',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0.5',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: heightScreen * 0.018,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            height: 56,
            width: widthScreen * 0.88,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(AppColors.purple),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Сохранить',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: heightScreen * 0.022,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: heightScreen * 0.065)
        ],
      ),
    );
  }
}
