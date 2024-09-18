import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../rates/bloc/rates_bloc.dart';
import '/data/constants/routing_string_constants.dart';
import '../../core/widgets/app_text_field.dart';
import 'bloc/authorization_bloc.dart';

class AuthorizationScreen extends StatelessWidget {
  AuthorizationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) => state.whenOrNull(
        loggedIn: () {
          if (context.canPop()) {
            context.read<RatesBloc>().resumeStream();
            return context.pop();
          } else {
            return context.goNamed(RoutingStringConstants.ratesName);
          }
        },
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Center(
                    heightFactor: 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Welcome back!",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 50),
                        AppTextFormField(
                          labelText: "Login",
                          textEditingController: _loginController,
                          validator: (value) {
                            if (value == null) return "Please, fill this field";
                            if (value.isEmpty || value.length < 3) {
                              return "Please, fill this field";
                            }
                            return null;
                          },
                          errorText: state.whenOrNull(
                              authFailed: (error) => error.toString()),
                        ),
                        const SizedBox(height: 25),
                        AppTextFormField(
                          labelText: "Password",
                          textEditingController: _passwordController,
                          needObscure: true,
                          validator: (value) {
                            if (value == null) return "Please, fill this field";
                            if (value.isEmpty || value.length < 3) {
                              return "Please, fill this field";
                            }
                            return null;
                          },
                          errorText: state.whenOrNull(
                              authFailed: (error) => error.toString()),
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthorizationBloc>().add(
                                  AuthorizationEvent.loggingIn(
                                      _loginController.text,
                                      _passwordController.text));
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                          child: state.maybeWhen(
                            orElse: () => const Text("Sign in"),
                            loading: () => const SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
