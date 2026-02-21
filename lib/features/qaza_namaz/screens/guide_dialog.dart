import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

class GuideDialog extends StatelessWidget {
  GuideDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // optional
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8, // limit height
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // ----- Fixed Title Bar -----
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Namaz Guide",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                )
              ],
            ),
          ),

          // ----- Scrollable Content Area -----
          Expanded( // <- now this works because height is bounded
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Text(
                'namaz_guide_details'.tr,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

          // ----- Fixed Bottom Close Button Bar -----
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: ()=>Get.back(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration:  BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Center(child: Text("close".tr,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w700,fontSize: 18),)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
