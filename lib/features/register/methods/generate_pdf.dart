import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<File> generatePdf({
  required String name,
  required String address,
  required String whatsappNumber,
  required String bookedOn,
  required String treatmentDate,
  required String treatmentTime,
  required List<Map<String, dynamic>> treatments,
  required double totalAmount,
  required double discount,
  required double advance,
  required double balance,
}) async {
  final pdf = pw.Document();

  final ByteData bytes = await rootBundle.load('assets/images/logo.png');
  final ByteData backgroundImageBytes =  await rootBundle.load('assets/images/pdf_background.png');
  final Uint8List byteList = bytes.buffer.asUint8List();
  final Uint8List backgroundImageByteList = backgroundImageBytes.buffer.asUint8List();

  final pw.MemoryImage logoImage = pw.MemoryImage(byteList);
  final pw.MemoryImage backgroundImage = pw.MemoryImage(backgroundImageByteList);
  pw.SizedBox smallSizedBox = pw.SizedBox(height: 3);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Stack(
          children: [
            // Draw the background image
            pw.Positioned.fill(
              child: pw.Image(backgroundImage, fit: pw.BoxFit.fill),
            ),
            // Overlay the content on top of the background image
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logoImage, width: 100, height: 100), // Example: use the same image as logo
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('KUMARAKOM'),
                        smallSizedBox,
                        pw.Text('Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563', style: const pw.TextStyle(color: PdfColors.grey)),
                        smallSizedBox,
                        pw.Text('e-mail: unknown@gmail.com', style: const pw.TextStyle(color: PdfColors.grey)),
                        smallSizedBox,
                        pw.Text('Mob: +91 9876543210 | +91 9876543210', style: const pw.TextStyle(color: PdfColors.grey)),
                        smallSizedBox,
                        pw.Text('GST No: 32AABCU9603R1ZW'),
                      ],
                    ),
                  ],
                ),
                pw.Divider(color: PdfColors.grey),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Patient Details',
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green,
                              )),
                          pw.SizedBox(height: 10),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'Name: ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: name,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'Address: ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: address,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'WhatsApp Number: ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: whatsappNumber,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'Booked On: ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: bookedOn,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'Treatment Date:           ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: treatmentDate,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                const pw.TextSpan(
                                  text: 'Treatment Time:             ',
                                  style: pw.TextStyle(color: PdfColors.black),
                                ),
                                pw.TextSpan(
                                  text: treatmentTime,
                                  style: const pw.TextStyle(color: PdfColors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(borderStyle: const pw.BorderStyle(pattern: [5,5]),color: PdfColors.grey),
                pw.Table.fromTextArray(
                  cellStyle: const pw.TextStyle(color: PdfColors.grey),
                  headerStyle: const pw.TextStyle(color: PdfColors.green),
                  headerAlignment: pw.Alignment.centerLeft,
                  cellAlignment: pw.Alignment.centerLeft,
                  border: const pw.TableBorder(left: pw.BorderSide.none, right: pw.BorderSide.none),
                  context: context,
                  data: <List<String>>[
                    <String>['Treatment', 'Price', 'Male', 'Female', 'Total'],
                    ...treatments.map(
                          (treatment) => [
                        treatment['name'],
                        treatment['price'].toString(),
                        treatment['male'].toString(),
                        treatment['female'].toString(),
                        treatment['total'].toString()
                      ],
                    )
                  ],
                ),
                pw.Divider(borderStyle: const pw.BorderStyle(pattern: [5,5]),color: PdfColors.grey),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(
                          children: [
                            pw.Text('Total Amount:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text('$totalAmount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                        smallSizedBox,
                        pw.Row(
                          children: [
                            pw.Text('Discount:'),
                            pw.SizedBox(width: 10),
                            pw.Text('$discount'),
                          ],
                        ),
                        smallSizedBox,
                        pw.Row(
                          children: [
                            pw.Text('Advance:'),
                            pw.SizedBox(width: 10),
                            pw.Text('$advance'),
                          ],
                        ),
                        smallSizedBox,
                        pw.Row(
                          children: [
                            pw.Text('Balance:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 10),
                            pw.Text('$balance',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Thank you for choosing us', style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 16,
                            color: PdfColors.green,
                          )),
                          pw.Text(
                              "Your well-being is our commitment, and were honored\n you ve entrusted us with your health journey",
                              style: const pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.grey
                              )),
                        ]
                    )
                  ]
                )
              ],
            ),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/patient_details.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}
