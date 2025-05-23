import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Initial());

  Future<void> register(
      {required String email, required String password}) async {
    emit(Loading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        //   'email': user.email,
        //   'uid': user.uid,
        // });

        emit(AuthSuccess(userEmail: user.email ?? ''));
      } else {
        emit(Error('Registration Failed. Try again later!'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown Firebase error occurred.';
      }
      emit(Error(errorMessage));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(Loading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        emit(AuthSuccess(userEmail: user.email ?? ''));
      } else {
        emit(Error('Login Failed. Try again later!'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Invalid email or password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown Firebase error occurred.';
      }
      emit(Error(errorMessage));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
