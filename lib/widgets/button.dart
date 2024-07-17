import 'package:flutter/material.dart';

Widget customButton({
  required BuildContext context,
  required String buttonName,
  bool status = false,
  required VoidCallback tap,
}) {
  return GestureDetector(
    onTap: status ? null : tap,
    child: Container(
      width: 300, // Sesuaikan dengan ukuran button di landing page
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: status ? Colors.grey : const Color(0xFFB5FF9C), // Warna dari landing page
        borderRadius: BorderRadius.circular(10), // Sesuaikan dengan landing page
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          status ? 'Please wait...' : buttonName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF031A27), // Warna teks dari landing page
          ),
        ),
      ),
    ),
  );
}




// import 'package:flutter/material.dart';

// Widget customButton(
//     {BuildContext? context,
//     String? buttonName,
//     bool? status = false,
//     VoidCallback? tap}) {
  
//   return GestureDetector(
//     onTap: status == true ? null : tap,
//     child: Container(
//       width: 325,
//       height: 50,
//       margin: EdgeInsets.only(left: 20),
//       decoration: BoxDecoration(
//           color: status == false
//               ? Colors.amber
//               : Colors.grey,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.white),
//           boxShadow: [
//             BoxShadow(
//                 spreadRadius: 1,
//                 blurRadius: 2,
//                 offset: Offset(0, 1),
//                 color: Colors.grey.withOpacity(0.1))
//           ]),
//       child: Center(
//         child: Text(
//           status == false ? buttonName! : 'Please wait...',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.normal,
//               color: Colors.white),
//         ),
//       ),
//     ),
//   );
// }