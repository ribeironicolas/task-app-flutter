import 'package:flutter/material.dart';
import 'package:task_app/components/task.dart';
import 'package:task_app/data/task_dao.dart';
import 'package:task_app/data/task_inherited.dart';
import 'package:task_app/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.house, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          )
        ],
        title: const Text('Tasks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Loading')],
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Loading')],
                  ),
                );
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Loading')],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task task = items[index];
                          return task;
                        });
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline,
                            size: 128, color: Colors.grey),
                        Text(
                          'No tasks found',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('Error in fetch tasks');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (newContext) => FormScreen(
                  taskContext: context,
                ),
              ),
            ).then((value) => setState(() {}));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
