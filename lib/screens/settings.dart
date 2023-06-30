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
                              'Terms and Conditions \n \n Please read these Terms and Conditions ("Terms") carefully before using our music app. By accessing or using the app, you agree to be bound by these Terms and our Privacy Policy. If you do not agree to these Terms, you may not use the app\n ownership \n \n Ownership: All intellectual property rights in the app, including but not limited to copyrights, trademarks, and trade secrets, are owned by us or our licensors. You acknowledge that you have no right, title, or interest in the app or its content except as expressly provided in these terms'),
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
                        return SingleChildScrollView(
                          child: AlertDialog(
                            backgroundColor: Color.fromARGB(255, 215, 215, 215),
                            title: Text('Privacy Policy'),
                            content: const Text(
                                "Privacy Policy\n \n This privacy policy describes how we collect, use, store, and disclose information when you use our music app. By using the app, you agree to the collection and use of your information as described in this privacy policy. \n \n Information that we collect\n \n 1.1 Personal Information: We may collect personal information that you provide to us, such as your name, email address, and profile picture when you create an account or interact with certain features of the app \n \n 1.2 Usage Information: We automatically collect certain information about your device and usage of the app, including IP address, device type, operating system, app version, and usage statistics. This information is used to analyze trends, administer the app, track user movements, and gather demographic information for aggregate use  \n \n Use of information \n \n  2.1 Personal Information: We may use your personal information to provide and personalize the apps features and content, communicate with you, and improve our services. We may also use your information to send you promotional emails or updates about the app, but you can opt out of receiving such communications \n \n Data storage and security \n\n Data Storage: Your information, including personal and usage data, may be stored on servers located in different countries. By using the app, you consent to the transfer of your information to these servers \n \n CONTACT US \n\n if you have questions and conserns , or suggestions regarding the privacy policy or my app's privacy practices please contact us at jaswanthkriz@gmail.com"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'))
                            ],
                          ),
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
                          title: Text('About'),
                          content: const Text(
                              'Musique is an offline music player app which allows to hear music from their storage and also do functions like add to favorite, create playlist , recently played and mostly played, etc. \n \n App developed by \n JASWANTH HARIKIRSHNA'),
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
