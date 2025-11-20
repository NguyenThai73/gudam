// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors
// import 'package:app_mobile/main.router.dart';
// import 'package:app_mobile/main/cart/cart.cubit.dart';
// import 'package:app_mobile/main/favorite/favorite.cubit.dart';
import 'package:app_dong_ho/main.router.dart';
import 'package:app_dong_ho/main/cart/cart.cubit.dart';
import 'package:app_dong_ho/main/favorite/favorite.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/error/error.cubit.state.dart';
import '../../constants/component/error/error.dialog.dart';
import '../../main.router.constant.dart';
import '../../repository/authentication.repository.dart';
import '../authentication/authentication.bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  bool isActiveCall = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoLogin(context.read<AuthenticationRepository>());
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorCubit, ErrorState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ErrorStatus.showing) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              child: state.widget,
            ),
          );
        }
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) async {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              context.popUntilPath('/');
              await context.read<FavoriteCubit>().getData();
              await context.read<CartCubit>().getData();
              context.push(MainRouterPath.routerMain);
              break;
            case AuthenticationStatus.unauthenticated:
              context.popUntilPath('/');
              await context.read<FavoriteCubit>().cleanData();
              await context.read<CartCubit>().cleanData();
              context.push(MainRouterPath.routerLogin);
              break;
            default:
          }
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 209, 255, 255),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage("assets/logo.jpeg"), fit: BoxFit.cover)),
                        ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    switch (state) {
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      default:
    }
  }

  void checkInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = prefs.getString('receiverInfo');
    if (data != null) {
      isActiveCall = true;
      prefs.remove('receiverInfo');
    }
  }

  void autoLogin(AuthenticationRepository repo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? pass = prefs.getString("pass");
    if (email != "" && pass != "") {
      try {
        var user = await repo.login(email: email!, password: pass!);
        // if (user != null) {
        //   repo.updateUer(user);
        // } else {
        //   repo.requestEmptyUser();
        // }
      } catch (e) {
        print("Eorro: $e");
        repo.requestEmptyUser();
      }
    } else {
      repo.requestEmptyUser();
    }
    
  }
}
