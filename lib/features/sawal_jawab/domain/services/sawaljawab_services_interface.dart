import 'package:flutter_template/features/home/domain/models/prayer_data.dart';
import 'package:flutter_template/features/sawal_jawab/domain/models/question_model.dart';
import 'package:get/get.dart';

import '../../../home/domain/models/home_data.dart';

abstract class SawaljawabServicesInterface {

  Future<Response> getQuetionData(int page);
  Future<Response> askQuestion(String question);

}