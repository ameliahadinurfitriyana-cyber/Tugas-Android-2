import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Counter")),
      body: Center(
        child: Text("$counter", style: const TextStyle(fontSize: 40)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "decrement",
            onPressed: () {
              ref.read(counterProvider.notifier).state--;
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "increment",
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "reset",
            onPressed: () {
              ref.read(counterProvider.notifier).state = 0;
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
