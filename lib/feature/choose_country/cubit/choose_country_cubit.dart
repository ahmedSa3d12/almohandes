import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/country_model.dart';
import '../../../core/remote/service.dart';

part 'choose_country_state.dart';

class ChooseCountryCubit extends Cubit<ChooseCountryState> {
  final ServiceApi api;
  CountryModel? selectedCountry;


  List<CountryModel> countries = [];

  ChooseCountryCubit(this.api) : super(ChooseCountryInitial()){
    getCountries();
 
  }

  getCountries() async {
    emit(CountriesLoading());
    final response = await api.getCountries();
    response.fold(
          (l) => emit(CountriesError()),
          (r) {
        countries = r.data!;
        emit(CountriesLoaded());
      },
    );
  }

  void changeCountry(CountryModel? value) {
    selectedCountry=value;
    emit(CountriesLoaded());

  }
}
