import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/features/quraan/domain/models/Quraan.dart';
import 'package:get/get.dart';

import '../../../route/routes.dart';
import '../domain/models/ParaItem.dart';
import 'card.dart';

class ParaScreen extends StatefulWidget {
  const ParaScreen({super.key});

  @override
  State<ParaScreen> createState() => _ParaScreenState();
}

class _ParaScreenState extends State<ParaScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  List<Quraan> paraData = [];
  void initData() async {
    try {
      final String jsonStringValues = await rootBundle.loadString('assets/quraan/para.json');
      final List<dynamic> jsonList = jsonDecode(jsonStringValues);

      setState(() {
        paraData = jsonList.map((json) => Quraan.fromJson(json)).toList();
      });

    } catch (e) {

    }

  }
  //
  // final List<ParaItem> paraData = [
  //   ParaItem(number: 1, arabicName: "الم", totalRukus: 17),
  //   ParaItem(number: 2, arabicName: "سَیَقُولُ", totalRukus: 16),
  //   ParaItem(number: 3, arabicName: "تِلْكَ الرُّسُلُ", totalRukus: 17),
  //   ParaItem(number: 4, arabicName: "لَن تَنَالُوا", totalRukus: 14),
  //   ParaItem(number: 5, arabicName: "وَالْمُحْصَنَاتُ", totalRukus: 17),
  //   ParaItem(number: 6, arabicName: "لَا یُحِبُّ اللہُ", totalRukus: 14),
  // ];
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
    print('p${item.pageStart!}');
    print('p${item.pageEnd!}');
    print("altaf---");
    Get.toNamed(AppRoutes.getQuraanPageScreen('p${item.pageStart!}','p${item.pageEnd!}','${item.name}')); // Replace with your HomeScreen route

    print("Selected Para: ${item.id} - ${item.name}");
    // Navigate to Quran reading page
  }

}
