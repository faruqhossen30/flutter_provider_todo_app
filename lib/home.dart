import 'package:flutter/material.dart';
import 'package:flutter_provider_todo_app/model/todo_model.dart';
import 'package:flutter_provider_todo_app/provider/todo_provider.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ad Todo List'),
            content: TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: 'write todo item'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(onPressed: () {
                if (_textController.text.isEmpty) {
                  return;
                }
                context.read<TodoProvider>().addTodoList(new TODOModel(
                    title: _textController.text, isCompleted: false));
                _textController.clear();
                Navigator.pop(context);
              }, child: Text('submit')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Center(
                  child: Text(
                    'Todo List',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: provider.allTodoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      provider.todoStatusChange(provider.allTodoList[index]);
                    },
                    leading: MSHCheckbox(
                      size: 30,
                      value: provider.allTodoList[index].isCompleted,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.blue),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        provider.todoStatusChange(provider.allTodoList[index]);
                      },
                    ),
                    title: Text(provider.allTodoList[index].title,
                    style: TextStyle(color: provider.allTodoList[index].isCompleted ? Colors.green :  Colors.black  ),),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        provider.removeTodoList(provider.allTodoList[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
}
