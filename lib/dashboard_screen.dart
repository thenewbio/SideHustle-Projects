import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final formKey = GlobalKey<FormState>();
  final List<String> _todoItems = [];
  final _title = TextEditingController();
  final _edit = TextEditingController();

  void _addTodoItem(String task) {
    print(task);
    setState(() => _todoItems.add(task));
  }

  void addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => addTaskTodo(),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        if (_todoItems.isEmpty) {
          return CircularProgressIndicator();
        }
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mark ${_todoItems[index]} as done?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: Text('Mark as done'),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return Container(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Dismissible(
        key: Key(_todoItems[index]),
        child: ListTile(
          title: Text("Task"),
          subtitle: Text(todoText),
          trailing: GestureDetector(
              onTap: () => _promptRemoveTodoItem(index),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0),
              color: Colors.purple,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.pink,
                    child: const Text(
                      'Todo',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 1.5),
                    child: _buildTodoList(),
                    //
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addTaskTodo() {
    return Container(
      padding: EdgeInsets.all(16),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      child: Column(
        children: [
          TextField(
            controller: _title,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter Task',
            ),
          ),
          GestureDetector(
            onTap: () {
              _addTodoItem(_title.text);
              _title.clear();
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.only(top: 40),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Add Task',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
