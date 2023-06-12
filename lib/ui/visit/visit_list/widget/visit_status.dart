import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class VisitStatus extends StatelessWidget {
  const VisitStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return Container();
      },
      separatorBuilder: (_, index) {
        return SizedBox(width: 10.w);
      },
      itemCount: 2,
    );
  }
}
