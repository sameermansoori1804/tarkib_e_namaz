import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/home/domain/models/tasbih_model.dart';
import 'package:flutter_template/features/tasbih/controller/tasbih_controller.dart';
import 'package:flutter_template/features/tasbih/domain/models/read_tasbihs.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../route/routes.dart';
import '../../splash/controller/splash_controller.dart';

class TasbihScreen extends StatefulWidget {
  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {


  @override
  void initState() {
    super.initState();
    final tasbihController = Get.find<TasbihController>();
    tasbihController.loadTasbihs();
    tasbihController.loadReadTasbihs();


  }

  void showAddDialog(BuildContext context, TasbihController tasbihController) {
    // Use tasbih titles from controller or fallback to empty list
    final tasbihList = tasbihController.tasbihs ?? [];
    String? selectedZikr = tasbihList.isNotEmpty ? tasbihList.first.title : null;

    TextEditingController targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Add New Tasbih',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Zikr Selection
            Text(
              'Select Zikr',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.darkgray),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                child: DropdownButtonFormField<String>(
                  value: selectedZikr,
                  isExpanded: true, // Ensures the dropdown uses max available width
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  hint: Text('Choose your Zikr'),
                  items: tasbihList.map((tasbih) {
                    return DropdownMenuItem<String>(
                      value: tasbih.title ?? 'No Title',
                      child: Text(
                        tasbih.title ?? 'No Title',
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    selectedZikr = val;
                  },
                ),
              ),

            ),

            SizedBox(height: 16),

            // Target Count
            Text(
              'Target Count (Optional)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter target count',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color:  AppColor.darkgray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color:  AppColor.darkgray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color:  AppColor.primaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (selectedZikr != null) {
                int target = int.tryParse(targetController.text) ?? 0;
                final selectedTasbih = tasbihList.firstWhere(
                      (t) => t.title == selectedZikr,
                  orElse: () => tasbihList.first,
                );

                final readTasbih = ReadTasbih(
                  user_id: null,
                  tasbih_id: selectedTasbih.id ?? 0,
                  count: 0,
                  round: 0,
                  target: target,
                  status: 1,
                  insert_id: null,
                  created_at: DateTime.now().toIso8601String(),
                  updated_at: DateTime.now().toIso8601String(),
                );

                await tasbihController.addReadTasbih(readTasbih);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TasbihController>(
      builder: (tasbihController) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tasbih',style: TextStyle(color: AppColor.white),),
            backgroundColor: AppColor.primaryColor,
            iconTheme: IconThemeData(color: Colors.white),

          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child:
                      tasbihController.readTasbihs!.isEmpty
                          ? Center(
                            child: Text('No Tasbihs yet. Tap + to add one.'),
                          )
                          : ListView.builder(
                            itemCount: tasbihController.readTasbihs!.length,
                            itemBuilder: (context, index) {
                              ReadTasbih item =
                                  tasbihController.readTasbihs![index];
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: InkWell(
                                  onTap:
                                      () async{
                                        await  Get.toNamed(
                                          AppRoutes.getTasbihCounterScreen(),
                                          arguments: item, // 👈 your ReadTasbih object
                                        );


                                        tasbihController.loadReadTasbihs();
                                      },
                                  child: ListTile(
                                    title: Text(item.tasbih!.title ?? ""),
                                    subtitle: Text(
                                      'Count: ${item.count}/${item.target}',
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.refresh),
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              headerAnimationLoop: false,
                                              animType: AnimType.bottomSlide,
                                              showCloseIcon: true,
                                              closeIcon: const Icon(Icons.close_fullscreen_outlined),
                                              title: 'Warning',
                                              desc: 'Do You Want to Reset This Tasbih?',
                                              btnCancelOnPress: () {

                                              },
                                              onDismissCallback: (type) {
                                                debugPrint('Dialog Dismiss from callback $type');
                                              },
                                              btnOkOnPress: () {
                                                tasbihController.reset(tasbihId: item.id);
                                              },
                                            ).show();
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {

                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              headerAnimationLoop: false,
                                              animType: AnimType.bottomSlide,
                                              showCloseIcon: true,
                                              closeIcon: const Icon(Icons.close_fullscreen_outlined),
                                              title: 'Warning',
                                              desc: 'Do You Want to Delete This Tasbih?',
                                              btnCancelOnPress: () {

                                              },
                                              onDismissCallback: (type) {
                                                debugPrint('Dialog Dismiss from callback $type');
                                              },
                                              btnOkOnPress: () {
                                                tasbihController.deleteReadTasbih(item.id ?? 0);
                                              },
                                            ).show();

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:AppColor.primaryColor,
            onPressed: () => showAddDialog(context,tasbihController),

            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
