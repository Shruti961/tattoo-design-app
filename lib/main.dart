import 'package:art_box/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ai_generator_screen.dart';
import 'customer_support_screen.dart';
import 'design_viewer_screen.dart';
import 'membership_screen.dart';
import 'updates_screen.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Artbox By Shruti',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 69, 175, 228),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        child: LoginScreen(), // Start with the login screen
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> featuredDesigns = [
    'asset/images/3D.jpg',
    'asset/images/abstract.jpg',
    'asset/images/CUSTOM script.jpeg',
    'asset/images/dotwork.webp',
    'asset/images/japanese copy.jpeg',
    'asset/images/minimalist.jpg',
    'asset/images/neo traditional.jpg',
    'asset/images/watercolor.jpg',
    'asset/images/tattoo1.jpeg',
    'asset/images/tattoo2.jpeg',
    'asset/images/tattoo3.jpeg',
    'asset/images/tattoo4.jpeg',
    'asset/images/tattoo5.jpeg',
    'asset/images/tattoo6.jpeg',
    'asset/images/tattoo7.jpeg',
    'asset/images/tattoo8.jpeg',
  ];

  HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Image.asset(
              'asset/images/homescreen.jpeg',
              fit: BoxFit.cover,
              height: 3000,
              width: 2000,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Artbox By Shruti',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 232, 235, 236),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.bars),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              AIGeneratorScreen()),
                                    );
                                  },
                                  child: const Text('AI Generator'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              MembershipScreen()),
                                    );
                                  },
                                  child: const Text('Membership'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              DesignViewerScreen()),
                                    );
                                  },
                                  child: const Text('View Design'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              CustomerSupportScreen()),
                                    );
                                  },
                                  child: const Text('Customer Support'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              UpdatesScreen()),
                                    );
                                  },
                                  child: const Text('Updates'),
                                ),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          placeholder: 'Search for tattoo designs using AI generator',
                          prefix: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(CupertinoIcons.search),
                          ),
                          onSubmitted: (query) {
                            // Handle search action
                          },
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.paperplane_fill),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AIGeneratorScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Featured Designs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 236, 236),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: featuredDesigns.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.amber,
                            image: DecorationImage(
                              image: AssetImage(featuredDesigns[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
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
