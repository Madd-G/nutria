import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutria/ui/list_screen/screen/list_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../responsive.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TabBloc tabBloc = context.read<TabBloc>();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.category,
            style: TextStyle(
                fontSize: (Responsive.isMobile(context)) ? 14 : 30,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryBox(
              imagePath:
                  'https://firebasestorage.googleapis.com/v0/b/nutria-29b7b.appspot.com/o/app_image%2Fapp%2Ffruit-removebg-preview.png?alt=media&token=0e70555b-24af-41c8-aa44-1af8ce0dece1',
              label: l10n.fruitUpper,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListScreen()));
                tabBloc.add(TabEventFruit());
                // screenBloc.add(ScreenEventGoToListScreen());
              },
            ),
            CategoryBox(
              imagePath:
                  'https://firebasestorage.googleapis.com/v0/b/nutria-29b7b.appspot.com/o/app_image%2Fapp%2Fvegetable-removebg-preview.png?alt=media&token=f0741824-0653-4aa7-a825-d15f0027af5f',
              label: l10n.vegetableUpper,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListScreen()));
                tabBloc.add(TabEventVegetable());
                // screenBloc.add(ScreenEventGoToListScreen());
              },
            )
          ],
        ),
      ],
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CategoryBox(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width * 0.48,
        height: Responsive.isMobile(context)
            ? size.height * 0.18
            : size.height * 0.24,
        child: Card(
          // color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  // color: Colors.white,
                  // height: Responsive.isTablet(context)
                  //     ? size.height * 0.2
                  //     : size.height * 0.15,
                  // width: size.width * 0.45,
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: (Responsive.isMobile(context)) ? 12.0 : 30.0,
                    fontWeight: FontWeight.w700,
                    // color: Colors.black,
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
