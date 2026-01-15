import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/tasbih/controller/tasbih_controller.dart';
import 'package:get/get.dart';

import '../../../utils/images.dart';
import '../../common/screens/sagment_circular_progress.dart';
import '../../tasbih/domain/models/read_tasbihs.dart';

class TasbihCounterScreen extends StatefulWidget {
  final ReadTasbih readTasbih;

  TasbihCounterScreen({Key? key})
      : readTasbih = Get.arguments is ReadTasbih
      ? Get.arguments
      : ReadTasbih(
    count: 0,
    round: 0,
    tasbih_id: 0,
    target: 33,
  ),
        super(key: key);

  @override
  State<TasbihCounterScreen> createState() => _TasbihCounterScreenState();
}

class _TasbihCounterScreenState extends State<TasbihCounterScreen> {
  late int currentCount;

  @override
  void initState() {
    super.initState();
    final tasbihController = Get.find<TasbihController>();
    tasbihController.loadInitialTasbihData(widget.readTasbih);
    currentCount = widget.readTasbih.count;
  }








  @override
  Widget build(BuildContext context) {
    double progress = widget.readTasbih.target > 0
        ? (currentCount / widget.readTasbih.target).clamp(0.0, 1.0)
        : (currentCount % 33) / 33;
    final safeTarget = widget.readTasbih.target == 0 ? 33 : widget.readTasbih.target;

    return GetBuilder<TasbihController>(builder: (tasbihController){

      return  Scaffold(
        appBar: AppBar(
          title: Text('Tasbih'),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
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
                    tasbihController.reset();
                  },
                ).show();
              },
            ),
          ],
        ),
        body: InkWell(
          onTap: tasbihController.increament,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Counter and Tasbih Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      label: Center(child: Text('${tasbihController.currentRound}', style: TextStyle(fontSize: 20))),
                      backgroundColor: Colors.teal,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Flexible(  // <-- Wrap with Flexible to constrain width and allow wrapping
                      child: Text(
                        widget.readTasbih.tasbih?.title ?? "Untitled",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: SegmentedCircularProgress(
                      current: (tasbihController.currentCount % safeTarget).toDouble(),
                      totalSegments: safeTarget,
                    ),
                  ),
                ],
              ),

              Image.asset(
                Images.click_hand,
                width: 70,
                height: 70,
              )
            ],
          ),
        ),
      );
    });
  }
}
