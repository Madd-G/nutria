import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutria/responsive.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.searchController});

  final TextEditingController searchController;

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
                'Search for Fruits or Vegetables'.tr,
                style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 18.0 : 13.0,
                    color: Colors.black),
              ),
              SizedBox(
                height: Responsive.isTablet(context) ? 16.0 : 10.0,
              ),
              TextField(
                controller: searchController,
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
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  hintStyle: const TextStyle(
                    color: Color(0xFF99A1B5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
