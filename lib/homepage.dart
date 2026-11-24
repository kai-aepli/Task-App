import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/src/framework.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 140, 255),
        title: const Text("ToDo List", style: TextStyle(color: Colors.white)),
        actions: [TextButton(onPressed: () {FirebaseAuth.instance.signOut();}, child: Text("Sign out", style: TextStyle(color: Colors.white)))],
      ),
      body: Material(
        child: (
          Expanded(
            child:
            Stack(
              children: [
                MainBody(), 
                Positioned(
                  bottom: 50,
                  left: 40,
                  child:
                  Row(
                    children: [
                      Text("Separate completed & uncompleted ToDos  "),
                      Switch(
                        value: true, 
                        onChanged: (value) {
                          value = false;
                        }
                      ),
                    ],
                  ) 
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    child: BottomNavigationWidget(),
                  ),
                )
              ]
            )
          )
        ),
      ),
    );
  }
}

class MainBody extends ConsumerWidget{
  MainBody({super.key});

  final textfieldcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(toDoProvider);

    return Container(
     margin: EdgeInsets.only(bottom:20),
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          todos.insert(newIndex, todos[oldIndex]);
          if (oldIndex < newIndex) {
            todos.removeAt(oldIndex);
          }
          else {
            todos.removeAt(oldIndex + 1);
          }
        },
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ReorderableDragStartListener(key: ValueKey(todos[index]), index: index, child: ToDoTile(index: index, todo: todos[index]));
        }
      )
    );
  }
}

class ToDoTile extends ConsumerStatefulWidget {
  final int index;
  final ToDo todo;
  const ToDoTile({super.key, required this.index, required this.todo});

  @override
  ConsumerState<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends ConsumerState<ToDoTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.text);
  }

  @override
  void didUpdateWidget(ToDoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo.text != widget.todo.text) {
      _controller.text = widget.todo.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editingIndex = ref.watch(editingIndexProvider);
    final isEditing = editingIndex == widget.index;
    return Material(
      color: widget.todo.isCompleted ? Color.fromARGB(75, 200, 200, 200) : null,
      child: ListTile(
        leading: Checkbox(
          value: widget.todo.isCompleted, 
          onChanged: (_) => ref.read(toDoProvider.notifier).toggle(widget.index) 
        ),
        title: isEditing && !widget.todo.isCompleted
        ? Focus(
          onFocusChange: (hasFocus) => {
            if (!hasFocus) {
              ref.read(editingIndexProvider.notifier).state = null
            }
          },
          child: TextField(
            autofocus: true,
            controller: _controller,
            onSubmitted: (text) {
              ref.read(toDoProvider.notifier).update(widget.index, text);
              ref.read(editingIndexProvider.notifier).state = null; 
            }
          )
        )
        : Text(
            widget.todo.text,
            style: TextStyle(
              decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null,
              color: widget.todo.isCompleted ? Colors.grey : Colors.black
            )
          ),
        trailing: 
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => ref.read(toDoProvider.notifier).remove(widget.index),
          ),
        enabled: !widget.todo.isCompleted,
        onTap: () {
          ref.read(editingIndexProvider.notifier).state = widget.index;
        }
      )
    );
  }
}

class BottomNavigationWidget extends ConsumerWidget {
  BottomNavigationWidget({super.key});

  void handleSubmit(String text) {
      bottomcontroller.clear(); 
  }
  final bottomcontroller = TextEditingController();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsetsGeometry.only(bottom: 50, right: 40),
      alignment: Alignment.bottomRight,
      child: Column(
      children: [
        Padding(
         padding:EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            tooltip: "Well, I don't plan on working here anymore...",
            onPressed: () {
              // WORK HERE NEVER-
            },
            label: const Text("Add new To-Do-List"),
            icon: const Icon(Icons.add)
          ),       
        ),
        SizedBox(
          width: 200,
            child: Tooltip(
              message: 'Submit to add your new Task',
              child: TextField(
                controller: bottomcontroller,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Todo"),
                onSubmitted: (String text) {
                  if (text.isNotEmpty) {
                    ref.read(toDoProvider.notifier).add(text);
                    bottomcontroller.clear();
                  }
                }
              ),
            )
          ),
        ]
      )
    );
  }
}