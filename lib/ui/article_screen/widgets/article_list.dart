import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../screens.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, top: 8.0, right: 2.0),
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('article').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const SizedBox();
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
                  DocumentSnapshot doc = documents[index];
                  return SizedBox(
                    height: size.width * 0.4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleScreen(doc: doc)));
                      },
                      child: Card(
                        elevation: 0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(doc['item-image']),
                                    fit: BoxFit.fill),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Health',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.46,
                                      child: Text(
                                        doc['title'],
                                        maxLines: 3,
                                        // textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 10.0,
                                    // ),
                                    // const Text('{article.tag'),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: SizedBox(
                                                width: 20.0,
                                                height: 20.0,
                                                child: Image.network(
                                                  doc['profile-image'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              '${doc["author"]}  ●  ${doc['date']}',
                                              style: const TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
