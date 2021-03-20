import 'package:json_annotation/json_annotation.dart';
part 'search_item.g.dart';

@JsonSerializable()
class SearchResponse {

  SearchResponseQueryData query;

  SearchResponse(this.query);

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class SearchResponseQueryData {
  List<SearchItem> pages;

  SearchResponseQueryData(this.pages);

  factory SearchResponseQueryData.fromJson(Map<String, dynamic> json) => _$SearchResponseQueryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseQueryDataToJson(this);
}

@JsonSerializable()
class SearchItem {
  String title;
  Thumbnail thumbnail;
  Terms terms;
  String fullurl;

  SearchItem(this.title, this.thumbnail, this.terms, this.fullurl);

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);
  Map<String, dynamic> toJson() => _$SearchItemToJson(this);
}

@JsonSerializable()
class Thumbnail {
  String source;

  Thumbnail(this.source);

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}

@JsonSerializable()
class Terms {
  List<String> description;

  Terms(this.description);

  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);
  Map<String, dynamic> toJson() => _$TermsToJson(this);
}