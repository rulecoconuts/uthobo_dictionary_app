import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/providers/logged_in_user_holder.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelectionPage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  Widget generateUser(
      AsyncValue<Option<AppUserDomainObject>> user, BuildContext context) {
    return switch (user) {
      AsyncData(:final value) => value.isEmpty
          ? Text(
              "No user",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : Text(
              "${value.getOrElse(() => null)?.email}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
      AsyncError(:final error) => Text(
          "Something went wrong: $error",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      _ => CircularProgressIndicator()
    };
  }

  Widget generateSignoutButton(WidgetRef ref, BuildContext context) {
    return TextButton(
        onPressed: () async {
          await ref.read(loggedInUserHolderProvider.notifier).signout();
          router().go("/");
        },
        child: Text(
          "Signout",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedInUserHolderProvider);

    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            generateUser(user, context),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: generateSignoutButton(ref, context),
            )
          ],
        ),
      ),
    );
  }
}
