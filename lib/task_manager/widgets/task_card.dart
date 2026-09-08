import 'package:batch_18/task_manager/models/api_response.dart';
import 'package:batch_18/task_manager/models/task_model.dart';
import 'package:batch_18/task_manager/service/api_caller.dart';
import 'package:batch_18/task_manager/utils/urls.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refreshParent;

  const TaskCard({
    super.key,
    required this.taskModel,
    required this.cardColor,
    required this.refreshParent,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Future<void> deleteTask() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.deleteTaskURL(widget.taskModel.sId.toString()),
    );

    if (response.isSuccess) {
      widget.refreshParent();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task Deleted')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('something wrong....!')));
    }
  }

  Future<void> changestatusTask(String status) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: TMUrls.updateTaskStatusURL(widget.taskModel.sId.toString(), status),
    );
    setState(() {});

    if (response.isSuccess) {
      widget.refreshParent();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Task Status Updated')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('something wrong....!')));
    }
  }

  void showStatusChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Text('New'),
                onTap: () {
                  changestatusTask('New');
                  Navigator.pop(context);
                },
                trailing: widget.taskModel.status == 'New'
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Progress'),
                onTap: () {
                  changestatusTask('Progress');
                  Navigator.pop(context);
                },
                trailing: widget.taskModel.status == 'Progress'
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Completed'),
                onTap: () {
                  changestatusTask('Completed');
                  Navigator.pop(context);
                },
                trailing: widget.taskModel.status == 'Completed'
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Cancelled'),
                onTap: () {
                  changestatusTask('Cancelled');
                  Navigator.pop(context);
                },
                trailing: widget.taskModel.status == 'Cancelled'
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.taskModel.title.toString(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description.toString()),
            SizedBox(height: 5),
            Text('Date:${widget.taskModel.createdDate}'),

            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.cardColor,
                ),

                Spacer(),

                IconButton(
                  onPressed: () {
                    showStatusChangeDialog();
                  },
                  icon: Icon(Icons.edit_note, color: Colors.orange),
                ),
                IconButton(
                  onPressed: () {
                    deleteTask();
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
