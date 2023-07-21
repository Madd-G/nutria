import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutria/widgets/global_widgets.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../widgets/widgets.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key, required this.doc, required this.l10n}) : super(key: key);
  final DocumentSnapshot doc;
  final AppLocalizations l10n;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('article')
        .doc(widget.doc.id)
        .update({'${widget.l10n.lang}.viewed': widget.doc[widget.l10n.lang]['viewed'] + 1});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NutriAIButton(
      mainWidget: Scaffold(
        body: Stack(
          children: [
            ArticleImage(size: size, doc: widget.doc),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: (Responsive.isDesktop(context))
                      ? size.height * 0.1
                      : size.height * 0.76,
                  width: size.width,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          ArticleTitle(doc: widget.doc),
                          SizedBox(
                            height:
                                (Responsive.isDesktop(context)) ? 17.0 : 13.0,
                          ),
                          ArticleAuthor(doc: widget.doc),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Article(doc: widget.doc)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
