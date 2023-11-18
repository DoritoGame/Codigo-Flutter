import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:gimnaciomusculoso/pages/registrar.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<UserData> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Registro',
          style: TextStyle(
            color: Color.fromRGBO(245, 245, 245, 1),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 70, 70, 69),
      ),
      backgroundColor: Color.fromARGB(255, 58, 59, 52),
      body: TaskList(tasks: tasks),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrarPage()),
          ).then((newTask) {
            if (newTask != null) {
              setState(() {
                tasks.add(newTask);
                tasks.sort((a, b) {
                  final priorityValues = {
                    'Normal': 0,
                    'Premiun': 1,
                    'Golden': 2
                  };
                  int priorityA = priorityValues[a.priority]!;
                  int priorityB = priorityValues[b.priority]!;
                  int priorityComparison = priorityA.compareTo(priorityB);
                  if (priorityComparison != 0) {
                    return priorityComparison;
                  } else {
                    if (a.dueDate == null && b.dueDate == null) {
                      return 0;
                    } else if (a.dueDate == null) {
                      return 1;
                    } else if (b.dueDate == null) {
                      return -1;
                    } else {
                      return a.dueDate!.compareTo(b.dueDate!);
                    }
                  }
                });
              });
            }
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 4, 31, 48)),
        child: Text('Registrar Clienten'),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }
}

class TaskList extends StatefulWidget {
  final List<UserData> tasks;

  TaskList({required this.tasks});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void toggleTaskCompletion(UserData task) {
    setState(() {
      task.isClomplete = !task.isClomplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        String taskInfo = 'priority: ${task.priority}';
        String formattestardate = '';
        String formattedDueDate = '';

        if (task.startDate != null) {
          formattestardate =
              '${task.startDate!.day.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.month.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.year.toString()}';
          taskInfo += ' - Start date: $formattestardate';
        }
        if (task.dueDate != null) {
          formattedDueDate = '${task.dueDate!.day.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.month.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.year.toString()}';
          taskInfo += ' - Due date: $formattedDueDate';
        }

        final isCompleted = task.isClomplete;
        final borderColor =
            isCompleted ? Colors.green : const Color.fromARGB(255, 0, 0, 0);

        return Card(
          elevation: 4,
          margin: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Center(
              child: Text(
                'Cliente',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Text(
                  'Cedula: ',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.cedula.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Nombre: ',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.nombre,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Apellido: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.apellido,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Edad: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.edad.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Correo: ',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.correo,
                  style: TextStyle(
                    fontSize: 14,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Genero:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.genero,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Membresia: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.priority,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de inicio date:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  formattestardate,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de fin date:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  formattedDueDate,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tipo de pago: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.pago,
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Valor de membresia ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.moneda.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: borderColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit_document,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoApp()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.tasks.remove(task);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
