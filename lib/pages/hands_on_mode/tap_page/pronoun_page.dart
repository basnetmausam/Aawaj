import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/model/words.dart';
import 'package:major_try/pages/hands_on_mode/tap_page/noun_page.dart';
import 'package:major_try/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/words_data.dart';

class PronounPage extends StatefulWidget {
  const PronounPage({Key? key}) : super(key: key);

  @override
  State<PronounPage> createState() => _PronounPageState();
}

class _PronounPageState extends State<PronounPage> {
  final tappedWords = TextEditingController();

  List<Words> pronoun = PronounData().pronounList;
  List<Words> matra = MatraData().matraList;
  List<Words> list = PronounData().pronounList;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap-Tap Go!"),
        actions: [const Icon(Icons.add_box).px24()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tap Words",
              style: context.textTheme.headline1,
            ),
            Text(
              " to genetate Text !",
              style: context.textTheme.headline2,
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: tappedWords,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Tap Words'),
            ),
            const SizedBox(
              height: 32,
            ),
            if (isMobile(context))
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
                              duration: const Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      delay: const Duration(milliseconds: 100),
                                      child: listItem(list[index]))));
                        })),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            NounPage(tappedWords: tappedWords))));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              child: const Text('Next !'),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(Words words) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onLongPress: (() {
        list = matra;
        setState(() {});
        tappedWords.text = "${tappedWords.text} ${words.word}";
      }),
      onTap: () {
        // adding the newly tapped words to the previous words.
        if (list == matra) {
          tappedWords.text = "${tappedWords.text}${words.word}";
          list = pronoun;
        } else {
          tappedWords.text = "${tappedWords.text} ${words.word}";
        }

        setState(() {});
      },
      child: Card(
          // elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              words.word,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
