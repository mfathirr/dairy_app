import 'package:dairy_app/data/datasources/auth_local_datasource.dart';
import 'package:dairy_app/data/datasources/auth_remote_datasource.dart';
import 'package:dairy_app/data/model/response/auth_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource remote;
  LoginBloc(this.remote) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final response = await remote.login(event.email, event.password);
      response.fold((error) => emit(LoginFailed(message: error)), (data) {
        AuthLocalDatasource().saveAuthData(data);
        emit(LoginSuccess(data: data));
      });
    });
  }
}
