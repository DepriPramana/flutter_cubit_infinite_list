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
  bool get isNotFetching => !isFetching;
  //bool get canFetch => !isFetching;

  @override
  List<Object> get props => [page, items, isFetching, isFetchError];

  @override 
  String toString() => 
    'NewsState { page: $page, items: $count, isFetching: $isFetching, isFetchError: $isFetchError }';

  NewsState resetPage() => copyWith(page: 0);
  NewsState startFetching() => copyWith(isFetching: true, isFetchError: false);
  NewsState stopFetching() => copyWith(isFetching: false);
  NewsState failed() => copyWith(isFetchError: true);
  NewsState replace({List<News> items}) => copyWith(items: items, page: nextPage);
  NewsState append({List<News> items}) => mergeWith(items: items, page: nextPage);

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

  NewsState mergeWith({
    int page,
    bool isFetching,
    bool isFetchError,
    List<News> items,
  }) {
    // merge new data from items, to the previous data in this.items
    List<News> mergeItems = this.items.toList();
    items.forEach((item) {
      // only add item if it's not already exists in mergeItems
      bool isNotDuplicate = mergeItems.indexWhere((mItem) => mItem.id == item.id) < 0;
      if(isNotDuplicate) mergeItems.add(item);
    });

    /* items.forEach((item) { 
      // check for duplicate data from items, don't add to the this.items
      if(!mergeItems.contains(item)) mergeItems.add(item);
    }); */

    return NewsState(
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
      isFetchError: isFetchError ?? this.isFetchError,
      items: mergeItems,
    );
  }
}