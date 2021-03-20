import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikipedia_search/api_manager/bloc/events/search_event.dart';
import 'package:wikipedia_search/api_manager/bloc/search_bloc.dart';
import 'package:wikipedia_search/api_manager/bloc/states/search_states.dart';
import 'package:wikipedia_search/api_manager/models/search_item.dart';
import 'package:wikipedia_search/ui/util/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final itemBloc = SearchItemBloc();

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  Timer _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchQueryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: _isSearching
              ? _searchFieldWidget()
              : Text(kWikipedia,
                  style:
                      TextStyle(fontSize: ScreenUtil().getFont(kFontSize22))),
          actions: _appBarWidgets(),
        ),
        body: BlocBuilder(
            bloc: itemBloc,
            builder: (BuildContext _, SearchItemState state) {
              if (state is SearchItemLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchItemCompletedState) {
                List<SearchItem> items = state.items ?? [];
                if (items.isEmpty) {
                  return _emptyWidget();
                }
                return SafeArea(
                  minimum: EdgeInsets.only(
                      left: ScreenUtil().getWidth(10),
                      right: ScreenUtil().getWidth(10),
                      top: ScreenUtil().getHeight(10),
                      bottom: ScreenUtil().getHeight(10)),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().getHeight(10)),
                        child: InkWell(
                          onTap: () {
                            if (items[index].fullurl.isNotEmpty)
                              launchURL(items[index].fullurl);
                          },
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().getWidth(5),
                                        vertical: ScreenUtil().getHeight(5)),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: FadeInImage(
                                          image: items[index]
                                                      .thumbnail
                                                      ?.source !=
                                                  null
                                              ? NetworkImage(
                                                  items[index].thumbnail.source)
                                              : AssetImage(kPlaceHolder),
                                          placeholder:
                                              AssetImage(kPlaceHolder)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenUtil().getHeight(5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().getHeight(5)),
                                            child: Text(items[index].title,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: ScreenUtil()
                                                        .getFont(kFontSize20))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    ScreenUtil().getHeight(5)),
                                            child: Text(
                                                items[index]
                                                        .terms
                                                        ?.description
                                                        ?.first ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: ScreenUtil()
                                                        .getFont(kFontSize10))),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                    itemCount: items.length,
                  ),
                );
              } else if (state is SearchItemErrorState ||
                  state is SearchItemEmptyTextState) {
                if (state is SearchItemErrorState) {
                  // Here we can handle the error state
                }
                return Center(
                    child: Text('Search for data',
                        style: TextStyle(
                            fontSize: ScreenUtil().getFont(kFontSize20))));
              }
              return Container();
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _searchFieldWidget() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: kSearch,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(
          color: Colors.white, fontSize: ScreenUtil().getFont(kFontSize16)),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _appBarWidgets() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _clearSearchQuery();
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
          },
        ),
      ];
    }
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _emptyWidget() {
    return Center(
      child: Text(kNoDataFound,
          style: TextStyle(
              fontSize: ScreenUtil().getFont(kFontSize22),
              color: Colors.black.withOpacity(0.5))),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      itemBloc.add(GetSearchItemsEvent(searchText: searchQuery));
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void launchURL(String url) async {
    final encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
