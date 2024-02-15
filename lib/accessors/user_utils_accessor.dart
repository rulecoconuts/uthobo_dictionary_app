import 'package:dictionary_app/services/user/remote/user_rest_service.dart';
import 'package:get_it/get_it.dart';

mixin UserUtilsAccessor {
  Future<UserRESTService> userRESTService() =>
      GetIt.I.getAsync<UserRESTService>();
}
