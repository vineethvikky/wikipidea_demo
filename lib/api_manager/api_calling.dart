import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wikipedia_search/api_manager/models/search_item.dart';

class ApiManager {
  ApiManager._privateConstructor();

  static final ApiManager _instance = ApiManager._privateConstructor();

  static ApiManager get instance => _instance;

  var baseUrl = 'https://en.wikipedia.org/w/api.php';

  Future<List<SearchItem>> fetchItems({String searchText}) async {
    final response = await http.get(
        '${baseUrl}?action=query&format=json&formatversion=2&generator=prefixsearch&gpssearch=${searchText}&gpslimit=50&prop=pageimages%7Cpageterms%7Cinfo&inprop=url&piprop=thumbnail&pithumbsize=100&pilimit=50&redirects=&wbptterms=description');

    if (response.statusCode == 200) {
      final responseData = SearchResponse.fromJson(jsonDecode(response.body));
      return responseData.query.pages;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
