import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewerPage extends StatelessWidget {
  final File pdfFile;

  const PdfViewerPage({super.key, required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _sharePdfFile(context, pdfFile);
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfFile.path,
      ),
    );
  }

  void _sharePdfFile(BuildContext context, File pdfFile) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.shareXFiles(
      [XFile(pdfFile.path)],
      text: 'Share PDF',
      subject: 'PDF File',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
