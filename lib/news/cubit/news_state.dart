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
  bool get isNotEmpty => count > 0;
  bool get isNotFetching => !isFetching;

  // widget showing logic, computed on the fly according to state data
  bool get isShowLoader => isEmpty && isFetching;
  bool get isShowError => isEmpty && isFetchError;
  bool get isShowEmpty => isEmpty && isNotFetching && !isFetchError;
  bool get isShowBottomLoader => isNotEmpty && isFetching;

  @override
  List<Object> get props => [page, items, isFetching, isFetchError];

  @override 
  String toString() => 
    'NewsState { page: $page, items: $count, isFetching: $isFetching, isFetchError: $isFetchError }';

  NewsState reset() => copyWith(page: 0, isFetchError: false, items: []);
  NewsState resetPage() => copyWith(page: 0);
  NewsState startFetching() => copyWith(isFetching: true, isFetchError: false);
  NewsState stopFetching() => copyWith(isFetching: false);
  NewsState failed() => copyWith(isFetchError: true);

  NewsState replace({List<News> items}) => copyWith(items: items, page: 1);
  NewsState append({List<News> items}) {
    // append new data from items, to the previous data in this.items
    List<News> mergeItems = this.items.toList();
    items?.forEach((item) {
      // only add item if it's not already exists in mergeItems
      bool isNotDuplicate = mergeItems.indexWhere((mItem) => mItem.id == item.id) < 0;
      if(isNotDuplicate) mergeItems.add(item);
    });
    
    return copyWith(
      page: items.isNotEmpty ? nextPage : this.page,
      items: mergeItems,
      isFetching: isFetching,
      isFetchError: isFetchError,
    );
  }

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
}