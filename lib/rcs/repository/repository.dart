import 'package:flutterExample/rcs/api_provider/api_provider.dart';
import 'package:flutterExample/rcs/models/UserModel.dart';

import '../models/TestModel.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<UserModel> signInRepo(String email, String password) =>
      apiProvider.signInApiProvider(email, password);
  Future<List<TestModel>> getTestDataRepo() =>
      apiProvider.getTestDataApiProvider();
}
