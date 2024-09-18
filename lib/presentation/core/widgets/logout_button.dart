import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/constants/routing_string_constants.dart';
import '../../features/authorization/bloc/authorization_bloc.dart';
import '../../features/rates/bloc/rates_bloc.dart';
import 'custom_loader.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        state.whenOrNull(
          notLoggedIn: () {
            context.read<RatesBloc>().pauseStream();
            return context.pushNamed(RoutingStringConstants.authName);
          },
        );
      },
      builder: (context, state) => IconButton(
        icon: state.maybeWhen(
            orElse: () => const Icon(Icons.exit_to_app_rounded),
            loading: () => const CustomLoader(
                  raduis: 10,
                )),
        onPressed: () {
          context
              .read<AuthorizationBloc>()
              .add(const AuthorizationEvent.loggingOut());
        },
      ),
    );
  }
}
