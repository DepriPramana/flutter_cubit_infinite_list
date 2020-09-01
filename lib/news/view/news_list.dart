import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_state.dart';
import 'package:flutter_infinite_list/news/widget/bottom_loader.dart';
import 'package:flutter_infinite_list/news/widget/news_item.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  ScrollController _scrollController = ScrollController();
  NewsCubit get _cubit => context.cubit<NewsCubit>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit.init();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if(_isAtBottom && _cubit.state.isNotFetching) {
      print('ready to fetch');
      _cubit.fetch();
    }
  }

  bool get _isAtBottom {
    final offsetFromBottom = 25;
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    return currentScroll >= maxScroll - offsetFromBottom;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _cubit.refresh(),
      child: CubitBuilder<NewsCubit, NewsState>(
        builder: (_, state) {
          if(state.isEmpty) {
            if(state.isFetching) return Center(child: CircularProgressIndicator());
            if(state.isFetchError) return Center(child: Text('failed to fetch news'));
            return Center(child: Text('empty news'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.count + 1,
            itemBuilder: (_, index) {
              if(index < state.count) return NewsItem(item: state.items[index]);
              if(state.isFetching) return BottomLoader();
              return Container();
            },
          );
        },
      ),
    );
  }
}