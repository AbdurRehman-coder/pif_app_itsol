import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/provider/invite_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/state/invite_visitor_state.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/widget/visitor_list_tile.dart';

class InviteVisitorFormListView extends StatelessWidget {
  const InviteVisitorFormListView({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final InviteVisitorNotifier notifier;
  final InviteVisitorState provider;

  @override
  Widget build(BuildContext context) {
    final cellHeight = provider.lstData.length * 70.h;
    return Column(
      children: [
        Column(
          children: [
            CustomTextField(
              textEditingController: notifier.firstNameController,
              focusNode: notifier.firstNameFocus,
              labelText: S.current.firstName,
              checkEmpty: true,
              onChanged: notifier.onChangeText,
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomTextField(
              textEditingController: notifier.lastNameController,
              focusNode: notifier.lastNameFocus,
              labelText: S.current.lastName,
              onChanged: notifier.onChangeText,
              checkEmpty: true,
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomTextField(
              textEditingController: notifier.emailController,
              focusNode: notifier.emailFocus,
              labelText: S.current.email,
              isEmailField: true,
              checkEmpty: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.onChangeText,
            ),
          ],
        ).visibility(visible: provider.lstData.isEmpty),
        SizedBox(
          height: cellHeight,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return VisitorListTile(
                item: provider.lstData[index],
                notifier: notifier,
              );
            },
            separatorBuilder: (_, index) {
              return Divider(
                height: 24.h,
                thickness: 1.h,
                color: lineColor,
              );
            },
            itemCount: provider.lstData.length,
          ),
        )
      ],
    );
  }
}
