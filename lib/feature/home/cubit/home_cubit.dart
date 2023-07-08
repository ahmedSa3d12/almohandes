import 'package:bloc/bloc.dart';
import 'package:engwheels/core/models/cars_model.dart';
import 'package:engwheels/core/models/category_model.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ServiceApi api;


  List<CarsModel> cars = [];
  List<CarsModel> carsFilter = [];

  List<CategoryModel> categories=[];
  String status="all";
  String gear_type="all";
  String manufacturing_year="all";
  String category_id="all";
  String from_price="50";
  String  to_price="180";
  HomeCubit(this.api) : super(HomeInitial()){
    getHome();
    getCategory();
    getFilterHome();

  }

  getCategory() async {
    emit(CategoryLoading());
    final response = await api.getCategory();
    response.fold(
          (l) => emit(CategoryError()),
          (r) {
        categories = r.data!;
        emit(CategoryLoaded());
      },
    );
  }
  getHome() async {
    emit(HomeCarsLoading());
    final response = await api.getHomeCars();
    response.fold(
          (l) => emit(HomeCarsError()),
          (r) {
            cars = r.data!;
        emit(HomeCarsLoaded());
      },
    );
  }
  getFilterHome() async {
    emit(HomeFilterCarsLoading());
    final response = await api.getHomeFilterCars(status, gear_type, manufacturing_year, category_id, from_price, to_price);
    response.fold(
          (l) => emit(HomeFilterCarsError()),
          (r) {
            carsFilter = r.data!;
        emit(HomeFilterCarsLoaded());
      },
    );
  }

  void setstatus(String s) {
    this.status=s;
    emit(HomeFilterCarsLoaded());  }

  void setSpare(String s) {
    this.gear_type=s;
    emit(HomeFilterCarsLoaded());  }

  void setprice(double lowerValue, double upperValue) {
    this.from_price=lowerValue.toString();
    this.to_price=upperValue.toString();
    emit(HomeFilterCarsLoaded());  }

  void setyear(String year) {

    this.manufacturing_year=year;
    emit(HomeFilterCarsLoaded());
  }

  setcategory(String s) {
    this.category_id=s;
    emit(HomeFilterCarsLoaded());  }

}
