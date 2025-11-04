import 'package:flutter/material.dart';

class WaterDialog extends StatelessWidget {
  final void Function(int water) onSubmit;

  const WaterDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text('Add Water'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter water (oz)"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            final text = int.tryParse(controller.text.trim()) ?? 0;
            onSubmit(text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
