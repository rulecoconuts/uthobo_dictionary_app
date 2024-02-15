// import 'package:dictionary_app/accessors/auth_utils_accessor.dart';
// import 'package:dictionary_app/services/auth/login/auth.dart';
// import 'package:dictionary_app/services/constants/constants.dart';
// import 'package:either_option/either_option.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'auth_holder.g.dart';

// @riverpod
// class AuthHolder extends _$AuthHolder with AuthUtilsAccessor {
//   @override
//   Future<Option<Auth>> build() async {
//     return Option.of(await (await authStorage()).get(Constants.loginTokenKey));
//   }
// }
