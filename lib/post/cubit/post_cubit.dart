import 'package:cubit/cubit.dart';
import 'package:flutter_infinite_list/post/cubit/cubit.dart';
import 'package:flutter_infinite_list/post/model/model.dart';
import 'package:flutter_infinite_list/post/repository/post_repository.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState());

  final PostRepository _repository = PostRepository();

  Future init() async {
    emit(state.reset());
    await fetch();
  }

  Future refresh() async {
    await fetch(isRefresh: true);
  }

  Future fetch({bool isRefresh=false}) async {
    emit(state.startFetching());

    try {
      // some delay to see the showing state of loading animation
      // remove this in production
      await Future.delayed(Duration(milliseconds: 500));

      int start = isRefresh ? 0 : state.count;
      List<Post> items = await _repository.fetch(start: start);

      isRefresh 
        ? emit(state.replace(items: items)) 
        : emit(state.append(items: items));

    } catch(_) {
      emit(state.failed());
    }
    
    await Future.delayed(Duration(milliseconds: 0));
    emit(state.stopFetching());
  }

  @override
  void onTransition(Transition<PostState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}