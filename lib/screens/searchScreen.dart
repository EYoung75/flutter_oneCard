import "package:flutter/material.dart";
import "../widgets/background.dart";
import "../providers/walletProvider.dart";
import "package:provider/provider.dart";

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<WalletProvider>(context).userSearch();
  }
  @override
  Widget build(BuildContext context) {
    return Background(
      _loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Container(
                  height: 40,
                  margin: EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                    right: 40,
                    left: 20,
                  ),
                  child: TextFormField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                      ),
                      hasFloatingPlaceholder: false,
                      labelText: "Search",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
