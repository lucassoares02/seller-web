// // ignore_for_file: public_member_api_docs

// // import 'dart:typed_data';

// // import 'package:flutter/material.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:printing/printing.dart';

// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:printing/printing.dart';

// class Printing extends StatelessWidget {
//   const Printing(this.title, {Key? key}) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return PdfPreview(
//       build: (format) => _generatePdf(format, title),
//     );
//   }

//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     // final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     // final font = await PdfGoogleFonts.nunitoExtraLight();
//     final doc = Document();

//     // pdf.addPage(
//     //   pw.Page(
//     //     pageFormat: format,
//     //     build: (context) {
//     //       return pw.Column(
//     //         children: [
//     //           pw.SizedBox(
//     //             width: double.infinity,
//     //             child: pw.FittedBox(
//     //               child: pw.Text(title, style: pw.TextStyle(font: font)),
//     //             ),
//     //           ),
//     //           pw.SizedBox(height: 20),
//     //           pw.Flexible(child: pw.Container(child: ))
//     //         ],
//     //       );
//     //     },
//     //   ),
//     // );
//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Center(
//           child: pw.QrImage(
//             data: 'https://www.example.com', // Dados do QR code
//             version: QrVersions.auto, // Versão automática do QR code
//             size: 200.0, // Tamanho do QR code
//           ),
//         );
//       },
//     ));

//     return pdf.save();
//   }
// }
