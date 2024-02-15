import 'package:dictionary_app/services/user/providers/logged_in_user_holder.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelectionPage extends HookConsumerWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(loggedInUserHolderProvider);

    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: switch (user) {
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
        },
      ),
    );
  }
}
