import 'package:app_dong_ho/main/account_detail/account.deltail.cubit.dart';
import 'package:app_dong_ho/main/account_detail/account.deltail.page.dart';
import 'package:app_dong_ho/main/bill/bill_detail/bill.detail.cubit.dart';
import 'package:app_dong_ho/main/bill/bill_detail/bill.detail.page.dart';
import 'package:app_dong_ho/main/bill/bill_history/bill.history.cubit.dart';
import 'package:app_dong_ho/main/bill/bill_history/bill.history.page.dart';
import 'package:app_dong_ho/main/buynow/buy.now.cubit.dart';
import 'package:app_dong_ho/main/buynow/buy.now.page.dart';
import 'package:app_dong_ho/main/cart/cart.cubit.dart';
import 'package:app_dong_ho/main/cart/cart.page.dart';
import 'package:app_dong_ho/main/clockdetail/clock.detail.cubit.dart';
import 'package:app_dong_ho/main/clockdetail/clock.detail.page.dart';
import 'package:app_dong_ho/main/home/component/data.page.model.dart';
import 'package:app_dong_ho/main/home/suggest/suggest.page.dart';
import 'package:app_dong_ho/main/payment/payment.page.dart';
import 'package:app_dong_ho/main/register/register.cubit.dart';
import 'package:app_dong_ho/main/register/register.page.dart';
import 'package:app_dong_ho/main/search/search.cubit.dart';
import 'package:app_dong_ho/main/search/search.page.dart';
import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_clock/service_clock.dart';
import 'main.router.constant.dart';
import 'main/login/login.cubit.dart';
import 'main/login/login.page.dart';
import 'main/main.page.dart';
import 'main/mian.cubit.dart';
import 'main/payment/payment.cubit.dart';
import 'main/splash/splash.page.dart';
import 'repository/authentication.repository.dart';
import 'package:rxdart/rxdart.dart';

import 'repository/repository_bill.dart';

final router = GoRouter(
  observers: [MyNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(create: (BuildContext context) => MainCubit(), child: const SplashPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerMain,
      builder: (context, state) => BlocProvider(create: (BuildContext context) => MainCubit(), child: const MainPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerLogin,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(authenticationRepository: context.read<AuthenticationRepository>()),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterCubit(authenticationRepository: context.read<AuthenticationRepository>()),
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerClockPage,
      builder: (context, state) {
        DataPageModel dataPageModel = DataPageModel(pageName: '', listData: []);
        dataPageModel = state.extra as DataPageModel;
        return SuggestPage(
          listClock: dataPageModel.listData,
          pageName: dataPageModel.pageName,
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerClockDetailPage,
      builder: (context, state) {
        ClockModel clockModel = ClockModel();
        clockModel = state.extra as ClockModel;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => ClockDetailCubit(
                clockRepository: context.read<ClockRepository>(),
                clockModel: clockModel,
              ),
            ),
          ],
          child: ClockDetailPage(
            clockModel: clockModel,
          ),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerSearch,
      builder: (context, state) {
        ClockTypeModel? clockTypeModel;
        if (state.extra != null && state.extra is ClockTypeModel) {
          clockTypeModel = state.extra as ClockTypeModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => SearchCubit(
                clockRepository: context.read<ClockRepository>(),
                clockTypeModel: clockTypeModel,
              ),
            ),
          ],
          child: const SearchPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBillDetail,
      builder: (context, state) {
        BillModel? billModel;
        if (state.extra != null && state.extra is BillModel) {
          billModel = state.extra as BillModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) =>
                  BillDetailCubit(billRepository: context.read<BillRepository>(), billModel: billModel ?? BillModel(listDetail: [])),
            ),
          ],
          child: const BillDetailPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBillHistory,
      builder: (context, state) {
        BillModel? billModel;
        if (state.extra != null && state.extra is BillModel) {
          billModel = state.extra as BillModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) =>
                  BillHistoryCubit(billRepository: context.read<BillRepository>(), billModel: billModel ?? BillModel(listDetail: [])),
            ),
          ],
          child: const BillHistoryPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerCartPage,
      builder: (context, state) {
        context.read<CartCubit>().resetValueSeclect();
        return const CartPage();
      },
    ),
    GoRoute(
      path: MainRouterPath.routerPayment,
      builder: (context, state) {
        DataSendBill dataSendBill = DataSendBill(billModel: BillModel(listDetail: []), listCart: []);
        if (state.extra != null && state.extra is DataSendBill) {
          dataSendBill = state.extra as DataSendBill;
        }
        return BlocProvider(
          lazy: false,
          create: (context) => PaymentCubit(billRepository: context.read<BillRepository>(), dataSendBill: dataSendBill),
          child: const PaymentPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerAccountDetail,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => AccountDetailCubit(authenticationRepository: context.read<AuthenticationRepository>()),
            ),
          ],
          child: const AccountDetailPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBuyNow,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => BuyNowCubit(
                  authenticationRepository: context.read<AuthenticationRepository>(),
                  clockRepository: context.read<ClockRepository>(),
                  cartItem: (state.extra != null && state.extra is CartItem) ? state.extra as CartItem : CartItem()),
            ),
          ],
          child: const BuyNowPage(),
        );
      },
    ),
  ],
);

class MyNavigatorObserver extends NavigatorObserver {
  static var listRoute = <String>[];
  static final BehaviorSubject<String> currentRouter = BehaviorSubject<String>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.add(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPush route ${listRoute.join(',')}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPop route ${listRoute.join(',')}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didRemove route ${listRoute.join(',')}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    listRoute.remove(oldRoute?.settings.name ?? '');
    listRoute.add(newRoute?.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didReplace route ${listRoute.join(',')}');
  }
}

extension RouterMain on BuildContext {
  void popUntilPath(String routePath) {
    final router = GoRouter.of(this);
    while (router.location != routePath) {
      if (!router.canPop()) {
        return;
      }

      debugPrint('Popping ${router.location}');
      router.pop();
    }
  }
}
