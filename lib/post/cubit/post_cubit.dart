import 'package:cubit/cubit.dart';
import 'package:flutter_infinite_list/post/cubit/cubit.dart';
import 'package:flutter_infinite_list/post/model/model.dart';
import 'package:flutter_infinite_list/post/repository/post_repository.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState());

  final PostRepository _repository = PostRepository();

  Future init() async {
    emit(PostState());
    await fetch();
  }

  Future refresh() async {
    await fetch(isRefresh: true);
  }

  Future fetch({bool isRefresh=false}) async {
    print('start fetching');
    emit(state.copyWith(isFetching: true, isFetchError: false));

    try {
      // some delay to see the showing state of loading animation
      await Future.delayed(Duration(milliseconds: 500)); 
      List<Post> items = await _repository.fetch(start: isRefresh ? 0 : state.count);

      if(isRefresh) {
        emit(state.copyWith(items: items));
      } else {
        emit(state.margeWith(items: items));
      }
      
      print('fetch post success');
    } catch(e) {
      print(e.toString());
      emit(state.copyWith(isFetchError: true));
      print('fetch error');
    }
    
    await Future.delayed(Duration(milliseconds: 0));
    emit(state.copyWith(isFetching: false));
    print('stop fetching');
  }

  @override
  void onTransition(Transition<PostState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}