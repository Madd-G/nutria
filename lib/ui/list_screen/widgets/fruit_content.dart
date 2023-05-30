import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/list_screen/widgets/widgets.dart';

class FruitContent extends StatefulWidget {
  const FruitContent({super.key});

  @override
  State<FruitContent> createState() => _FruitContentState();
}

class _FruitContentState extends State<FruitContent> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context.read<DataBloc>().add(GetFruits());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const SizedBox(
              height: 150.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is FruitsSuccessState) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.fruits.data?.length,
              itemBuilder: (context, index) {
                return ProductCard(model: state.fruits, index: index);
              },
            );
          } else if (state is ErrorState) {
            return const Center(child: Text('Error'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
