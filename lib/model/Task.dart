class Task {
  final int id;
   String title;
  bool done;

  // Constructor
  Task({
    required this.id,
    required this.title,
    this.done = false, // Default value for done
  });

  // fromMap factory method
factory Task.fromMap(Map taskMap) {
   if (taskMap.containsKey('foundProduct')) {
      taskMap = taskMap['foundProduct']; // Access the nested task object
    }

  if (taskMap['id'] == null) {
    throw ArgumentError('ID cannot be null');
  }

  return Task(
    id: taskMap['id'] as int, // Ensure id is non-null
    title: taskMap['title'] ?? 'Untitled Task', // Provide a default value for title if null
    done: taskMap['done'] ?? false, // Default value for done
  );
}


  // toMap method if you need to convert it back to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  void Toggle() {
    done  =!done;
  }
}
