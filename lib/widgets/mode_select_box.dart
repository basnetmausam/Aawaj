// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class BigBox extends StatelessWidget {
//   const BigBox({Key? key}) : super(key: key);
//   bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 600;

//   bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 600;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (isMobile(context))
//             Container(
//               height: 173,
//               width: 160,
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           if (isTablet(context))
//             Container(
//               height: 250,
//               width: 275,
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           if (isMobile(context))
//             const SizedBox(
//               width: 50,
//             ),
//           if (isTablet(context))
//             const SizedBox(
//               width: 100,
//             ),
//           if (isMobile(context))
//             Container(
//               height: 173,
//               width: 160,
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           if (isTablet(context))
//             Container(
//               height: 250,
//               width: 275,
//               decoration: BoxDecoration(
//                 color: context.cardColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
