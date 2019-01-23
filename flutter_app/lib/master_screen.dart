import 'package:flutter/material.dart';
import 'package:flutter_app/adaptive_screen.dart';
import 'package:flutter_app/details_screen.dart';
import 'package:flutter_app/main.dart';

class MasterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLarge = AdaptiveScreenData.of(context).isLarge;
    return isLarge ? _ItemList() : _MasterOnSmallScreen();
  }
}

class _MasterOnSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master'),
      ),
      body: _ItemList(),
    );
  }
}

class _ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemStore = ItemStore.of(context);
    final items = itemStore.items;
    final isLarge = AdaptiveScreenData.of(context).isLarge;
    final selectedId = itemStore.selectedId;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text('${item.id}'),
          ),
          title: Text(item.fullName),
          selected: selectedId == item.id,
          onTap: () {
            itemStore.setSelectedId(item.id);
            if (!isLarge) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AdaptiveScreen(
                      child: DetailsScreen(),
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
