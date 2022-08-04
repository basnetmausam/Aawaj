import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../api/transliteration_api.dart';

class TypePage extends StatefulWidget {
  const TypePage({Key? key}) : super(key: key);

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  final formKey = GlobalKey<FormState>();
  final controllerWord = TextEditingController();
  String? selectedWord;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // final bool _isPlhelheaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TypePage"),
      ),
      // backgroundColor: context.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              if (isMobile(context))
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type Words",
                        style: context.textTheme.headline1,
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        " to Speak !",
                        style: context.textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: TypeAheadField<String?>(
                          hideKeyboard: false,
                          // hideSuggestionsOnKeyboardHide: false,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controllerWord,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.keyboard_alt_outlined),
                              border: OutlineInputBorder(),
                              hintText: 'Type Words',
                            ),
                          ),
                          suggestionsCallback: TranslitAPI.getWordSuggestions,
                          itemBuilder: (context, String? suggestion) {
                            final word = suggestion!;

                            return ListTile(
                              title: Text(word),
                            );
                          },
                          noItemsFoundBuilder: (context) => const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                'No words detected',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          onSuggestionSelected: (String? suggestion) {
                            var lis = controllerWord.text.split(' ');

                            var nayaList =
                                lis.getRange(0, lis.length - 1).join(" ");

                            controllerWord.text = "$nayaList ${suggestion!} ";

                            // ScaffoldMessenger.of(context)
                            //   ..removeCurrentSnackBar()
                            //   ..showSnackBar(SnackBar(
                            //     content: Text('Selected user: ${user.name}'),
                            //   ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (isTablet(context))
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type Words",
                        style: TextStyle(
                          color: context.cardColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        " to speak !",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
