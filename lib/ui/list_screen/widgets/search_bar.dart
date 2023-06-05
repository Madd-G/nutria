import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
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
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<ScreenBloc>()
                        .add(ScreenEventGoToSearchScreen());
                  },
                  child: TextField(
                    onTap: () {
                      context
                          .read<ScreenBloc>()
                          .add(ScreenEventGoToSearchScreen());
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFEAEBEF),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      hintStyle: const TextStyle(
                        color: Color(0xFF99A1B5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
