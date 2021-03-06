import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/news/controller/scroll.dart';
import 'package:flutter_infinite_list/news/cubit/news_cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_state.dart';
import 'package:flutter_infinite_list/news/widget/bottom_loader.dart';
import 'package:flutter_infinite_list/news/widget/news_item.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  
  CheckScrollController _scrollController = CheckScrollController();
  NewsCubit get _cubit => context.cubit<NewsCubit>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit.init();
  }

  void _onScroll() {
    ScrollDirection _direction = _scrollController.position.userScrollDirection;
    bool _isScrollDown = _direction == ScrollDirection.reverse;
    
    // only fetch new items if user scroll to the bottom of list 
    // at down direction and isNotFetching
    bool _isFetch = 
      _isScrollDown && 
      _scrollController.isAtBottom && 
      _cubit.state.isNotFetching;
    
    if(_isFetch) _cubit.fetch();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  Widget get _loader => Center(child: CircularProgressIndicator());
  Widget get _error => Center(child: Text('failed to fetch news'));
  Widget get _empty => Center(child: Text('empty news'));

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _cubit.refresh(),
      child: CubitBuilder<NewsCubit, NewsState>(
        builder: (_, state) {
          if(state.isShowLoader) return _loader;
          if(state.isShowError) return _error;
          if(state.isShowEmpty) return _empty;
          
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.count + 1,
            itemBuilder: (_, index) {
              if(index < state.count) return NewsItem(item: state.items[index]);
              if(state.isShowBottomLoader) return BottomLoader();
              return Container();
            },
          );
        },
      ),
    );
  }
}