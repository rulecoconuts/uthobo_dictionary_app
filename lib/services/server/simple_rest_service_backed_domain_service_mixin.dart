import 'package:dictionary_app/services/foundation/creation_service.dart';
import 'package:dictionary_app/services/foundation/delete_service.dart';
import 'package:dictionary_app/services/foundation/update_service.dart';
import 'package:dictionary_app/services/server/simple_rest_service_mixin.dart';

mixin SimpleRESTServiceBackedDomainServiceMixin<T, R>
    on CreationService<T>, UpdateService<T>, DeletionService<T> {
  SimpleDioBackedRESTServiceMixin<R> getRESTService();

  T toDomain(R remote);

  R toRemote(T model);

  @override
  Future<T> create(T model) async {
    return toDomain(await getRESTService().create(toRemote(model)));
  }

  @override
  Future<T> update(T model) async {
    return toDomain(await getRESTService().update(toRemote(model)));
  }

  @override
  Future<bool> delete(T model) async {
    return await getRESTService().delete(toRemote(model));
  }
}
