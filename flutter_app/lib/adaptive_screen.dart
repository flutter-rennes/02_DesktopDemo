import 'package:flutter/material.dart';
import 'package:flutter_app/details_screen.dart';
import 'package:flutter_app/master_screen.dart';

class AdaptiveScreenData extends InheritedWidget {
  AdaptiveScreenData({
    Key key,
    @required this.isLarge,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);
  bool isLarge;

  static AdaptiveScreenData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AdaptiveScreenData);
  }

  @override
  bool updateShouldNotify(AdaptiveScreenData old) => isLarge != old.isLarge;
}

class AdaptiveScreen extends StatelessWidget {
  AdaptiveScreen({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final isLarge = mediaQueryData.size.width > 600;
    return AdaptiveScreenData(
      isLarge: isLarge,
      child: isLarge ? _AdaptiveOnLargeScreen() : child,
    );
  }
}

class _AdaptiveOnLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master-Detail'),
      ),
      body: Row(
        children: <Widget>[
          Material(
            elevation: 4,
            child: SizedBox(
              width: 600,
              child: MasterScreen(),
            ),
          ),
          Expanded(
            child: DetailsScreen(),
          ),
        ],
      ),
    );
  }
}
