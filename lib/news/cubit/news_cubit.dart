import 'package:cubit/cubit.dart';
import 'package:flutter_infinite_list/news/cubit/news_state.dart';
import 'package:flutter_infinite_list/news/model/news.dart';
import 'package:flutter_infinite_list/news/repository/news_repository.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState());

  final NewsRepository _repository = NewsRepository();

  Future init() async {
    emit(state.reset());
    await fetch();
  }

  Future refresh() async {
    emit(state.resetPage());
    await fetch();
  }

  Future fetch() async {
    emit(state.startFetching());

    try {
      int page = state.nextPage;
      List<News> items = await _repository.fetch(page: page);
      
      page == 1 
        ? emit(state.replace(items: items)) 
        : emit(state.append(items: items));
      
    } catch(_) {
      emit(state.failed());
    }
    
    await Future.delayed(Duration(milliseconds: 0));
    emit(state.stopFetching());
  }

  @override
  void onTransition(Transition<NewsState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}