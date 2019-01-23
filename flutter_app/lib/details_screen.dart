import 'package:flutter/material.dart';
import 'package:flutter_app/adaptive_screen.dart';
import 'package:flutter_app/main.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = AdaptiveScreenData.of(context).isLarge;
    return isLarge ? _Details() : _DetailsOnSmallScreen();
  }
}

class _DetailsOnSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: _Details(),
    );
  }
}

class _Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemStore = ItemStore.of(context);
    final selectedId = itemStore.selectedId;
    final item = itemStore.items.firstWhere(
      (x) => x.id == selectedId,
      orElse: () => null,
    );

    if (item == null) {
      return Center(
        child: Text('Nothing is selected'),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('${item.id}'),
            Text('${item.firstName}'),
            Text('${item.lastName}'),
            Text('${item.email}'),
          ],
        ),
      );
    }
  }
}
