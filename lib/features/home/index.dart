import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:inventi/common/constants/appcolor.dart';
import 'package:inventi/data/models/user_model.dart';
import 'package:inventi/data/repositories/firebase_repo.dart';
import 'package:inventi/data/services/firebase_auth.dart';
import 'package:inventi/data/services/firestore_service.dart';
import 'package:inventi/features/auth/screens/additional_info.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  final imageUrls = [
    "https://images.pexels.com/photos/186537/pexels-photo-186537.jpeg",
    "https://images.pexels.com/photos/1058277/pexels-photo-1058277.jpeg",
    "https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg",
    "https://images.pexels.com/photos/1486222/pexels-photo-1486222.jpeg",
    "https://images.pexels.com/photos/757432/pexels-photo-757432.jpeg",
  ];

  final AuthRepository authRepository =
      AuthRepository(FirebaseAuthService(), FirestoreService());

  UserModel? userModel;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      authRepository.getCurrentUserData().then((userData) {
        setState(() {
          userModel = userData;
          isLoading = false;
        });
        if (userData != null && userData.userType == null) {
          inspect(userData);
          Get.to(() => const AdditionalInfoScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  subtitle: Text(
                      'User type: ${userModel?.userType ?? 'Not available'}'),
                  title: Text('Welcome, ${userModel?.firstName ?? 'User'}'),
                ),
                IconButton(
                    onPressed: () => authRepository.signOut(),
                    icon: const Icon(Icons.logout))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            if (isLoading) const LinearProgressIndicator(),
            StreamBuilder(
              stream: authRepository.streamLocations,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No locations available.'));
                } else {
                  final locations = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      imageUrls[index %
                                          imageUrls
                                              .length], // rotate images for demo
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        height: 180,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image,
                                            size: 60),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 72,
                                          ),
                                          onPressed: () {}),
                                    )
                                  ],
                                ),
                              ),

                              // Info section
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Icon(Icons.location_on,
                                            color: AppColors.primary),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            location.location ?? 'No Address',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: Get.width,
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              children: [
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Icon(Icons.person,
                                                        color:
                                                            AppColors.primary,
                                                        size: 16),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        '${location.currentNumberOfPeople ?? 'N/A'}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              CupertinoIcons
                                                                  .trash,
                                                              color: AppColors
                                                                  .success,
                                                              size: 16),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              '${location.currentGarbage ?? 'N/A'}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Lottie.asset(
                                                  'assets/animations/live2.json',
                                                  width: 100,
                                                  height: 50,
                                                  fit: BoxFit.fill,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Text(
                                    //   'People: ${location.currentNumberOfPeople}, Garbage: ${location.currentGarbage ?? 'N/A'}',
                                    //   style: TextStyle(color: Colors.grey[700]),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ]),
        ));
  }
}
