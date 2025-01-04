void main() {
  TaskManager taskManager = TaskManager();
  Task task1 = Task(
      id: "1",
      title: "Task 1",
      description: "Task 1 Description",
      status: Status.Pending,
      dueDate: DateTime.now());
  Task task2 = Task(
      id: "2",
      title: "Task 2",
      description: "Task 2 Description",
      status: Status.Pending,
      dueDate: DateTime.now());
  Task task3 = Task(
      id: "3",
      title: "Task 3",
      description: "Task 3 Description",
      status: Status.Pending,
      dueDate: DateTime.now());
  taskManager.addNewTask(task1);
  taskManager.addNewTask(task2);
  taskManager.addNewTask(task3);
  taskManager.updateTaskStatus(task1, Status.In_Progress);
  taskManager.updateTaskStatus(task2, Status.In_Progress);
  taskManager.updateTaskStatus(task3, Status.Completed);
  taskManager.viewTask(task1);
  taskManager.viewTask(task2);
  taskManager.viewTask(task3);
}

class TaskManager {
  List<Task>? groupedByStausTasks = [];
  addNewTask(Task task) {
    groupedByStausTasks!.add(task);
  }

  updateTaskStatus(Task task, Status status) {
    task.status = status;
  }

  viewTask(Task task) {
    print("Task ID: ${task.id}");
    print("Task Title: ${task.title}");
    print("Task Description: ${task.description}");
    print("Task Status: ${task.status}");
    print("Task Due Date: ${task.dueDate}");
  }
}

enum Status { Pending, In_Progress, Completed }

//task model
class Task {
  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.dueDate});
  String? id;
  String? title;
  String? description;
  Status? status;
  DateTime? dueDate;
}
