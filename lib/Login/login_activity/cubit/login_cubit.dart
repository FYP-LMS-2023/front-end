// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:formz/formz.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit(this._authenticationRepository) : super(const LoginState());

//   final AuthenticationRepository _authenticationRepository;

//   void loginErpChanged(String customerCode) {
//     final _erp = LoginErp.dirty(erp);
//     emit(state.copyWith(
//       erp: _erp,
//       status: Formz.validate([state.password, _erp]),
//     ));
//   }

//   void loginPasswordChanged(String password) {
//     final _password = LoginPassword.dirty(password);
//     emit(state.copyWith(
//       password: _password,
//       status: Formz.validate([_password, state.erp]),
//     ));
//   }

//   void togglePassword() {
//     if (state.isPasswordVisible) {
//       emit(state.copyWith(isPasswordVisible: false));
//     } else {
//       emit(state.copyWith(isPasswordVisible: true));
//     }
//   }

//   Future<void> login() async {
//     if (state.status.isValidated) {
//       emit(state.copyWith(
//         status: FormzStatus.submissionInProgress,
//       ));
//       try {
//         await _authenticationRepository.login(
//           state.erp.value,
//           state.password.value,
//         );
//         emit(state.copyWith(
//           status: FormzStatus.submissionSuccess,
//         ));
//       } catch (_) {
//         emit(state.copyWith(
//           status: FormzStatus.submissionFailure,
//         ));
//       }
//     } else {
//       const _erp = LoginErp.dirty('');
//       const _password = LoginPassword.dirty('');
//       emit(state.copyWith(
//         erp: _erp,
//         password: _password,
//       ));
//     }
//   }
// }
