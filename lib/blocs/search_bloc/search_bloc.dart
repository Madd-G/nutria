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
      final String searchedWord = event.searchedWord!;
      if (searchedWord.isEmpty) {
        emit(NotSearchingWordState());
      } else {
        emit(SearchingWordState());
        final makeRequest = await apiService.searchForWord(searchedWord);
        makeRequest.fold((onLeft) {
          emit(ErrorsState(onLeft));
        }, (onRight) {
          emit(WordExistState(words: onRight));
        });
      }
    });
  }
}
