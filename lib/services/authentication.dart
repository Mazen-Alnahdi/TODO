
import 'package:hive/hive.dart';
import 'package:todo/model/user.dart';


class AuthenticationService {

  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');


  }

  Future<String?> authenticateUser(final String username,final String password) async {
    final success = _users.values.any((element)=> element.username == username && element.password == password);

    return success ? username : null;
    
  }
}