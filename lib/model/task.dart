
import 'package:hive/hive.dart';


part 'task.g.dart';
// it makes data adapters to be able to modify data

@HiveType(typeId: 2)
class Task{
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final String completed;

  Task(this.user, this.task, this.completed);
}