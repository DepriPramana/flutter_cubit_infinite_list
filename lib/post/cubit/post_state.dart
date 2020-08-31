import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/post/model/model.dart';

class PostState extends Equatable {
  final bool isFetching;
  final bool isFetchError;
  final List<Post> items;

  int get count => items?.length ?? 0;
  bool get isEmpty => count == 0;
  bool get canFetch => !isFetching;

  @override
  List<Object> get props => [items, isFetching, isFetchError];

  @override 
  String toString() => 'PostState { items: $count, isFetching: $isFetching, isFetchError: $isFetchError }';
  
  PostState({
    this.isFetching=true,
    this.isFetchError=false, 
    this.items=const [],
  });

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
      // check for duplicate data from items
      if(!mergeItems.contains(item)) mergeItems.add(item);
    });

    return PostState(
      isFetching: isFetching ?? this.isFetching,
      isFetchError: isFetchError ?? this.isFetchError,
      items: mergeItems,
    );
  }
}