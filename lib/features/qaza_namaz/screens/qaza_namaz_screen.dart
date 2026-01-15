import 'package:flutter/material.dart';
import 'package:flutter_template/features/qaza_namaz/controller/qaza_controller.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:get/get.dart';
import 'package:modern_dialog/modern_dialog.dart';

import 'guide_dialog.dart';

class QazaNamazScreen extends StatefulWidget {
  @override
  _QazaNamazScreenState createState() => _QazaNamazScreenState();
}

class _QazaNamazScreenState extends State<QazaNamazScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor, // Teal background
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: AppColor.white,
        ),
        title: Text(
          'Qaza Namaz',
          style: TextStyle(
            color: AppColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Image Section
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.namaz_banner), // Add your prayer image
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  GestureDetector(
                    onTap: (){
                      return  ModernDialog.showCustom(
                        context,
                        borderRadius: 10,
                        disablePadding: true,
                        dismissibleDialog: true,
                        //replace with your custom widget
                        view:  GuideDialog(),
                      );
                    },
                    child: Text(
                      'Guid Qaza Namaz',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Prayer Counter Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                child: GetBuilder<QazaController>(builder: (qazaController){
                  qazaController.loadInitialQazaData();
                  return Column(
                    children: [
                      // Prayer counters
                      _buildPrayerCounter("Fazr", qazaController.fazr,qazaController),
                      _buildPrayerCounter("Zuhar", qazaController.zuhar,qazaController),
                      _buildPrayerCounter("Asr", qazaController.asr,qazaController),
                      _buildPrayerCounter("Magrib", qazaController.magrib,qazaController),
                      _buildPrayerCounter("Isha", qazaController.isha,qazaController),

                      SizedBox(height: 20),

                      // Roza counter (separated)
                      _buildPrayerCounter("Roza", qazaController.roza,qazaController),


                      Spacer(),

                      // Bottom indicator
                      Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerCounter(String prayerName, int count, QazaController qazaController) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.primaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Prayer name
          Expanded(
            child: Text(
              prayerName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          // Counter controls
          Row(
            children: [
              // Minus button
              GestureDetector(
                onTap: ()=>qazaController.decrement(prayerName),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ),

              // Count display
              Container(
                width: 50,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Plus button
              GestureDetector(
                onTap: ()=>qazaController.increment(prayerName),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
