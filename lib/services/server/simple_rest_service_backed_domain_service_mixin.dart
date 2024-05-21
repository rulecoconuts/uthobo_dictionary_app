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

  List<R> toRemoteList(List<T> models) {
    return models.map(toRemote).toList();
  }

  List<T> toDomainList(List<R> remote) {
    return remote.map(toDomain).toList();
  }

  @override
  Future<List<T>> createAll(List<T> models) async {
    return toDomainList(await getRESTService().createAll(toRemoteList(models)));
  }
}
