

import 'dart:async';

import 'package:flutter_template/features/sawal_jawab/domain/models/question_model.dart';
import 'package:flutter_template/features/sawal_jawab/domain/reposotories/sawaljawab_repository_interface.dart';
import 'package:flutter_template/features/sawal_jawab/domain/services/sawaljawab_services_interface.dart';
import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services_interface.dart';
import 'package:get/get.dart';

import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';


class SawaljawabServices implements SawaljawabServicesInterface{

  final SawaljawabRepositoryInterface sawaljawabRepositoryInterface;

  SawaljawabServices({required this.sawaljawabRepositoryInterface});

  @override
  Future<Response> getQuetionData(int page) async{
    // TODO: implement getQuetionData
    return await sawaljawabRepositoryInterface.getQuetionData(page);
  }

  @override
  Future<Response> askQuestion(String question)async {
    // TODO: implement askQuestion
    return await sawaljawabRepositoryInterface.askQuestion(question);  }



}