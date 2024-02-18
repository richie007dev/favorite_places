import 'package:flutter/material.dart';

class NewPlace extends StatelessWidget {
  const NewPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 12,
                    ),
                    Text('Add Place')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
