import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
void main() {
  runApp( MaterialApp(home: PdfViewerScreen()));
}


class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    // Initialize PdfController with the path to the PDF file
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/sample.pdf'),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: PdfView(
        controller: _pdfController,
      ),
    );
  }
}
