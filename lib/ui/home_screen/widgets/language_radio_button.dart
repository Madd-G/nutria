import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/controller/language_controller.dart';

class LanguageRadioButton extends StatefulWidget {
  const LanguageRadioButton({
    super.key,
    required this.controller,
    required this.countryCode,
    required this.language,
  });

  final LanguageController controller;
  final String countryCode;
  final String language;

  @override
  State<LanguageRadioButton> createState() => _LanguageRadioButtonState();
}

class _LanguageRadioButtonState extends State<LanguageRadioButton> {
  String currentLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 4.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.language),
          GetBuilder<LanguageController>(builder: (languageContext) {
            return Radio(
              value: widget.language,
              groupValue: widget.controller.selectedLanguage,
              onChanged: (newValue) {
                widget.controller
                    .changeLanguage(widget.countryCode, widget.countryCode);
                widget.controller.selectedLanguage = widget.countryCode;
                widget.controller.setLanguage(newValue!);
                // dataStore.write("count", _count);
              },
              activeColor: Theme.of(context).colorScheme.primary,
            );
          }),
        ],
      ),
    );
  }
}
