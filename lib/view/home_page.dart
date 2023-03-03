import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_start_pack/dialog/add_item_dialog.dart';
import 'package:todo_start_pack/model/item.dart';
import 'package:todo_start_pack/providers.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

// generate a uuid now:
// https://www.uuidgenerator.net/version4
class _MyHomePageState extends ConsumerState<MyHomePage> {
  var items = <Item>[];

  @override
  void initState() {
    super.initState();
    getItems();
  }

  Future<void> getItems() async {
    final collection =
        await FirebaseFirestore.instance.collection("items").get();

    setState(() {
      collection.docs.forEach((element) {
        items.add(Item(id: element.id, value: element.data()['item']));
      });
    });
  }

  Future<void> addItem(Item item) async {
    items = [];

    await FirebaseFirestore.instance
        .collection("items")
        .add({'item': item.value});

    final collection =
        await FirebaseFirestore.instance.collection("items").get();

    setState(() {
      collection.docs.forEach((element) {
        items.add(Item(id: element.id, value: element.data()['item']));
      });
    });
  }

  Future<void> updateItem(Item item) async {
    items = [];

    await FirebaseFirestore.instance
        .collection("items")
        .doc(item.id)
        .update({'item': item.value});

    final collection =
        await FirebaseFirestore.instance.collection("items").get();

    setState(() {
      collection.docs.forEach((element) {
        items.add(Item(id: element.id, value: element.data()['item']));
      });
    });
  }

  Future<void> deleteItem(Item item) async {
    items = [];
    await FirebaseFirestore.instance.collection("items").doc(item.id).delete();
    final collection =
        await FirebaseFirestore.instance.collection("items").get();

    setState(() {
      collection.docs.forEach((element) {
        items.add(Item(id: element.id, value: element.data()['item']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                final themeMode = ref.read(themeModeProvider.notifier).state;
                if (themeMode == ThemeMode.light) {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                } else if (themeMode == ThemeMode.dark) {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                }
              },
              child: ref.watch(themeModeProvider) == ThemeMode.light
                  ? const Text('Light')
                  : const Text('Dark')),
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text(items[index].value),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddUpdateItemDialog(
                                value: items[index],
                                onValue: (item) {
                                  updateItem(item);
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit Item',
                        ),
                        IconButton(
                          onPressed: () {
                            deleteItem(items[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          tooltip: 'Delete Item',
                        ),
                      ],
                    )),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddUpdateItemDialog(
                    onValue: (item) {
                      addItem(item);
                    },
                  ));
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
