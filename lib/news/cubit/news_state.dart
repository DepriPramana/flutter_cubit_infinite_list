import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/news/model/news.dart';

class NewsState extends Equatable {
  final int page;
  final bool isFetching;
  final bool isFetchError;
  final List<News> items;

  NewsState({
    this.page=0,
    this.isFetching=true, 
    this.isFetchError=false, 
    this.items=const [],
  });

  int get nextPage => page + 1;
  int get count => items?.length ?? 0;
  bool get isEmpty => count == 0;
  bool get canFetch => !isFetching;

  @override
  List<Object> get props => [isFetching, isFetchError, items, page];

  @override 
  String toString() => 'NewsState { page: $page, items: $count, isFetching: $isFetching, isFetchError: $isFetchError }';

  NewsState copyWith({
    int page,
    bool isFetching,
    bool isFetchError,
    List<News> items,
  }) {
    return NewsState(
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
      isFetchError: isFetchError ?? this.isFetchError,
      items: items ?? this.items,
    );
  }

  NewsState margeWith({
    int page,
    bool isFetching,
    bool isFetchError,
    List<News> items,
  }) {
    List<News> _mergeItems = this.items.toList();
    items.forEach((item) { 
      if(!_mergeItems.contains(item)) _mergeItems.add(item);
    });

    return NewsState(
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
      isFetchError: isFetchError ?? this.isFetchError,
      items: _mergeItems,
    );
  }
}