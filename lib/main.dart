import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Регистрация',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                const SizedBox(
                  child: Image(
                    image: AssetImage('assets/images/book.png'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(2),
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              const BorderSide(width: 1),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Учитель',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 2),
                      Expanded(
                        child: TextButton(
                          style:
                              // TextButton.styleFrom(
                              //   backgroundColor: Colors.white,
                              //   minimumSize: const Size(double.infinity, 28),
                              //   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // ),

                              ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              const BorderSide(width: 1),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Ученик',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   child: TextFormField(),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
