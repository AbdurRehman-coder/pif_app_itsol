import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';

class HandbookPDFView extends StatelessWidget {
  final String pdfUrl;

  HandbookPDFView({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.current.handBook,
      ),
      body: const PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
      ).cachedFromUrl(
        pdfUrl,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
