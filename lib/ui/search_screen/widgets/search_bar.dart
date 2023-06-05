import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/blocs/blocs.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        // controller: context.read<SearchBloc>().wordSearchTextFieldController,
        // controller: context.read<SearchBloc>(),
        controller: searchController,
        keyboardType: TextInputType.text,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          suffixIcon: UnconstrainedBox(
            child: IconButton(
              onPressed: () {
                context
                    .read<SearchBloc>()
                    .add(SearchItemEvent(searchedWord: searchController.text));
              },
              icon: const Icon(
                Icons.send,
                size: 18,
              ),
            ),
          ),
          filled: true,
          counterText: "",
          hintText: "Enter the word you want to search",
          contentPadding: const EdgeInsets.only(
            left: 15.0,
            top: 19.0,
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }
}
