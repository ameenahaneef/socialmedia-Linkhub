import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/homepeople.dart';
import 'package:socialmedia/application/models/homepost.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeDetails>((event, emit)async {
      emit(HomeLoading());
      try {
        final  res=await HomeService().fetchHomeDetails();
        print('hiiiii');
      emit(HomeLoaded(res));
      } catch (e) {
        emit(HomeError('failed to get posts globally'));
      }
      
    });
  }
}
