import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../api/transliteration_api.dart';
import '../../output_page.dart';

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

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            height: 20,
                          ),
                          Form(
                            key: formKey,
                            child: TypeAheadField<String?>(
                              hideOnError: true,
                              hideKeyboard: false,
                              hideSuggestionsOnKeyboardHide: false,
                              textFieldConfiguration: TextFieldConfiguration(
                                autocorrect: false,
                                controller: controllerWord,
                                autofocus: true,
                                focusNode: myFocusNode,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.keyboard_alt_outlined),
                                  border: OutlineInputBorder(),
                                  hintText: 'Type Words',
                                ),
                              ),
                              suggestionsCallback:
                                  TranslitAPI.getWordSuggestions,
                              itemBuilder: (context, String? suggestion) {
                                final word = suggestion!;

                                return ListTile(
                                  title: Text(word),
                                );
                              },
                              noItemsFoundBuilder: (context) => const SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    'No words detected',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              onSuggestionSelected: (String? suggestion) {
                                // print(suggestion);
                                var lis = controllerWord.text.split(' ');

                                var nayaList =
                                    lis.getRange(0, lis.length - 1).join(" ");

                                controllerWord.text =
                                    "$nayaList ${suggestion!} ";

                                Future.delayed(const Duration(milliseconds: 1),
                                    () {
                                  myFocusNode.requestFocus();
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 500,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => OutputPage(
                                          sentence: controllerWord.text
                                              .substring(1)))));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple),
                            child: const Text(
                              "Speak",
                              style: TextStyle(fontSize: 32),
                            ).py12(),
                          ),
                        ],
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
