// ignore_for_file: non_constant_identifier_names
import 'package:collection/collection.dart';

void main() {
  Map posts0 = {'data': "hello1", 'time': DateTime.friday};
  Map posts1 = {'data': "hello2", 'time': DateTime.saturday};

  final queue = PriorityQueue<Map>((a, b) {
    if (a['time'] < b['time']) {
      return 1;
    }
    return 0;
  });
  queue.add(posts0);
  queue.add(posts1);
  while (queue.isNotEmpty) {
    print(queue.removeFirst());
  }
}
