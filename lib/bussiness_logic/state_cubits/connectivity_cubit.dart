import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_state.dart';



class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());

  late String connected;

  connectivityListener(){
    var logger = Logger();
    var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      logger.t(result.name);
      connected = result.name;
      emit(ConnectivityListen());
    });
  }


}
