import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/post/model/model.dart';

class PostState extends Equatable {
  final bool isFetching;
  final bool isFetchError;
  final List<Post> items;

  int get count => items?.length ?? 0;
  bool get isEmpty => count == 0;
  bool get isNotFetching => !isFetching;

  bool get isShowLoader => isEmpty && isFetching;
  bool get isShowError => isEmpty && isFetchError;
  bool get isShowEmpty => isEmpty && isNotFetching && !isFetchError;
  bool get isShowBottomLoader => !isEmpty && isFetching;

  @override
  List<Object> get props => [items, isFetching, isFetchError];

  @override 
  String toString() => 
    'PostState { items: $count, isFetching: $isFetching, isFetchError: $isFetchError }';
  
  PostState({
    this.isFetching=true,
    this.isFetchError=false, 
    this.items=const [],
  });

  PostState reset() => copyWith(isFetchError: false, items: []);
  PostState startFetching() => copyWith(isFetching: true, isFetchError: false);
  PostState stopFetching() => copyWith(isFetching: false);
  PostState failed() => copyWith(isFetchError: true);
  PostState replace({List<Post> items}) => copyWith(items: items);
  PostState append({List<Post> items}) => mergeWith(items: items);

  PostState copyWith({
    bool isFetching,
    bool isFetchError,
    List<Post> items,
  }) {
    return PostState(
      isFetching: isFetching ?? this.isFetching,
      isFetchError: isFetchError ?? this.isFetchError,
      items: items ?? this.items,
    );
  }

  PostState mergeWith({
    bool isFetching,
    bool isFetchError,
    List<Post> items,
  }) {
    // merge new data from items, to the previous data in this.items
    List<Post> mergeItems = this.items.toList();
    items.forEach((item) {
      // only add item if it's not already exists in mergeItems
      bool isNotDuplicate = mergeItems.indexWhere((mItem) => mItem.id == item.id) < 0;
      if(isNotDuplicate) mergeItems.add(item);
    });

    /* items.forEach((item) { 
      // check for duplicate data from items
      if(!mergeItems.contains(item)) mergeItems.add(item);
    }); */

    return copyWith(
      isFetching: isFetching,
      isFetchError: isFetchError,
      items: mergeItems,
    );
  }
}