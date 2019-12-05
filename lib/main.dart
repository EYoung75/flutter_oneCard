import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./screens/tabScreen.dart";
import "./screens/settings.dart";
import "./screens/authScreen.dart";
import "./providers/placesProvider.dart";
import "./providers/auth.dart";
import "./providers/user.dart";
import "./providers/walletProvider.dart";

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
        ChangeNotifierProxyProvider<Auth, User>(
          builder: (ctx, auth, initData) => User(
            auth.getEmail,
            auth.userId,
            auth.token,
            auth.apiKey
          ),
        ),
        ChangeNotifierProxyProvider<Auth,WalletProvider>(
          builder: (ctx, auth, _) => WalletProvider(
            auth.userId,
            auth.token
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Places>(
          builder: (ctx, auth, _) => Places(
            auth.userId,
            auth.token
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
            fontFamily: "Barlow",
            textTheme: TextTheme(
              title: TextStyle(fontSize: 36, fontFamily: "BenchNine", color: Colors.white),
              subtitle: TextStyle(fontSize: 30, fontFamily: "Barlow", color: Colors.black),
              body1: TextStyle(fontSize: 24, fontFamily: "Barlow", color: Colors.white),
              body2: TextStyle(fontSize: 22, fontFamily: "BenchNine", color: Colors.black),
              button: TextStyle(fontSize: 20),
              display1: TextStyle(fontSize: 16, fontFamily: "BenchNine", color: Colors.white)
            ),
          ),
          routes: {
            "/home": (ctx) => TabScreen(),
            "/settings": (ctx) => Settings()
          },
          // home: CreateCardScreen()
          home: !auth.isAuth ? AuthScreen() : TabScreen(),
        ),
      ),
    );
  }
}
