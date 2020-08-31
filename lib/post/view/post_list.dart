import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_infinite_list/post/cubit/cubit.dart';
import 'package:flutter_infinite_list/post/widget/widget.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  ScrollController _scrollController = ScrollController();
  PostCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postCubit = context.cubit<PostCubit>();
    _postCubit.init();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if(_isAtBottom && _postCubit.state.isNotFetching) {
      print('ready to fetch');
      _postCubit.fetch();
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
      onRefresh: () => _postCubit.refresh(),
      child: CubitBuilder<PostCubit, PostState>(
        builder: (_, state) {
          if(state.isEmpty) {
            if(state.isFetching) return Center(child: CircularProgressIndicator());
            if(state.isFetchError) return Center(child: Text('failed to fetch posts'));
            return Center(child: Text('empty posts'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.items.length + 1,
            itemBuilder: (_, index) {
              if(index < state.items.length) return PostItem(post: state.items[index]);
              if(state.isFetching) return BottomLoader();
              return Container();
            },
          );
        },
      ),
    );
  }
}