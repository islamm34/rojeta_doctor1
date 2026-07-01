import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/auth_injector.dart';
import '../../../../core/di/injector.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can provide the BLoC locally
    return BlocProvider(
      create: (context) => injector<AuthBloc>()..add(LoadAuthEvent()),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthStatus.initial:
              case AuthStatus.loading:
                return const CircularProgressIndicator();
              case AuthStatus.loaded:
                return const Text('Data Loaded ✅');
              case AuthStatus.error:
                return Text('Error: \${state.message}');
            }
          },
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthBloc>().add(LoadAuthEvent()),
        child: const Icon(Icons.refresh),
       ),
    );
  }
}
