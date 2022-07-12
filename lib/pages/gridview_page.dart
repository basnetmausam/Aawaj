import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/model/words.dart';
import 'package:velocity_x/velocity_x.dart';

import '../data/words_data.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key? key}) : super(key: key);

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    List<Words> list = PronounData().pronounList;

    return Scaffold(
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
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
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
                              duration: const Duration(milliseconds: 1000),
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      delay: const Duration(milliseconds: 100),
                                      child: listItem(list[index]))));
                        })),
              ),
            if (isTablet(context))
              Expanded(
                child: AnimationLimiter(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6, childAspectRatio: 3 / 2),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: const Duration(milliseconds: 1000),
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      delay: const Duration(milliseconds: 100),
                                      child: listItem(list[index]))));
                        })),
              ),
            const ElevatedButton(
              onPressed: (null),
              child: null,
              style: ButtonStyle(
                  // backgroundColor: Color(Colors.black),
                  minimumSize: Size(100, 50)),
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(Words words) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            words.word,
            style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
