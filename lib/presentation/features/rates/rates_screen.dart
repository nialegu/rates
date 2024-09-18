import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/screens/loader_screen.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widgets/logout_button.dart';
import 'bloc/rates_bloc.dart';
import 'widgets/rate_tile.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatesBloc, RatesState>(
      listener: (context, state) => state.whenOrNull(
        fetchFailed: (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kDebugMode ? error.toString() : "Data could not be updated",
              maxLines: 5,
            ),
          ),
        ),
      ),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverSafeArea(
            sliver: SliverAppBar(
              leading: BlocBuilder<RatesBloc, RatesState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.update_rounded,
                      color: state.whenOrNull(
                        loading: () => AppColors.grey,
                      ),
                    ),
                    onPressed: () => state.maybeWhen(
                      orElse: () => context
                          .read<RatesBloc>()
                          .add(const RatesEvent.forceUpdate()),
                      loading: () => {},
                    ),
                  );
                },
              ),
              centerTitle: true,
              title: const Text("Rates"),
              actions: const [
                LogoutButton(),
                SizedBox(width: 5),
              ],
            ),
          )
        ],
        body: BlocBuilder<RatesBloc, RatesState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const LoaderScreen(),
              orElse: () => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.greyLight,
                ),
                itemCount: context.read<RatesBloc>().cachedRates.length,
                itemBuilder: (context, index) => RateTile(
                    rate: context.read<RatesBloc>().cachedRates[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
