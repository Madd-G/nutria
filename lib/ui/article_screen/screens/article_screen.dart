import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import '../../../models/models.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            context.read<ScreenBloc>().add(ScreenEventGoToArticleListScreen());
          },
        ),
      ),
      body: BlocBuilder<ScreenBloc, ScreenState>(
        builder: (context, state) {
          if (state is ScreenStateIsInArticleScreen) {
            Article article = state.article;
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Image.network(
                                article.profileImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            '  ${article.author}  •  ${article.date}  •  ${article.category}',
                            style: const TextStyle(color: Colors.grey, fontSize: 13.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        article.title!,
                        style: const TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: SizedBox(
                          height: 250.0,
                          width: size.width,
                          child: Image.network(
                            article.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Center(
                          child: Text('${article.pictureDescription}',
                              style: const TextStyle(color: Colors.grey))),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        article.article!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
