import 'package:equatable/equatable.dart';
import 'package:wikipedia_search/api_manager/models/search_item.dart';

abstract class SearchItemState extends Equatable {}
class SearchItemLoadingState extends SearchItemState {
  SearchItemLoadingState();

  @override
  List<Object> get props => throw [];
}

class SearchItemCompletedState extends SearchItemState {
  SearchItemCompletedState({this.items});

  List<SearchItem> items = [];

  @override
  List<Object> get props => throw [items];
}

class SearchItemErrorState extends SearchItemState {
  SearchItemErrorState();

  @override
  List<Object> get props => throw [];
}

class SearchItemEmptyTextState extends SearchItemState {
  SearchItemEmptyTextState();

  @override
  List<Object> get props => throw [];
}