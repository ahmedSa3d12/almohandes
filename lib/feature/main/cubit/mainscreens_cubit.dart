import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mainscreens_state.dart';

class MainscreensCubit extends Cubit<MainscreensState> {
  int index=0;
  MainscreensCubit() : super(MainscreensInitial());

  setIndex(int index){
    this.index=index;
emit(MainscreensIndex(index));
  }
}
