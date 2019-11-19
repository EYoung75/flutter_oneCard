import "package:flutter/material.dart";
import 'package:one_card_revisited/screens/createCard.dart';
import "package:provider/provider.dart";
import "./screens/tabScreen.dart";
import "./providers/placesProvider.dart";
import "./providers/auth.dart";
import "./screens/authScreen.dart";
import "./screens/home.dart";
import "./providers/user.dart";

void main() => runApp(MyApp());

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
        ChangeNotifierProxyProvider<Auth, User>(
          builder: (ctx, auth, initData) => User(
            auth.email,
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
            fontFamily: "Roboto",
          ),
          // routes: {
          //   "/home": (ctx) => TabScreen(),
          // },
          home: !auth.isAuth
              ? AuthScreen()
              : Consumer<User>(
                  builder: (ctx, user, _) =>
                      user.userCard != null ? TabScreen() : CreateCardScreen(),
                ),
        ),
      ),
    );
  }
}
