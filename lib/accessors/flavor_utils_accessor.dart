import 'package:dictionary_app/services/flavor/app_flavor.dart';
import 'package:get_it/get_it.dart';

mixin FlavorUtilsAccessor {
  AppFlavor appFlavor() => GetIt.I<AppFlavor>();
}
