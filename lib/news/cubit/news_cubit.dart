import 'package:cubit/cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_state.dart';
import 'package:flutter_infinite_list/news/model/news.dart';
import 'package:flutter_infinite_list/news/repository/news_repository.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState());

  final NewsRepository _repository = NewsRepository();

  Future init() async {
    emit(NewsState());
    await fetch();
  }

  Future refresh() async {
    //emit(state.copyWith(page: 0));
    emit(state.resetPage());
    await fetch(isRefresh: true);
  }

  Future fetch({bool isRefresh=false}) async {
    print('start fetching');
    emit(state.startFetching());
    //emit(state.copyWith(isFetching: true, isFetchError: false));

    try {
      int page = state.nextPage;
      List<News> items = await _repository.fetch(page: page);

      isRefresh 
        ? emit(state.replace(items: items)) 
        : emit(state.append(items: items));
      
      /* if(isRefresh) {
        emit(state.copyWith(items: items, page: page));
      } else {
        emit(state.mergeWith(items: items, page: page));
      } */
      
      print('fetch news success');
    } catch(e) {
      print(e.toString());
      //emit(state.copyWith(isFetchError: true));
      emit(state.failed());
      print('fetch error');
    }
    
    await Future.delayed(Duration(milliseconds: 0));
    //emit(state.copyWith(isFetching: false));
    emit(state.stopFetching());
    print('stop fetching');
  }

  @override
  void onTransition(Transition<NewsState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}