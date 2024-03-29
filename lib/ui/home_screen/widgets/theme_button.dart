import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../theme.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({Key? key}) : super(key: key);

  final bool themeMode = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        context.read<ThemeCubit>().state == AppTheme.lightTheme
            ? const Icon(Icons.light_mode)
            : const Icon(Icons.dark_mode_outlined),
        Switch.adaptive(
          activeColor: Theme.of(context).colorScheme.primary,
          value: context.watch<ThemeCubit>().state == AppTheme.lightTheme
              ? true
              : false,
          onChanged: (value) {
            context.read<ThemeCubit>().switchTheme();
          },
        ),
      ],
    );
  }
}
