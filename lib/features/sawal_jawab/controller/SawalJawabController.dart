import 'package:flutter/material.dart';
import 'package:flutter_template/features/sawal_jawab/domain/models/question_model.dart';
import 'package:flutter_template/features/sawal_jawab/domain/services/sawaljawab_services_interface.dart';
import 'package:get/get.dart';

class Sawaljawabcontroller extends GetxController implements GetxService {
  final SawaljawabServicesInterface sawaljawabServicesInterface;

  Sawaljawabcontroller({required this.sawaljawabServicesInterface});

  final ScrollController scrollController = ScrollController();

  int _page = 0;
  int get page => _page;
  bool _isLoading = false;
  bool get isLoading =>  _isLoading;
  bool _hasMore = true;
  bool get hasMore =>  _hasMore;

  List<QuestionModel>  _questionList = [];
  List<QuestionModel> get questionList => _questionList;
  List<QuestionModel>  _myQuestionList = [];
  List<QuestionModel> get myQuestionList => _myQuestionList;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        fetchQuestions();
      }
    });
  }


  Future<void> askQuestion(String quetions) async {
    Response response = await sawaljawabServicesInterface.askQuestion(quetions);
    _questionList.clear();
    _page = 0;
    fetchQuestions();
  }



  Future<void> fetchQuestions() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    update();

    try {
      Response response =
      await sawaljawabServicesInterface.getQuetionData(_page);

      if (response.statusCode == 200) {

        List<dynamic> allData =
            response.body['all_quetions'] ?? [];

        List<dynamic> myData =
            response.body['my_quetions'] ?? [];

        if (allData.isEmpty) {
          _hasMore = false;
        } else {

          // 🔥 Parse All Questions
          List<QuestionModel> allList = allData
              .map((e) => QuestionModel.fromJson(e))
              .toList();

          // 🔥 Parse My Questions
          List<QuestionModel> myList = myData
              .map((e) => QuestionModel.fromJson(e))
              .toList();

          _questionList.addAll(allList);
          _myQuestionList.addAll(myList);

          _page++;
        }
      }
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    update();
  }




}