import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_template/features/sawal_jawab/controller/SawalJawabController.dart';

class Sawaljawabscreen extends StatefulWidget {
  const Sawaljawabscreen({super.key});

  @override
  State<Sawaljawabscreen> createState() => _SawaljawabscreenState();
}

class _SawaljawabscreenState extends State<Sawaljawabscreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final controller = Get.find<Sawaljawabcontroller>();
    controller.fetchQuestions();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0C6E4F),
        title: Row(
          children: const [
            Text("Sawal & Jawab"),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.white, // 🔥 Selected tab text color
          unselectedLabelColor: Colors.white70,  // 🔥 Unselected tab text color
          tabs: [
            Tab(text: "all_questions".tr,),
            Tab(text: "my_questions".tr),
          ],
        ),
      ),

      body: GetBuilder<Sawaljawabcontroller>(
        builder: (c) {
          return TabBarView(
            controller: _tabController,
            children: [

              /// 🔹 ALL QUESTIONS TAB
              _buildQuestionList(c.questionList, c),

              /// 🔹 MY QUESTIONS TAB
              _buildQuestionList(c.myQuestionList, c, isMine: true),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF0C6E4F),
        onPressed: () {
          _openAskQuestionSheet();
        },
        icon: const Icon(Icons.edit,color: Colors.white,),
        label: Text("ask_question".tr,style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget _buildQuestionList(List list, Sawaljawabcontroller c,
      {bool isMine = false}) {
    if (list.isEmpty) {
      return Center(
        child: Text(
          isMine ? "no_my_questions".tr : "no_questions".tr,
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: c.scrollController,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF0C6E4F), width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🌙 Question
                Row(
                  children: [
                    const Icon(Icons.help_outline,
                        color: Color(0xFF0C6E4F)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.question ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// 🕌 Answer
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF6F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.answer ?? "awaiting_answer".tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openAskQuestionSheet() {
    final TextEditingController questionController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mosque,
                color: Color(0xFF0C6E4F), size: 40),

            const SizedBox(height: 10),

            Text(
              "ask_a_question".tr,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: questionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "type_your_question".tr,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C6E4F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (questionController.text.trim().isEmpty) return;

                  final controller =
                  Get.find<Sawaljawabcontroller>();

                  await controller
                      .askQuestion(questionController.text);

                  Get.back();
                },
                child: Text("submit".tr,style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}