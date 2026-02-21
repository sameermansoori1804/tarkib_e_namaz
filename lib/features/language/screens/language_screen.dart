
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../../../route/routes_name.dart';
import '../../../utils/AppConstants.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../../common/widgets/custom_asset_image_widget.dart';
import '../../common/widgets/custom_button_widget.dart';
import '../../common/widgets/custom_snackbar_widget.dart';
import '../../splash/controller/splash_controller.dart';
import '../controller/language_controller.dart';
import '../widgets/language_card_widget.dart';

class LanguageScreen extends StatelessWidget {
  final bool fromMenu;
  const LanguageScreen({super.key, required this.fromMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<LocalizationController>(builder: (localizationController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 40),

           const Align(
            alignment: Alignment.center,
            child: CustomAssetImageWidget(
              Images.languageBg,
              height: 210, width: 210,
              fit: BoxFit.contain,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text('choose_your_language'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text('choose_your_language_to_proceed'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: localizationController.languages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                itemBuilder: (context, index) {
                  return LanguageCardWidget(
                    languageModel: localizationController.languages[index],
                    localizationController: localizationController,
                    index: index,
                  );
                },
              ),
            ),
          ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeExtraLarge),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), blurRadius: 10, spreadRadius: 0)],
              ),
              child: CustomButtonWidget(
                buttonText: fromMenu?'submit'.tr: 'next'.tr  ,
                color: AppColor.primaryColor,
                onPressed: () {
                  if(localizationController.languages.isNotEmpty && localizationController.selectedLanguageIndex != -1) {
                    localizationController.setLanguage(Locale(
                      AppConstants.languages[localizationController.selectedLanguageIndex].languageCode!,
                      AppConstants.languages[localizationController.selectedLanguageIndex].countryCode,
                    ));

                    if(fromMenu){
                      Get.back();
                    }else{
                      Get.offAllNamed(RouteName.homeView);

                    }
                    showCustomSnackBar('change_your_language'.tr,isError: false);
                  }
                },
              ),
            ),
          ),

        ]);
      }),
    );
  }
}