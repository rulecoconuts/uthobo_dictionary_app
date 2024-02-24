import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/widgets/helper_widgets/circular_add_button.dart';
import 'package:flutter/material.dart';

class LanguageNotFoundPage extends StatelessWidget with RoutingUtilsAccessor {
  final String? previousSearchString;
  final ApiPageDetails? previousPageDetails;
  const LanguageNotFoundPage(
      {this.previousSearchString, this.previousPageDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            "Could not find the language you were looking for?  Create it!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Color(0xFF575353), fontWeight: FontWeight.w600),
          )),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: CircularAddButton(
              onTap: () => router().push("/language_create", extra: {
                if (previousSearchString != null)
                  "previous_search_string": previousSearchString,
                if (previousPageDetails != null)
                  "previous_page_details": previousPageDetails
              }),
              size: 60,
            ),
          )
        ],
      ),
    );
  }
}
