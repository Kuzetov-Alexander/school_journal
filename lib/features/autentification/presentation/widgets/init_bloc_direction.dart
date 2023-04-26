import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';

Widget initBlocDirection({required Widget unAuthenticationWidget}) {
  return BlocConsumer<AuthBloc, BlocAuthState>(
    listener: (context, state) {
      if (state is Authenticated) {
        context.go('/Groups');
      }
      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
          ),
        );
      }
    },
    builder: (context, state) {
      if (state is AuthLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return unAuthenticationWidget;
    },
  );
}
