import 'package:get/get.dart';

import '../../../../interfaces/repository_interface.dart';
import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';
import '../models/question_model.dart';

abstract class SawaljawabRepositoryInterface extends RepositoryInterface {
  Future<List<QuestionModel>> getQuetionData(int page);
  Future<Response> askQuestion(String question);


}