import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/ui/list_screen/widgets/widgets.dart';

class VegetableContent extends StatelessWidget {
  const VegetableContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('items')
            .where("category", isEqualTo: "Vegetable")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return const SizedBox(
              child: Center(child: Text("There is no article")),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var doc = documents[index];
                  return ProductCard(
                    doc: doc,
                  );
                }
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
