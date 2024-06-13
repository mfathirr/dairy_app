import 'package:bloc/bloc.dart';
import 'package:dairy_app/data/datasources/auth_remote_datasource.dart';
import 'package:meta/meta.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource remote;
  LogoutBloc(this.remote) : super(LogoutInitial()) {
    on<LogoutButtonPressed>((event, emit) {
      // TODO: implement event handler
    });
  }
}
