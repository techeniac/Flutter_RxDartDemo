import 'package:rxdart/rxdart.dart';

class AuthBloc {
  PublishSubject<String?> exceptionController = PublishSubject<String>();

  Stream<String?> get getAuthExceptionStream => exceptionController.stream;

  Future setException(String exception) async {
    exceptionController.sink.add(exception);
  }

  void dispose() {
    exceptionController.close();
  }
}
