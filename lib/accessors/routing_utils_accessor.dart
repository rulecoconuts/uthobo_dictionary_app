import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

mixin RoutingUtilsAccessor {
  GoRouter router() => GetIt.I<GoRouter>();
}
