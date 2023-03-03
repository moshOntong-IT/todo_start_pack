import 'package:flutter/material.dart';
import 'package:todo_start_pack/model/item.dart';

typedef OnValueCallback = void Function(Item item);

class AddUpdateItemDialog extends StatefulWidget {
  const AddUpdateItemDialog({
    super.key,
    required this.onValue,
    this.value,
  });

  final OnValueCallback onValue;
  final Item? value;

  @override
  State<AddUpdateItemDialog> createState() => _AddUpdateItemDialogState();
}

class _AddUpdateItemDialogState extends State<AddUpdateItemDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.value != null) {
      _controller.text = widget.value!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Item',
          hintText: 'e.g. Buy groceries',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (widget.value != null) {
              widget
                  .onValue(Item(id: widget.value!.id, value: _controller.text));
            } else {
              widget.onValue(Item(id: '', value: _controller.text));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
