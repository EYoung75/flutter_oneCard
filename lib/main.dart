import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "./screens/tabScreen.dart";
import "./providers/placesProvider.dart";
import "./providers/auth.dart";
import "./screens/authScreen.dart";
import "./screens/home.dart";

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
          home: auth.isAuth ? TabScreen() : AuthScreen(),
        ),
      ),
    );
  }
}
