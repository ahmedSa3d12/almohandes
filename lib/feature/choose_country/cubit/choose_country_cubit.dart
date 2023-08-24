import 'package:bloc/bloc.dart';
import 'package:engwheels/core/preferences/preferences.dart';
import 'package:meta/meta.dart';

import '../../../core/models/country_model.dart';
import '../../../core/remote/service.dart';

part 'choose_country_state.dart';

class ChooseCountryCubit extends Cubit<ChooseCountryState> {
  final ServiceApi api;
  CountryModel? selectedCountry;


  List<CountryModel> countries = [];

  CountryModel? selectedCountry1;

  ChooseCountryCubit(this.api) : super(ChooseCountryInitial()){
    getCountries();
 
  }

  getCountries() async {
    emit(CountriesLoading());
    final response = await api.getCountries();
    response.fold(
          (l) => emit(CountriesError()),
          (r) async {
        countries = r.data;
        CountryModel countryModel;
        countryModel=  await Preferences.instance.getcountryModel();
            if(countryModel.id!=0&&countries.isNotEmpty){
              print(countryModel.id.toString());
          selectedCountry1=countryModel;
         // emit(CountriesLoaded())

              // changeCountry(selectedCountry);

            }
        emit(CountriesLoaded());


      },
    );
  }

  void changeCountry(CountryModel? value) {
    selectedCountry=value;
    selectedCountry1=null;
    emit(CountriesLoaded());

  }
}
