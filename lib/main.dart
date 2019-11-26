import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "./screens/tabScreen.dart";
import "./providers/placesProvider.dart";
import "./providers/auth.dart";
import "./screens/authScreen.dart";
import "./providers/user.dart";
import "./screens/network.dart";


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Places(),
        ),
        ChangeNotifierProvider.value(
          value: WalletProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, User>(
          builder: (ctx, auth, initData) => User(
            auth.getEmail,
            auth.userId,
            auth.token,
          ),
        )
        // ChangeNotifierProvider.value(
        //   value: User(),
        // )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OneCard',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(47, 95, 114, 1),
            accentColor: Color.fromRGBO(255, 233, 214, 1),
            fontFamily: "Maven",
          ),
          // routes: {
          //   "/home": (ctx) => TabScreen(),
          // },
          // home: Network()
          home: !auth.isAuth ? AuthScreen() : TabScreen(),





          //       : Consumer<User>(
          //           builder: (ctx, user, _) =>
          //               user.fetchUserProfile() == true ? TabScreen() : CreateCardScreen(),
          //         ),
          // ),
        ),
      ),
    );
  }
}
