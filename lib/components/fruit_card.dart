import 'package:flutter/material.dart';
import 'package:nutria/controllers/controllers.dart';
import 'package:nutria/views/detail_screen.dart';
import 'package:get/get.dart';

import '../models/model.dart';

class FruitCard extends StatelessWidget {
  final Model model;
  final Controllers controller = Get.put(Controllers());

  FruitCard(this.model);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      // SizedBox(
      // height: 600,
      // child:
          // ListView.builder(
          // reverse: false,
          // scrollDirection: Axis.vertical,
          // // itemCount: controller.productList.length,
          // itemCount: fruits.length,
          // itemBuilder: (BuildContext context, int index) {
          //   FruitVegetable fruit = fruits[index];
          //   return
          Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
        // child: GestureDetector(
        //   onTap: () =>
        //       Get.to(() => DetailScreen(detailFruitVegetable: fruit)),
        // child: Hero(
        //   tag: model.name,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: const Color(0xffF7F9FB),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    // offset: Offset(0.0, 2.0),
                    blurRadius: 0.5)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height * 0.172,
                    width: width * 0.442,
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
                        height: height * 0.16,
                        width: width * 0.43,
                        // image: AssetImage(fruit.imageUrl),
                        image: const AssetImage("assets/images/apel.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: height * 0.172,
                    width: width * 0.458,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            'Category'.tr,
                            style: const TextStyle(
                                color: Color(0xffA1A8B9), fontSize: 13.0),
                          ),
                          Text(
                            model.category,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Description'.tr,
                            style: const TextStyle(
                                color: Color(0xffA1A8B9), fontSize: 13.0),
                          ),
                          Expanded(
                            child: Text(
                              model.description,
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              style: const TextStyle(
                                fontSize: 12.0,
                                overflow: TextOverflow.fade,
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
        // ),
      );
    // );
  }
}
