import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
import 'package:dictionary_app/accessors/storage_utils_accessor.dart';
import 'package:dictionary_app/accessors/user_utils_accessor.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:either_option/either_option.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logged_in_user_holder.g.dart';

@riverpod
class LoggedInUserHolder extends _$LoggedInUserHolder
    with AuthUtilsAccessor, UserUtilsAccessor, StorageUtilsAccessor {
  @override
  Future<Option<AppUserDomainObject>> build() async {
    return Option.of(await (await userRESTService()).fetchLoggedInUserData())
        .map((a) => a.toDomain());
  }

  Future signout() async {
    await (await authStorage()).clear();
    await (await generalStorage()).clear();
    ref.invalidateSelf();
  }
}
