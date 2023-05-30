import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/models/models.dart';

class ProductCard extends StatelessWidget {
  final Data data;

  const ProductCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final ScreenBloc screenBloc = context.read<ScreenBloc>();
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
      child: GestureDetector(
        onTap: () {
          screenBloc.add(ScreenEventGoToDetailScreen());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: const Color(0xffF7F9FB),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 0.5)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.21,
                  width: width * 0.47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          // offset: Offset(0.0, 2.0),
                          blurRadius: 0.5)
                    ],
                  ),
                  child: Center(
                    child: Image(
                      height: height * 0.20,
                      width: width * 0.43,
                      image: const AssetImage("assets/images/fruit.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: height * 0.21,
                  width: width * 0.47,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.name!,
                            style: const TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 2.0, 0, 2.0),
                          child: Text(
                            'Category',
                            style: TextStyle(
                                color: Color(0xffA1A8B9), fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                          child: Text(
                            data.category!,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 0, 2.0),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: Color(0xffA1A8B9), fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 2.0),
                          child: Text(
                            data.description!,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 15.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // ),
    );
    // );
  }
}
