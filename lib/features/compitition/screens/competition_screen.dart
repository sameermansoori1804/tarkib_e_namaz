import 'package:flutter/material.dart';
import 'package:flutter_template/features/compitition/domain/models/competition_task.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../../common/widgets/showIslamicConfirmationDialog.dart';
import '../controller/CopetitionController.dart';
import 'leader_board_screen.dart';

class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({super.key});

  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {

  @override
  void initState() {
    super.initState();
    final controller = Get.find<CopetitionController>();
    controller.getTaskList();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<CopetitionController>(
        builder: (copetitionController){
          return Scaffold(
            backgroundColor: AppColor.lightBg,
            appBar: AppBar(
              backgroundColor: AppColor.primaryGreen,
              elevation: 4,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "islamic_competition".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:() =>  Get.toNamed(AppRoutes.getLeaderboardScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightgray,
                        border: Border.all(width: 2,color: AppColor.gold),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.leaderboard, color: AppColor.gold, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            "${copetitionController.myRank}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap:() =>  Get.toNamed(AppRoutes.getWalletScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightgray,
                        border: Border.all(width: 2,color: AppColor.gold),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monetization_on, color: AppColor.gold, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            "${copetitionController.myPoint}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            body: Column(
              children: [
                /// 🏆 REWARD NOTICE BANNER
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFD4AF37),
                        Color(0xFFFFE082),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top Row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.emoji_events, color: Colors.white, size: 32),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "competition_reward".tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "first_rank_prize".tr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(height: 1, color: Colors.white.withOpacity(0.4)),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          AppRoutes.getCompetitionRulesScreen(),
                          arguments: copetitionController.tasks,
                        ),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              "rules_button".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// TASK LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: copetitionController.tasks.length,
                    itemBuilder: (_, index) {
                      final task = copetitionController.tasks[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColor.primaryGreen, Color(0xFF127C63)],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.name,
                                  style: const TextStyle(
                                      color: AppColor.gold,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(task.description,
                                  style: const TextStyle(
                                      color: AppColor.gold,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text("${"points_text".tr}: ${task.point}",
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(height: 12),
                              task.type == "button"
                                  ? task.isCompleted
                                  ? Container(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("task_completed".tr,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              )
                                  : ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.gold),
                                  onPressed: (){
                                    showIslamicConfirmationDialog(
                                      context: context,
                                      title: "Apane task Complate Kar liya hain?",
                                      description: "Sahi jawab de, Allah sab janata hain",
                                      onYes: () {
                                        Get.back(); // close dialog
                                        copetitionController.submitTask(task.id);

                                      }
                                    );
                                  },
                                  child: Text("submit".tr,
                                      style: const TextStyle(color: Colors.black)))
                                  : ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.gold),
                                  onPressed: () {
                                    openInputDialog(task, context: context,onYes: (value) {
                                      Get.back(); // close dialog
                                      copetitionController.submitTask(task.id, value: value);

                                    });
                                  },
                                  child: Text("enter_submit".tr,
                                      style: const TextStyle(color: Colors.black))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}