import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/services.dart';
import 'package:flutter_app/adaptive_screen.dart';
import 'package:flutter_app/data/item.dart';
import 'package:flutter_app/master_screen.dart';

void main() {
  // Desktop platforms are not recognized as valid targets by
  // Flutter; force a specific target to prevent exceptions.
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

Future<List<Item>> _loadItems() async {
  final json = await rootBundle.loadString('assets/data.json');
  return itemFromJson(json);
}

class App extends StatefulWidget {
  App({
    Key key,
    @required this.child,
    @required this.items,
  });
  final Widget child;
  final List<Item> items;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedId;

  @override
  void initState() {
    _selectedId = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ItemStore._(
      child: widget.child,
      items: widget.items,
      selectedId: _selectedId,
      setSelectedId: setSelectedId,
    );
  }

  void setSelectedId(int id) {
    setState(() {
      _selectedId = id;
    });
  }
}

class ItemStore extends InheritedWidget {
  const ItemStore._({
    Key key,
    @required this.items,
    @required this.selectedId,
    @required this.setSelectedId,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final List<Item> items;
  final int selectedId;
  final void Function(int id) setSelectedId;

  static ItemStore of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ItemStore);
  }

  @override
  bool updateShouldNotify(ItemStore old) {
    return items != old.items || selectedId != old.selectedId;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: _loadItems(),
      builder: (context, snapshot) {
        Widget content;
        if (!snapshot.hasData) {
          content = Center(child: CircularProgressIndicator());
        } else {
          content = AdaptiveScreen(
            child: MasterScreen(),
          );
        }
        return App(
          items: snapshot.data,
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: content,
          ),
        );
      },
    );
  }
}
