import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/news/controller/scroll.dart';
import 'package:flutter_infinite_list/post/cubit/cubit.dart';
import 'package:flutter_infinite_list/post/widget/widget.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  CheckScrollController _scrollController = CheckScrollController();
  PostCubit get _cubit => context.cubit<PostCubit>();
  
  bool get _isReadyToFetch => 
    _scrollController.isAtBottom && _cubit.state.isNotFetching;

  @override
  void initState() {
    super.initState();
    _initScroll();
    _cubit.init();
  }

  void _initScroll() {
    _scrollController.addListener(() {
      if(_isReadyToFetch) _cubit.fetch();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _cubit.refresh(),
      child: CubitBuilder<PostCubit, PostState>(
        builder: (_, state) {
          if(state.isShowLoader) return Center(child: CircularProgressIndicator());
          if(state.isShowError) return Center(child: Text('failed to fetch posts'));
          if(state.isShowEmpty) return Center(child: Text('empty posts'));

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.count + 1,
            itemBuilder: (_, index) {
              if(index < state.count) return PostItem(post: state.items[index]);
              if(state.isShowBottomLoader) return BottomLoader();
              return Container();
            },
          );
        },
      ),
    );
  }
}