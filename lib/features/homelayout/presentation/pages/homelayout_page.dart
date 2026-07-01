import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/homelayout_injector.dart';
import '../../../../core/di/injector.dart';
import '../bloc/homelayout_bloc.dart';
import '../bloc/homelayout_event.dart';
import '../bloc/homelayout_state.dart';

class HomelayoutPage extends StatelessWidget {
  const HomelayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can provide the BLoC locally
    return BlocProvider(
      create: (context) => injector<HomelayoutBloc>()..add(LoadHomelayoutEvent()),
      child: const HomelayoutView(),
    );
  }
}

class HomelayoutView extends StatelessWidget {
  const HomelayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homelayout')),
      body: Center(
        child: BlocBuilder<HomelayoutBloc, HomelayoutState>(
          builder: (context, state) {
            switch (state.status) {
              case HomelayoutStatus.initial:
              case HomelayoutStatus.loading:
                return const CircularProgressIndicator();
              case HomelayoutStatus.loaded:
                return const Text('Data Loaded ✅');
              case HomelayoutStatus.error:
                return Text('Error: \${state.message}');
            }
          },
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomelayoutBloc>().add(LoadHomelayoutEvent()),
        child: const Icon(Icons.refresh),
       ),
    );
  }
}
