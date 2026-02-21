import 'dart:io';

import '../../../../interfaces/repository_interface.dart';
import 'package:get/get.dart';

abstract class CopetitionRepositoryInterface extends RepositoryInterface {
  Future<Response> getTaskList();
  Future<Response> getLeaderBoard();
  Future<Response> getWalletHistories();
  Future<Response> submitWithdrawRequest(File? imageFile,Map<String, String> body);
  Future<Response> submitTask(int taskId,{int? value});

}