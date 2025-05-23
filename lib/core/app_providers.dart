import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/features/auth/cubit/cubit/auth_cubit.dart';

class AppProviders {
  AppProviders._();
  static get providers => [
        BlocProvider(create: (context) => AuthCubit()),
        // Network
      ];
}
