import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'package:major_try/data/globals.dart' as globals;
import '../../../data/words_data.dart';
import '../../output_page.dart';
import 'general_page.dart';

class PronounPage extends StatefulWidget {
  final TextEditingController tappedWords;
  const PronounPage({
    Key? key,
    required this.tappedWords,
  }) : super(key: key);

  @override
  State<PronounPage> createState() => _PronounPageState();
}

class _PronounPageState extends State<PronounPage> {
  List<String> pronoun = [];
  List<String> matra = matraList;
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final response = await http
        .get(Uri.parse("${globals.url}/get-next-words?query=<start>"));

    List<dynamic> dynamicList = jsonDecode(response.body)["next_words"];
    pronoun = dynamicList.cast<String>();
    list = pronoun;
    setState(() {});
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aawaj",
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 1,
        backgroundColor: context.canvasColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height / 32,
            ),
            TextFormField(
              controller: widget.tappedWords,
              keyboardType: TextInputType.none,
              style: TextStyle(color: context.primaryColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: AnimationLimiter(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 3 / 2),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 300),
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    delay: const Duration(milliseconds: 100),
                                    child: listItem(list[index]))));
                      })),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => OutputPage(
                                sentence: widget.tappedWords.text))));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    backgroundColor: context.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: Text(
                    'Speak !',
                    style: TextStyle(
                      color: context.canvasColor,
                      fontSize: 25,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                GeneralPage(tappedWords: widget.tappedWords))));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    backgroundColor: context.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: Text(
                    'Next !',
                    style: TextStyle(
                      color: context.canvasColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ).py8(),
          ],
        ),
      ),
    );
  }

  Widget listItem(String word) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onLongPress: (() {
        list = matra;
        setState(() {});
        widget.tappedWords.text = "${widget.tappedWords.text} $word";
      }),
      onTap: () {
        // adding the newly tapped words to the previous words.
        if (list == matra) {
          widget.tappedWords.text = "${widget.tappedWords.text}$word";
          list = pronoun;
        } else {
          widget.tappedWords.text = "${widget.tappedWords.text} $word";
        }

        // setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    GeneralPage(tappedWords: widget.tappedWords))));
      },
      child: Card(
          // elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              word,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
