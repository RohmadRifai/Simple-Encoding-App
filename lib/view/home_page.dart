import 'package:flutter/material.dart';
import 'package:test_application/logic/logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputController1 = TextEditingController();
  final inputController2 = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Encoding')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('INPUT'),
            const SizedBox(height: 10),
            input(inputController1, "Transform (Use 'H', 'V', or number)"),
            const SizedBox(height: 10),
            input(inputController2, 'Characters'),
            const SizedBox(height: 10),
            button(),
            const SizedBox(height: 10),
            title('OUTPUT'),
            const SizedBox(height: 10),
            output()
          ],
        ),
      ),
    );
  }

  Widget title(String name) => Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      );

  Widget input(TextEditingController controller, String hintText) => TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            hintText: hintText),
      );

  Widget button() => Row(
        children: [
          ElevatedButton(
              child: const Text('Result'),
              onPressed: () {
                result = SimpleEncoding()
                    .process(inputController1.text, inputController2.text);
                setState(() {});
              }),
          const SizedBox(width: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Clear'),
              onPressed: () {
                inputController1.clear();
                inputController2.clear();
                result = '';
                setState(() {});
              }),
        ],
      );

  Widget output() => Text(result);
}
