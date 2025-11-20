import 'package:app_dong_ho/main/account/account.cubit.dart';
import 'package:app_dong_ho/main/cart/cart.cubit.dart';
import 'package:app_dong_ho/main/favorite/favorite.cubit.dart';
import 'package:app_dong_ho/repository/repository_bill.dart';
import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/component/error/error.wrapper.dart';
import 'constants/component/loading/loading.wrapper.dart';
import 'main.router.dart';
import 'main/authentication/authentication.bloc.dart';
import 'main/cubit/user.change.cubit.dart';
import 'repository/authentication.repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final ClockRepository clockRepository;
  final BillRepository billRepository;

  MyApp({super.key})
      : authenticationRepository = AuthenticationRepository(),
        clockRepository = ClockRepository(),
        billRepository = BillRepository();

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: clockRepository),
        RepositoryProvider.value(value: billRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider(create: (_) => UserChangeCubit(authenticationRepository)),
          BlocProvider(
            lazy: false,
            create: (context) => FavoriteCubit(authenticationRepository, clockRepository),
          ),
          BlocProvider(create: (_) => UserChangeCubit(authenticationRepository)),
          BlocProvider(
            lazy: false,
            create: (context) => CartCubit(clockRepository: clockRepository, authenticationRepository: authenticationRepository),
          ),
          BlocProvider(
            create: (context) => AccountCubit(authenticationRepository: authenticationRepository),
          ),
        ],
        child: ErrorWrapper(
          child: LoadingWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue, navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.white)),
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
