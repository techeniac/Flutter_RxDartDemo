import 'package:rxdart/subjects.dart';

class BottomBarBloc {
  PublishSubject<int> indexController = PublishSubject<int>();

  Stream<int> get currentIndexStream => indexController.stream;

  Future changeIndex(int index) async {
    indexController.sink.add(index);
  }

  void dispose() {
    indexController.close();
  }
}
