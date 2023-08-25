// Internal Modules
import 'package:challenge_for_robinhood/model/todo/task.dart';
import 'package:challenge_for_robinhood/model/todo/todo_list_response.dart';
import 'package:challenge_for_robinhood/network/network.dart';

class ToDoRepository extends BaseRepository {
  final String _requestTaskList = 'todo-list';

  Future<TaskListResponse> requestTodoList({
    required TaskType type,
    int offset = 0,
    int limit = 10,
  }) async {
    var response = await dataProvider.get(
      _requestTaskList,
      queryParameters: {
        'offset': offset,
        'limit': limit,
        'sortBy': 'createdAt',
        'isAsc': true,
        'status': type.toRawValue,
      },
    );

    return TaskListResponse.fromJson(response.data);
  }
}
