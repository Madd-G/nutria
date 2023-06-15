import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../services/services.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    ApiService apiService = ApiService();
    on<SearchItemEvent>((event, emit) async {
      final String searchedItem = event.searchedItem!;
      if (searchedItem.isEmpty) {
        emit(NotSearchingItemState());
      } else {
        emit(SearchingItemState());
        final makeRequest = await apiService.searchForItem(searchedItem);
        makeRequest.fold((onLeft) {
          emit(ErrorsState(onLeft));
        }, (onRight) {
          emit(ItemExistState(items: onRight));
        });
      }
    });
  }
}
