import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchBoxWidget extends HookWidget {
  final Function(String searchString) onSearchRequested;
  final String? initialSearchString;
  const SearchBoxWidget(
      {required this.onSearchRequested, this.initialSearchString, Key? key})
      : super(key: key);

  void search(String searchString) {
    onSearchRequested.call(searchString.trim());
  }

  @override
  Widget build(BuildContext context) {
    var textEditController = useState(TextEditingController());
    var showCancelWidget =
        useState(initialSearchString?.trim().isNotEmpty ?? false);

    useEffect(() {
      var onTextEditted = () {
        // Only show the cancel button if the search box has text in it
        if (textEditController.value.text.isNotEmpty &&
            !showCancelWidget.value) {
          showCancelWidget.value = true;
        } else if (textEditController.value.text.isEmpty &&
            showCancelWidget.value) {
          showCancelWidget.value = false;
        }
      };

      textEditController.value.addListener(onTextEditted);
      textEditController.value.text = initialSearchString ?? "";

      return () => textEditController.value.removeListener(onTextEditted);
    }, [textEditController.value]);

    return TextFormField(
      controller: textEditController.value,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: search,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: showCancelWidget.value
              ? InkWell(
                  onTap: () {
                    textEditController.value.text = "";
                    search("");
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Theme.of(context).colorScheme.primary,
                  ))
              : null,
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          hintText: "Search"),
    );
  }
}
