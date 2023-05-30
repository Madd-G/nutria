import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/list_screen/widgets/widgets.dart';

class VegetableContent extends StatefulWidget {
  const VegetableContent({super.key});

  @override
  State<VegetableContent> createState() => _VegetableContentState();
}

class _VegetableContentState extends State<VegetableContent> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        context.read<DataBloc>().add(GetVegetables());
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
          } else if (state is VegetablesSuccessState) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: state.vegetables.data?.length,
              itemBuilder: (context, index) {
                return ProductCard(model: state.vegetables, index: index);
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
