import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 2,
      initialIndex: 0,
    );

    final submittedValue = useState<String?>(null);

    final tabBar = TabBar(
      controller: tabController,
      onTap: (val) {},
      tabs: ["First Page", "Second Page"]
          .map(
            (e) => Tab(
              text: e,
              height: 45,
            ),
          )
          .toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World"),
        bottom: tabBar,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          FirstWidget(
            submit: (value) {
              submittedValue.value = value;
              //tabController.index = 1;
            },
          ),
          PreviewWidget(
            submittedValue.value,
          ),
        ],
      ),
    );
  }
}

class FirstWidget extends HookConsumerWidget {
  final Function(String value) submit;

  const FirstWidget({
    super.key,
    required this.submit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textC = useTextEditingController();

    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: textC,
          ),
        ),
        TextButton(
          onPressed: () {
            submit(textC.text);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}

class PreviewWidget extends HookConsumerWidget {
  final String? value;

  const PreviewWidget(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (value == null) {
      return const Text("No Value Submitted");
    } else {
      return Text("Value Input: $value");
    }
  }
}
