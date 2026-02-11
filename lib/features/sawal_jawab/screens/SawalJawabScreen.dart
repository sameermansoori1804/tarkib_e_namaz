import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_template/features/sawal_jawab/controller/SawalJawabController.dart';

class Sawaljawabscreen extends StatefulWidget {
  const Sawaljawabscreen({super.key});

  @override
  State<Sawaljawabscreen> createState() => _SawaljawabscreenState();
}

class _SawaljawabscreenState extends State<Sawaljawabscreen> {


  @override
  void initState() {
    super.initState();
    final controller = Get.find<Sawaljawabcontroller>();
    controller.fetchQuestions(); // load next page
    // 🔥 scroll listener

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sawal Jawab')),

      body: GetBuilder<Sawaljawabcontroller>(
        builder: (c) {
          return ListView.builder(
            controller: c.scrollController,
            itemCount: c.questionList.length + 1,
            itemBuilder: (context, index) {

              if (index == c.questionList.length) {
                return c.hasMore
                    ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox();
              }

              var item = c.questionList[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.question}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("• ${item.answer}")
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // 🔥 FLOATING BUTTON
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _openAskQuestionSheet();
        },
        icon: const Icon(Icons.edit),
        label: const Text("Ask Question"),
      ),
    );

  }

  void _openAskQuestionSheet() {
    final TextEditingController questionController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Ask a Question",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: questionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Type your question...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (questionController.text.trim().isEmpty) return;

                  final controller = Get.find<Sawaljawabcontroller>();

                  await controller.askQuestion(questionController.text);

                  Get.back(); // close sheet
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

}
