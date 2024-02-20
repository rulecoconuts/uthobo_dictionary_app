import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/user/app_user_domain_object.dart';
import 'package:dictionary_app/services/user/providers/logged_in_user_holder.dart';
import 'package:dictionary_app/services/user/remote/remote_app_user.dart';
import 'package:dictionary_app/widgets/selection/language_selection_dropdown.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
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

    return Material(
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
            child: Portal(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 80),
                        child: Text(
                          "Translate",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      LanguageSelectionDropdown(
                          onSelectionChanged: (language) {}),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 70),
                        child: Text(
                          "to",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      LanguageSelectionDropdown(
                          onSelectionChanged: (language) {}),
                    ],
                  )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Continue",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          )))
                ]))),
      ),
    );
  }
}
