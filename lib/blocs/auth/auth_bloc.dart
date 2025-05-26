import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await Future.delayed(Duration(seconds: 1));

    if (event.email == 'customer@test.com' && event.password == '123456') {
      emit(AuthAuthenticated(user: User(
        id: '1',
        email: event.email,
        name: 'Customer User',
        role: UserRole.customer,
      )));
    } else if (event.email == 'provider@test.com' && event.password == '123456') {
      emit(AuthAuthenticated(user: User(
        id: '2',
        email: event.email,
        name: 'Service Provider',
        role: UserRole.serviceProvider,
      )));
    } else {
      emit(AuthError(message: 'Invalid email or password'));
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());


    await Future.delayed(Duration(seconds: 1));

    emit(AuthAuthenticated(user: User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: event.email,
      name: event.name,
      role: event.role,
    )));
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }
}