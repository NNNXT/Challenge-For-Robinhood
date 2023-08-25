// Internal Modules
import 'package:challenge_for_robinhood/model/task/task.dart';
import 'package:challenge_for_robinhood/model/task/task_list_response.dart';
import 'package:challenge_for_robinhood/network/network.dart';

class TaskRepository extends BaseRepository {
  final String _requestTaskList = 'todo-list';

  Future<TaskListResponse> requestTaskList({
    required TaskType taskType,
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
        'status': taskType.toRawValue,
      },
    );

    return TaskListResponse.fromJson(response.data);
  }
}
