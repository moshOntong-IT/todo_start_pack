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
  final items = <Item>[
    Item(id: '95a11f80-7029-4012-8714-3a5a1ed7b366', value: '🛒 Buy groceries'),
    Item(id: 'b3b4c1c0-5b1f-4b2e-9c1c-3a5a1ed7b366', value: '📚 Read a book'),
    Item(id: 'c3b4c1c0-5b1f-4b2e-9c1c-3a5a1ed7b366', value: '🏃‍♂️ Exercise'),
  ];

  Future<void> addItem(Item item) async {
    // Simulate a network request to add an item to the list
    // Future.delayed method is a fake network request that takes 1 second
    await Future.delayed(const Duration(seconds: 1));

    /// Generate a unique id for the item.
    /// In this example, we use the uuid package.
    /// But in firebase, we do not need to generate a unique id.
    /// Since, the firebase automatically generates a unique id for each document.
    const uuid = Uuid();
    setState(() {
      items.add(Item(id: uuid.v4(), value: item.value));
    });

    // TODO: delete the simulated network request above and do a network request
    // // Reset the items list
    // items = [];
    // to add an item to the list by using the Firebase
    //For example you can use the following code:
    // await FirebaseFirestore.instance.collection([your_collection_name]).add({'item': item.value});
    // Then you can use the following code to get the list of items:
    // FirebaseFirestore.instance.collection([your_collection_name]).get().then((value) {
    //   value.docs.forEach((element) {
    //     items.add(Item(id: element.id, value: element.data()['item']));
    //   });
    // });
  }

  Future<void> updateItem(Item item) async {
    // Simulate a network request to update an item in the list
    // Future.delayed method is a fake network request that takes 1 second
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      items[items.indexWhere((element) => element.id == item.id)] = item;
    });

    // TODO: delete the simulated network request above and do a network request
    // // Reset the items list
    // items = [];
    // to update an item in the list by using the Firebase
    // For example you can use the following code:
    // await FirebaseFirestore.instance.collection([your_collection_name]).doc(item.id).update({'item': item.value});
    // Then you can use the following code to get the list of items:
    // FirebaseFirestore.instance.collection([your_collection_name]).get().then((value) {
    //   value.docs.forEach((element) {
    //     items.add(Item(id: element.id, value: element.data()['item']));
    //   });
    // });
  }

  Future<void> deleteItem(Item item) async {
    // Simulate a network request to delete an item from the list
    // Future.delayed method is a fake network request that takes 1 second
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      items.removeWhere((element) => element.id == item.id);
    });

    // TODO: delete the simulated network request above and do a network request
    // // Reset the items list
    // items = [];
    // to delete an item from the list by using the Firebase
    // For example you can use the following code:
    // await FirebaseFirestore.instance.collection([your_collection_name]).doc(item.id).delete();
    // Then you can use the following code to get the list of items:
    // FirebaseFirestore.instance.collection([your_collection_name]).get().then((value) {
    //   value.docs.forEach((element) {
    //     items.add(Item(id: element.id, value: element.data()['item']));
    //   });
    // });
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
