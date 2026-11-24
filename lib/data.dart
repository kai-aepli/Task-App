import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final editingIndexProvider = StateProvider<int?>((ref) => null);

class ToDo {
  final String text;
  final bool isCompleted;

  const ToDo({
    required this.text,
    this.isCompleted = false,
  });

  ToDo copyWith({
    String? text,
    bool? isCompleted,
  }) {
    return ToDo(
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

@riverpod
class ToDoNotifier extends Notifier<List<ToDo>> {
  @override
  List<ToDo> build() {
    return [];
  }

  void add(String text) {
      state = [...state, ToDo(text: text)];
  }

  void toggle(int index) {
    final updated = [...state];
    updated[index] = updated[index].copyWith(isCompleted: !updated[index].isCompleted);
    state = updated;
  }

  void update(int index, String newText) {
    if (newText.isEmpty) return;

    final updated = [...state];
      updated[index] = updated[index].copyWith(text: newText);
      state = updated;
  }
  

  void remove(int index) {
    state = [...state]..removeAt(index);
  }
}
  
final toDoProvider = NotifierProvider<ToDoNotifier, List<ToDo>>(ToDoNotifier.new);