import 'package:flutter/material.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/list_screen/widgets/widgets.dart';
import 'package:nutria/models/models.dart';

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
                Data data = state.vegetables.data![index];
                return ProductCard(data: data);
              },
            );
          } else if (state is ErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('An error occurred'),
                const SizedBox(
                  height: 10.0,
                ),
                IconButton(
                  onPressed: () =>
                      context.read<DataBloc>().add(GetVegetables()),
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
