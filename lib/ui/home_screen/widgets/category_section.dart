import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/list_screen/screen/list_screen.dart';
import '../../../responsive.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TabBloc tabBloc = context.read<TabBloc>();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Kategori',
            style: TextStyle(
                fontSize: (Responsive.isTablet(context)) ? 30 : 18,
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
                  'https://firebasestorage.googleapis.com/v0/b/nutria-29b7b.appspot.com/o/app_image%2Fapp%2Ffruit.png?alt=media&token=84c6e087-b405-4b0b-96da-dde2831954f3',
              label: 'BUAH',
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
                  'https://firebasestorage.googleapis.com/v0/b/nutria-29b7b.appspot.com/o/app_image%2Fapp%2Fvegetable.png?alt=media&token=594f15d7-46f9-4128-8c46-2a35d3f65d2c',
              label: 'SAYURAN',
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
        width: size.width * 0.47,
        height: Responsive.isTablet(context) ?  size.height * 0.22 :size.height * 0.2,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: imagePath,
                  // progressIndicatorBuilder: (_, url, download) {
                  //   if (download.progress != null) {
                  //     final percent = download.progress! * 100;
                  //     return Center(
                  //         child: Text(
                  //       'loading: ${percent.toStringAsFixed(0)}%',
                  //       style: const TextStyle(color: Colors.grey),
                  //     ));
                  //   }
                  //   return const Text('');
                  // },
                  fit: BoxFit.fill,
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: (Responsive.isTablet(context)) ? 30.0 : 16.0,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
