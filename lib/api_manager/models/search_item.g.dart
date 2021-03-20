// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) {
  return SearchResponse(
    json['query'] == null
        ? null
        : SearchResponseQueryData.fromJson(
            json['query'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'query': instance.query,
    };

SearchResponseQueryData _$SearchResponseQueryDataFromJson(
    Map<String, dynamic> json) {
  return SearchResponseQueryData(
    (json['pages'] as List)
        ?.map((e) =>
            e == null ? null : SearchItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchResponseQueryDataToJson(
        SearchResponseQueryData instance) =>
    <String, dynamic>{
      'pages': instance.pages,
    };

SearchItem _$SearchItemFromJson(Map<String, dynamic> json) {
  return SearchItem(
    json['title'] as String,
    json['thumbnail'] == null
        ? null
        : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    json['terms'] == null
        ? null
        : Terms.fromJson(json['terms'] as Map<String, dynamic>),
    json['fullurl'] as String,
  );
}

Map<String, dynamic> _$SearchItemToJson(SearchItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'terms': instance.terms,
      'fullurl': instance.fullurl,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return Thumbnail(
    json['source'] as String,
  );
}

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'source': instance.source,
    };

Terms _$TermsFromJson(Map<String, dynamic> json) {
  return Terms(
    (json['description'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TermsToJson(Terms instance) => <String, dynamic>{
      'description': instance.description,
    };
