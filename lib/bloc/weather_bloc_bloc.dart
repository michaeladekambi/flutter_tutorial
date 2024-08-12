import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_tutorial/bloc/weather_bloc_event.dart';
import 'package:weather_app_tutorial/bloc/weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final String _apiKey = 'bce24e31b2938b18aefcc394811dbb22';

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(_apiKey, language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(
            event.position.longitude,
            event. position.latitude,
        ); // Fetch weather data
        emit(WeatherBlocSuccess(weather)); // Pass fetched data to the success state
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
