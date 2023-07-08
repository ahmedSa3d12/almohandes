import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/new_model.dart';
import '../../../core/remote/service.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final ServiceApi api;


  List<NewsData> news = [];

NewsCubit(this.api) : super(NewsInitial()){
    getNews();

  }

  getNews() async {
    emit(NewsLoading());
    final response = await api.getNews();
    response.fold(
          (l) => emit(NewsError()),
          (r) {
            news = r.data!;
        emit(NewsLoaded());
      },
    );
  }
}
