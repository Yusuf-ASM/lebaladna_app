import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../backend/custom_functions.dart';
import '../backend/shared_variables.dart';

dynamic snackBar(String message, BuildContext context, {int duration = 2000}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: duration),
      content: Text(
        message,
        style: const TextStyle(fontSize: SemiTextSize),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

dynamic loadingIndicatorDialog(BuildContext context, {bool dismissible = false}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final date = DateTime.now();
      return PopScope(
        canPop: false,
        child: SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: [
            Center(
              child: Lottie.asset(
                date.minute % 2 == 0
                    ? date.second % 2 == 0
                        ? "assets/cat.json"
                        : "assets/bomb.json"
                    : date.second % 2 == 0
                        ? "assets/duck.json"
                        : "assets/potato.json",
                frameRate: FrameRate.max,
              ),
            )
          ],
        ),
      );
    },
  );
}

Center loadingIndicator() {
  final date = DateTime.now();
  return Center(
    child: Lottie.asset(
      date.minute % 2 == 0
          ? date.second % 2 == 0
              ? "assets/cat.json"
              : "assets/bomb.json"
          : date.second % 2 == 0
              ? "assets/duck.json"
              : "assets/potato.json",
      frameRate: FrameRate.max,
    ),
  );
}

dynamic simpleDialog({
  required BuildContext context,
  required String title,
  required String content,
  bool copy = false,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
      ),
      content: SelectableText(
        content,
      ),
      actions: [
        if (copy)
          TextButton(
            onPressed: () async => await Clipboard.setData(ClipboardData(text: content)),
            child: const Text('Copy'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}

IconButton datePicker(
  BuildContext context,
  DateTime currentDate,
  Function(int result) result, {
  bool firstDateNow = false,
}) {
  final firstDate =
      firstDateNow ? DateTime.now() : DateTime.now().subtract(const Duration(days: 31));
  return IconButton(
    onPressed: () async {
      DateTime? date = await showDialog(
        context: context,
        builder: (BuildContext context) => DatePickerDialog(
          initialDate: currentDate,
          firstDate: firstDate,
          lastDate: DateTime.now().add(const Duration(days: 31)),
        ),
      );
      if (date != null) {
        result(date.add(const Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000);
      } else {
        result(currentTimeEpoch());
      }
    },
    icon: const Icon(Icons.calendar_today),
  );
}

Theme expansionTile(BuildContext context, String title, List<Widget> children) {
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      title: Text(title, style: const TextStyle(fontSize: SemiTextSize)),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
      children: children,
    ),
  );
}

Padding progressText(int quantity, String unit, String meal) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 8),
    child: Wrap(
      spacing: 32,
      direction: Axis.horizontal,
      children: [
        Column(
          children: [
            Text(
              quantity.toString(),
              style: const TextStyle(fontSize: BigTextSize),
            ),
            Text(
              "$unit\n$meal",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: SemiTextSize),
            ),
          ],
        ),
      ],
    ),
  );
}

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final VoidCallback onSubmitted;
  const FormTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.name,
    required this.onSubmitted,
    required this.labelText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  labelText,
                  style: const TextStyle(fontSize: SemiTextSize),
                ),
              ),
            ],
          ),
          TextField(
            onSubmitted: (value) => onSubmitted(),
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.shade200, width: 1.1),
                borderRadius: BorderRadius.circular(TextFieldBorderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 20, 137, 255), width: 1.1),
                borderRadius: BorderRadius.circular(TextFieldBorderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormAutoComplete extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<String> suggestions;
  final double width;
  const FormAutoComplete({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.name,
    required this.labelText,
    required this.suggestions,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  labelText,
                  style: const TextStyle(fontSize: NormalTextSize),
                ),
              ),
            ],
          ),
          Autocomplete<String>(
            onSelected: (option) => controller.text = option,
            optionsBuilder: (textEditingValue) {
              final text = textEditingValue.text;
              if (text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return suggestions.where((element) => element.contains(text));
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200,
                      width: width - 48,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                          return ListTile(
                            title: Container(
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.all(16.0),
                              color: highlight ? Theme.of(context).focusColor : null,
                              child: Text(
                                option,
                              ),
                            ),
                            onTap: () => onSelected(option),
                          );
                        },
                        itemCount: options.length,
                      ),
                    ),
                  ),
                ),
              );
            },
            fieldViewBuilder: (
              context,
              textEditingController,
              focusNode,
              onEditingComplete,
            ) {
              textEditingController.text = "";
              return TextField(
                keyboardType: keyboardType,
                focusNode: focusNode,
                onChanged: (value) => controller.text = value,
                onEditingComplete: onEditingComplete,
                controller: textEditingController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade200, width: 1.1),
                    borderRadius: BorderRadius.circular(TextFieldBorderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromARGB(255, 20, 137, 255), width: 1.1),
                    borderRadius: BorderRadius.circular(TextFieldBorderRadius),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DrawerIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback pressFunction;
  const DrawerIconButton({
    super.key,
    required this.text,
    required this.icon,
    required this.pressFunction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: TextButton(
        onPressed: pressFunction,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: MediumTextSize,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: SemiTextSize),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLabel extends StatelessWidget {
  final String label;
  final String data;
  const CustomLabel({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: MediumTextSize),
          ),
          SelectableText(
            data,
            style: const TextStyle(fontSize: MediumTextSize),
          )
        ],
      ),
    );
  }
}
