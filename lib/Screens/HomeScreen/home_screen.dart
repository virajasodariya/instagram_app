import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final String currentUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  DocumentReference? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user =
        FirebaseFirestore.instance.collection('User').doc(widget.currentUser);
  }

  List appBar = [
    'assets/icons/instagram-post.png',
    'assets/icons/heart.png',
    'assets/icons/send.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          SizedBox(width: 5.w),
          Image.asset(
            'assets/images/instagram name black color.png',
          ),
          const Spacer(),
          Row(
            children: List.generate(
              appBar.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Image.asset(
                  appBar[index],
                  scale: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 9.h,
                      width: 9.h,
                      margin: EdgeInsets.symmetric(horizontal: 0.5.h),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    const Text(
                      "ABED",
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return index == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 9.h,
                                width: 9.h,
                                margin: EdgeInsets.symmetric(horizontal: 0.5.h),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                bottom: 3.h,
                                right: 3.h,
                                child: Container(
                                  height: 3.h,
                                  width: 3.h,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Your story",
                          ),
                        ],
                      )
                    : const SizedBox();
              },
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
