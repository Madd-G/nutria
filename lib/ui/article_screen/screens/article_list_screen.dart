import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/models/article_model.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context.read<ArticleBloc>().add(GetArticle());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Articles'),
        ),
        body: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ArticleErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('An error occurred'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ArticleBloc>().add(GetArticle());
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ArticleSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.article.articles!.length,
                  itemBuilder: (context, index) {
                    Article? article = state.article.articles?[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<ScreenBloc>().add(
                            ScreenEventGoToArticleScreen(article: article));
                        context.read<ArticleBloc>().add(GetArticle());
                      },
                      child: SizedBox(
                        height: 150.0,
                        child: Card(
                          elevation: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.35,
                                foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(article!.image!),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Health',
                                        style: TextStyle(
                                            fontSize: 15.0, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.46,
                                        child: Text(
                                          '${article!.title}',
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
                                                    article.profileImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                '${article.author}  ●  ${article.date}',
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
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
