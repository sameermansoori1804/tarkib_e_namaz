import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/ads/controller/ads_controller.dart';
import 'package:flutter_template/features/auth/domain/models/user.dart';
import 'package:flutter_template/features/common/screens/home_image_slider.dart';
import 'package:flutter_template/features/home/domain/models/home_data.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/controller/location_controller.dart';
import '../../common/widgets/custom_snackbar_widget.dart';
import '../../home/domain/models/categories_model.dart';
import '../../home/domain/models/home_slider.dart';
import '../../home/domain/models/post_model.dart';
import '../../home/domain/models/prayer_data.dart';
import '../../home/domain/models/tasbih_model.dart';
import '../../tasbih/controller/tasbih_controller.dart';
import '../domain/models/competition_task.dart';
import '../domain/models/leader_board_model.dart';
import '../domain/models/wallet_history_model.dart';
import '../domain/services/copetition_services_interface.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class CopetitionController extends GetxController implements GetxService {
  final CopetitionServiceInterface copetitionServiceInterface;

  CopetitionController({required this.copetitionServiceInterface});

  List<CompetitionTask> _tasks = [];
  List<CompetitionTask> get tasks => _tasks;


  int _myRank = 0;
  int get myRank => _myRank;
  String _myPoint = "0";
  String get myPoint => _myPoint;

  void submitTask(int taskId, {int? value}) async{
    showIslamicLoadingDialog();

    Response response = await copetitionServiceInterface.submitTask(taskId,value: value);
    hideLoadingDialog();
    if(response.isOk){
      if(response.body['status'] == true){
        getTaskList();
        showCustomSnackBar(response.body['message'],isError: false);
        Get.find<AdsController>().loadInterstitialAd();
      }else{
        showCustomSnackBar(response.body['message']);
      }
    }
  }


  bool isLoading = false;

  Future<void> getTaskList() async {
    try {
      isLoading = true;
      update(); // refresh UI

      Response response = await copetitionServiceInterface.getTaskList();

      if (response.statusCode == 200) {
        _myPoint = response.body['total_points'].toString();
        _myRank = response.body['rank'];
        _tasks = (response.body['tasks'] as List)
            .map((e) => CompetitionTask.fromJson(e))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to load tasks");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update(); // refresh UI again
    }
  }




  bool isLeaderLoading = false;

  List<LeaderBoardModel> _leaders = [];
  List<LeaderBoardModel> get leaders => _leaders;

  LeaderBoardModel? _myData;
  LeaderBoardModel? get myData => _myData;

  Future<void> getLeaderBoardList() async {
    try {
      isLeaderLoading = true;
      update(['leaderboard']); // ✅ targeted update
      Response response =
      await copetitionServiceInterface.getLeaderBoard();

      if (response.statusCode == 200) {

        // ✅ Parse leaderboard list
        _leaders = (response.body['leaderboard'] as List)
            .map((e) => LeaderBoardModel.fromJson(e))
            .toList();

        // ✅ Parse my_data
        if (response.body['my_data'] != null) {
          _myData = LeaderBoardModel.fromJson(response.body['my_data']);
        } else {
          _myData = null;
        }

      } else {
        Get.snackbar("Error", "Failed to load leaderboard");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLeaderLoading = false;
      update(['leaderboard']); // ✅ targeted update
    }
  }






  bool isWalletLoading = false;

  List<WalletHistoryModel> _walletHistories = [];
  List<WalletHistoryModel> get walletHistories => _walletHistories;

  UserModel? _user;
  UserModel? get user => _user;

  Future<void> getWalletHistoryList() async {
    try {
      isLeaderLoading = true;
      update(['wallet-history']); // ✅ targeted update
      Response response =
      await copetitionServiceInterface.getWalletHistories();

      if (response.statusCode == 200) {
        // ✅ Parse leaderboard list
        _walletHistories = (response.body['histories'] as List)
            .map((e) => WalletHistoryModel.fromJson(e))
            .toList();

        // ✅ Parse my_data
        if (response.body['user'] != null) {
          _user = UserModel.fromJson(response.body['user']);
        } else {
          _user = null;
        }

      } else {
        Get.snackbar("Error", "Failed to load leaderboard");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLeaderLoading = false;
      update(['wallet-history']); // ✅ targeted update
    }
  }

   final TextEditingController amountController = TextEditingController();
   final TextEditingController upiController = TextEditingController();
  File? _qrImage;
  File? get qrImage =>_qrImage;

  Future<void> pickQRImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      _qrImage = File(picked.path);
      update();
    }
  }

  void submitWithdraw() async {
    double amount = double.tryParse(amountController.text) ?? 0;

    if (amount <= 0) {
      Get.snackbar("Error", "Enter valid amount");
      return;
    }

    if (amount < 10) {
      Get.snackbar("Error",
          "Minimum withdraw is ₹10");
      return;
    }

    if (amount > double.parse(user?.balance ?? "0")) {
      Get.snackbar("Error", "Insufficient balance");
      return;
    }

    if (upiController.text.trim().isEmpty && qrImage == null) {
      Get.snackbar(
        "Error",
        "Please enter UPI ID or upload QR Screenshot",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 🔥 API Call Here
    Map<String, String> body = {
      'upi_id': upiController.text,
      'amount': amountController.text,
    };
    Response response = await copetitionServiceInterface.submitWithdrawRequest(qrImage, body);
    if (response.body['status']) {
      print(response.body);
    }
    upiController.text = "";
    amountController.text = "";
    _qrImage = null;
    update();
    Get.snackbar("Success", "Withdraw request submitted successfully");
  }


}