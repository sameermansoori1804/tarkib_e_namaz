import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/features/quraan/domain/models/Quraan.dart';
import 'package:get/get.dart';

import '../../../route/routes.dart';
import '../domain/models/ParaItem.dart';
import 'card.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  List<Quraan> paraData = [];
  void initData() async {
    try {
      final String jsonStringValues = await rootBundle.loadString('assets/quraan/surah.json');
      final List<dynamic> jsonList = jsonDecode(jsonStringValues);

      setState(() {
        paraData = jsonList.map((json) => Quraan.fromJson(json)).toList();
      });

    } catch (e) {

    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: paraData.length,
        itemBuilder: (context, index) {
          return IslamicCard(
            itemData: paraData[index],
            onTap: () => _onParaSelected(paraData[index]),
          );
        },
      ),
    );
  }


  void _onParaSelected(Quraan item) {
    Get.toNamed(AppRoutes.getQuraanPageScreen('p${item.pageStart!}','p${item.pageEnd!}','${item.name}')); // Replace with your HomeScreen route
  }

}
