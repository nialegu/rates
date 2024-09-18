import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/screens/loader.dart';
import '../authorization/bloc/authorization_bloc.dart';
import 'bloc/rates_bloc.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverSafeArea(
          sliver: SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.update_rounded),
              onPressed: () => context.read<RatesBloc>().add(const RatesEvent.forceUpdate()),
            ),
            centerTitle: true,
            title: const Text("Rates"),
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                onPressed: () => context.read<AuthorizationBloc>().add(const AuthorizationEvent.loggingOut()),
              ),
              const SizedBox(width: 5),
            ],
          ),
        )
      ],
      body: CustomScrollView(
        slivers: [
          BlocBuilder<RatesBloc, RatesState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const SliverToBoxAdapter(child: Loader()),
                fetchFailed: (error) => SliverToBoxAdapter(
                  child: Center(
                    child: Text(error),
                  ),
                ),
                orElse: () => SliverList.builder(
                  itemBuilder: (context, index) => const ListTile(
                    title: Text("text"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
