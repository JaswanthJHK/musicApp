import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _onChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 100, 100, 100),
              Color.fromARGB(255, 25, 25, 25)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 94, 94, 94),
                      Color.fromARGB(255, 35, 35, 35)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 143, 143, 143),
                          Color.fromARGB(255, 75, 75, 75)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new)),
                        const Padding(
                          padding: EdgeInsets.only(right: 140),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 40, right: 20),
              //     child: ListView(
              //       children: [
              //         widgetList(
              //             const Text(
              //               'Profile',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 218, 218, 218),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //         widgetList(
              //             const Text(
              //               'Pryvacy Policy',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 217, 217, 217),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //         widgetList(
              //             const Text(
              //               'Notifications',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 215, 215, 215),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //         widgetList(
              //             const Text(
              //               'Share The App',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 215, 215, 215),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //         widgetList(
              //             const Text(
              //               'Terms and Conditions',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 215, 215, 215),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //         widgetList(

              //             const Text(
              //               'About Us',
              //               style: TextStyle(
              //                   color: Color.fromARGB(255, 214, 214, 214),
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.grey[300],
              //               size: 20,
              //             )),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 222, 222, 222),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 215, 215, 215),
                          title: Text('Terms And Conditions'),
                          content: const Text(
                              'These are electronic systems and technologies that assist drivers in operating their vehicles more safely and efficiently. ADAS includes a variety of features such as adaptive cruise control, automatic emergency braking, lane departure warning, blind spot detection, parking assistance, and others. These features use sensors, cameras, and other technologies to help the driver stay alert, avoid collisions, and improve overall driving performance. ADAS is becoming more common i'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Terms And Condtions'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 251, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 215, 215, 215),
                          title: Text('Privacy Policy'),
                          content: const Text(
                              'These are electronic systems and technologies that assist drivers in operating their vehicles more safely and efficiently. ADAS includes a variety of features such as adaptive cruise control, automatic emergency braking, lane departure warning, blind spot detection, parking assistance, and others. These features use sensors, cameras, and other technologies to help the driver stay alert, avoid collisions, and improve overall driving performance. ADAS is becoming more common i'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Privacy Policy'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 251, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {},
                  child: Text('Share The app'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 251, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                            backgroundColor: Color.fromARGB(255, 215, 215, 215),
                            title: Text('Profile Name'),
                            content: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Your Name',
                              ),
                            ));
                      },
                    );
                  },
                  child: Text('Profile'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 251, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 215, 215, 215),
                          title: Text('About Us'),
                          content: const Text(
                              'These are electronic systems and technologies that assist drivers in operating their vehicles more safely and efficiently. ADAS includes a variety of features such as adaptive cruise control, automatic emergency braking, lane departure warning, blind spot detection, parking assistance, and others. These features use sensors, cameras, and other technologies to help the driver stay alert, avoid collisions, and improve overall driving performance. ADAS is becoming more common i'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        );
                      },
                    );
                  },
                  child: Text('About Us'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xFF808080),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(300, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                              color: Color.fromARGB(255, 251, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 215, 215, 215),
                            title: Text(' Notification'),
                            content: ListTile(
                              title: Text('Turn On'),
                              trailing: Switch(
                                value: _onChange,
                                onChanged: (value) {
                                  return setState(() {
                                    _onChange = value;
                                  });
                                },
                                activeColor: Colors.blue,
                                inactiveThumbColor: Colors.blue,
                              ),
                            ));
                      },
                    );
                  },
                  child: Text('Notification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  widgetList(Text text, Icon icon2) {
    return ListTile(
      title: text,
      trailing: icon2,
    );
  }
}
