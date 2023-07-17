import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../responsive.dart';
import '../../../utils/controller/language_controller.dart';
import '../widgets/language_radio_button.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LanguageController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Change Language'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isTablet(context) ? 20.0 : 18.0),
          ),
        ),
        Column(
          children: [
            LanguageRadioButton(
              controller: controller,
              countryCode: 'en_US',
              language: 'English',
            ),
            LanguageRadioButton(
                controller: controller,
                countryCode: 'id_ID',
                language: 'Indonesia'),
          ],
        ),
      ],
    );
  }
}
