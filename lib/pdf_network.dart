import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

class NetworkPdfViewerScreen extends StatefulWidget {
  @override
  _NetworkPdfViewerScreenState createState() => _NetworkPdfViewerScreenState();
}

class _NetworkPdfViewerScreenState extends State<NetworkPdfViewerScreen> {
  late PdfControllerPinch _pdfController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdfFromNetwork();
  }

  Future<void> _loadPdfFromNetwork() async {
    try {
      // Replace with your PDF URL
      final url = 'https://pdfobject.com/pdf/sample.pdf';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final document = PdfDocument.openData(bytes);
        setState(() {
          _pdfController = PdfControllerPinch(document: document);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network PDF Viewer")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PdfViewPinch(controller: _pdfController),
    );
  }
}
