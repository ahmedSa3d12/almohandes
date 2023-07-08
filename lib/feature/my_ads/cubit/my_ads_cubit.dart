import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/cars_model.dart';
import '../../../core/remote/service.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final ServiceApi api;


  List<CarsModel> cars = [];
  MyAdsCubit(this.api) : super(MyAdsInitial()){
    getMyAds();
  }
  getMyAds() async {
    emit(MyCarsLoading());
    final response = await api.getMyCars();
    response.fold(
          (l) => emit(MyCarsError()),
          (r) {
        cars = r.data!;
        emit(MyCarsLoaded());
      },
    );
  }
  deleteProduct(int id,int index) async {

    final response = await api.deleteproduct(id.toString());
    response.fold(
          (l) => emit(MyCarsError()),
          (r) {
        cars.removeAt(index);
        emit(MyCarsLoaded());
      },
    );
  }
}
