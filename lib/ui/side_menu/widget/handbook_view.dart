import 'dart:io';

import 'package:flutter/cupertino.dart';
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
      body: PDF(
        autoSpacing: Platform.isIOS,
        pageFling: false,
      ).cachedFromUrl(
        pdfUrl,
        placeholder: (progress) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('$progress%'),
              const CupertinoActivityIndicator(
                color: goldenColor,
              )
            ],
          ),
        ),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
