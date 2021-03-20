

abstract class SearchItemEvent {
  const SearchItemEvent();
}

class GetSearchItemsEvent extends SearchItemEvent {
  final String searchText;

  GetSearchItemsEvent({this.searchText});
}
