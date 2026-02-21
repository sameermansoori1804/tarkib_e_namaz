
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';

import '../../../utils/AppConstants.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../controller/language_controller.dart';
import '../domain/models/LanguageModel.dart';

class LanguageCardWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final bool fromBottomSheet;
  final bool fromWeb;
  const LanguageCardWidget({super.key, required this.languageModel, required this.localizationController, required this.index, this.fromBottomSheet = false, this.fromWeb = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
      onTap: () {
        if(fromBottomSheet){
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode!,
            AppConstants.languages[index].countryCode,
          ), fromBottomSheet: fromBottomSheet);
        }
        localizationController.setSelectLanguageIndex(index);
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        decoration: !fromWeb ? BoxDecoration(
          color: localizationController.selectedLanguageIndex == index ? AppColor.primaryColor.withValues(alpha: 0.05) : null,
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          border: localizationController.selectedLanguageIndex == index ? Border.all(color: AppColor.primaryColor.withValues(alpha: 0.2)) : null,
        ) : BoxDecoration(
          color: localizationController.selectedLanguageIndex == index ?AppColor.primaryColor.withValues(alpha: 0.05) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          border: Border.all(color: localizationController.selectedLanguageIndex == index ? AppColor.primaryColor.withValues(alpha: 0.2) : Theme.of(context).disabledColor.withValues(alpha: 0.3)),
        ),
        child: Row(children: [

          Image.asset(languageModel.imageUrl!, width: 36, height: 36),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Text(languageModel.languageName!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
          const Spacer(),

          localizationController.selectedLanguageIndex == index ? Icon(Icons.check_circle, color:AppColor.primaryColor, size: 25) : const SizedBox(),

        ]),
      ),
    );
  }
}