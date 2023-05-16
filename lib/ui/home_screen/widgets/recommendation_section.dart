import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommendations',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        const RecommendationCarousel()
      ],
    );
  }
}

class RecommendationCarousel extends StatelessWidget {
  const RecommendationCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const SizedBox(
            height: 150.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ErrorState) {
          return SizedBox(
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('An error occurred'),
                const SizedBox(
                  height: 10.0,
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<RecommendationsBloc>()
                        .add(GetRecommendations());
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
        } else if (state is SuccessState) {
          return SizedBox(
            height: 180,
            child: ListView.builder(
              reverse: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Image(
                              height: 250.0,
                              width: 250.0,
                              image: AssetImage('assets/images/fruit.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5.0,
                          bottom: 15.0,
                          child: Stack(
                            children: [
                              Container(
                                width: 70,
                                height: 25,
                                // color: Colors.white,
                                decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                                child: Text(
                                  '${state.recommendations.data?[index].name}',
                                  style: const TextStyle(
                                    color: Colors.black26,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
    );
  }
}
