// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_pad/Screens/about_screen.dart';
import 'package:travel_pad/Screens/login_signup_screen.dart';
import 'package:travel_pad/Screens/scheduled_trips_screen.dart';
import 'package:travel_pad/db/db_functions/profile_db_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> attemptLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignupScreen()),
        (route) => false);
  }

  String name = '';
  String profileImage = '';
  userInitializing() async {
    var obj = await getUserProfile();
    if (obj.profilePicture.isNotEmpty && obj.userName.isNotEmpty) {
      setState(() {
        name = obj.userName;
      });
      setState(() {
        profileImage = obj.profilePicture;
      });
    }
  }

  @override
  void initState() {
    userInitializing();
    super.initState();
  }

  var userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.teal.shade700,
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                height: 550,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                                image: profileImage.isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(File(profileImage)),
                                        fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage(
                                            "lib/assets/Hodophile-2.jpg"),
                                        fit: BoxFit.cover)),
                          ),
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedfile = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedfile != null) {
                              await editUserImage(pickedfile.path);
                              var obj = await getUserProfile();
                              setState(() {
                                profileImage = obj.profilePicture;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            name.isEmpty ? 'user' : name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            userNameController.text = name;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextFormField(controller: userNameController),
                                  TextButton(
                                      onPressed: () async {
                                        if (userNameController
                                            .text.isNotEmpty) {
                                          await editUserName(
                                              userNameController.text);
                                          var obj = await getUserProfile();
                                          setState(() {
                                            name = obj.userName;
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text("update")),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 178, 177, 177),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.flight),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScheduledTripsScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Your scheduled trips',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'About',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.share),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            _onShare(context);
                          },
                          child: const Text(
                            'Share',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () async {
                            attemptLogout();
                          },
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

_onShare(context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
      'https://play.google.com/store/apps/details?id=in.hareesh.travel_pad',
      subject: '',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
