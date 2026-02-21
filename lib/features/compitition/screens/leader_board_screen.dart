import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../controller/CopetitionController.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<CopetitionController>();
    controller.getLeaderBoardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBg,
      appBar: AppBar(
        backgroundColor: AppColor.primaryGreen,
        iconTheme: const IconThemeData(
          color: Colors.white, // 👈 Back icon color
        ),
        title: Text("leaderboard_title".tr,
            style: const TextStyle(color: Colors.white)),
      ),
      body: GetBuilder<CopetitionController>(
        id: 'leaderboard',
        builder: (copetitionController) {
          return copetitionController.isLeaderLoading
              ? const SizedBox()
              : Column(
            children: [
              /// MY RANK CARD
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.gold,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${"my_rank".tr}: ${copetitionController.myData?.rank ?? '-'}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${"points_text".tr}: ${copetitionController.myData?.points ?? '-'}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              /// LIST
              Expanded(
                child: ListView.builder(
                  itemCount: copetitionController.leaders.length,
                  itemBuilder: (_, index) {
                    final user = copetitionController.leaders[index];
                    int rank = index + 1;
                    bool isMe = user.itsMe;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? AppColor.primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#$rank",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            user.name,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "${user.points}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}