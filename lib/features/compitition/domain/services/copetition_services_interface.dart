
import 'dart:io';

import 'package:get/get.dart';

abstract class CopetitionServiceInterface {
  Future<Response> getTaskList();
  Future<Response> getLeaderBoard();
  Future<Response> getWalletHistories();
  Future<Response> submitWithdrawRequest(File? imageFile,Map<String, String> body);
  Future<Response> submitTask(int taskId,{int? value});


}