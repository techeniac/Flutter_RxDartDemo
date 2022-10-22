import 'package:flutterExample/rcs/models/TestModel.dart';
import 'package:flutterExample/rcs/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final Repository _repository = Repository();

  PublishSubject<List<TestModel>> testDataController =
      PublishSubject<List<TestModel>>();

  PublishSubject<bool> logoutContoller =
      PublishSubject<bool>();

  Stream<List<TestModel>> get getTestDataStream =>
      testDataController.stream;
  Stream<bool> get getLogoutStream =>
      logoutContoller.stream;

  Future getTestData() async {
    final List<TestModel> response =
        await _repository.getTestDataRepo();
    print(response);
    testDataController.sink.add(response);
  }
  Future logout() async {
    logoutContoller.sink.add(true);
  }

  void dispose() {
    testDataController.close();
  }
}
