import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/language_bloc/language_bloc.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../language.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20.0,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.changeLanguage,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
              const Icon(null)
            ],
          ),
          const SizedBox(height: 25.0),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: Language.values.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<LanguageBloc>().add(
                            ChangeLanguage(
                              selectedLanguage: Language.values[index],
                            ),
                          );
                    },
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipOval(
                        child:
                            Image.asset(Language.values[index].image.assetName),
                      ),
                    ),
                    title: Text(
                      Language.values[index].text,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Language.values[index] == state.selectedLanguage
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: Language.values[index] == state.selectedLanguage
                          ? BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              // color: Colors.grey,
                              width: 1.5)
                          : const BorderSide(),
                    ),
                    tileColor: Language.values[index] == state.selectedLanguage
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                        : null,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
