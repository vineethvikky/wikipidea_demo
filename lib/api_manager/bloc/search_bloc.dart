import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikipedia_search/api_manager/api_calling.dart';
import 'package:wikipedia_search/api_manager/bloc/states/search_states.dart';
import 'events/search_event.dart';

class SearchItemBloc extends Bloc<SearchItemEvent, SearchItemState> {
  SearchItemBloc() : super(null);

  @override
  Stream<SearchItemState> mapEventToState(SearchItemEvent event) async* {
    if (event is GetSearchItemsEvent) {
      if (event.searchText.isEmpty) {
        yield SearchItemEmptyTextState();
      } else {
        yield SearchItemLoadingState();
        try {
          final items =
          await ApiManager.instance.fetchItems(searchText: event.searchText);
          yield SearchItemCompletedState(items: items);
        } catch (_) {
          yield SearchItemErrorState();
        }
      }
    }
  }
}
