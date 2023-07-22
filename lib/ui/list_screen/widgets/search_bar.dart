import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutria/responsive.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {super.key, required this.searchController, required this.l10n});

  final TextEditingController searchController;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isTablet(context))
                const SizedBox(
                  height: 13.0,
                ),
              Text(
                l10n.searchFruitsVegetables,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 13.0 : 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 10.0 : 16.0,
              ),
              TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                showCursor: true,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 1.0),
                  ),
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // filled: true,
                  // fillColor: const Color(0xFFF6F6F6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
