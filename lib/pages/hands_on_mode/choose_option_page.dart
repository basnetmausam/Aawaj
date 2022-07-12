import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';

class HandsOn extends StatelessWidget {
  const HandsOn({Key? key}) : super(key: key);
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose HandsOn Mode."),
      ),
      // backgroundColor: context.canvasColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          if (isMobile(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose the",
                  style: context.textTheme.headline1,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "option you want to use ?",
                  style: context.textTheme.headline2,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          if (isTablet(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose the",
                  style: TextStyle(
                    color: context.cardColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "option you want to use ?",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isMobile(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.handsRoute);
                      },
                      child: Container(
                        height: 173,
                        width: 160,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/tap-tap.png'),
                            // fit: BoxFit.contain,
                          ),
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tap-Tap",
                      style: TextStyle(
                        color: context.cardColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      " GO !",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (isTablet(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.handsRoute);
                      },
                      child: Container(
                        height: 250,
                        width: 275,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/tap-tap.png'),
                            // fit: BoxFit.contain,
                          ),
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tap-Tap",
                      style: TextStyle(
                        color: context.cardColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      " GO !",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (isMobile(context))
                const SizedBox(
                  width: 50,
                ),
              if (isTablet(context))
                const SizedBox(
                  width: 100,
                ),
              if (isMobile(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.handsRoute);
                      },
                      child: Container(
                        height: 173,
                        width: 160,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/type.png'),
                            // fit: BoxFit.contain,
                          ),
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                        color: context.cardColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "and GO !",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (isTablet(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.handsRoute);
                      },
                      child: Container(
                        height: 250,
                        width: 275,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/type.png'),
                            // fit: BoxFit.contain,
                          ),
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                        color: context.cardColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "and GO !",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
