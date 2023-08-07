import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/invite_edit_visit_provider.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/state/invite_edit_visit_state.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/widget/visitor_list_tile.dart';

class InviteVisitorFormListView extends StatelessWidget {
  const InviteVisitorFormListView({
    required this.notifier,
    required this.provider,
    this.isInviteVisit = true,
    super.key,
  });

  final InviteVisitorNotifier notifier;
  final InviteEditVisitState provider;
  final bool isInviteVisit;

  @override
  Widget build(BuildContext context) {
    final cellHeight = provider.lstData.length * 80.h;
    return Column(
      children: [
        Column(
          children: [
            SecondCustomTextField(
              textEditingController: notifier.emailController,
              focusNode: notifier.emailFocus,
              hintText: S.current.str_email.mandatory(),
              isEmailField: true,
              checkEmpty: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.onChangeText,
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SecondCustomTextField(
                    textEditingController: notifier.firstNameController,
                    focusNode: notifier.firstNameFocus,
                    hintText: S.current.firstName.mandatory(),
                    checkEmpty: true,
                    onChanged: notifier.onChangeText,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: SecondCustomTextField(
                    textEditingController: notifier.lastNameController,
                    focusNode: notifier.lastNameFocus,
                    hintText: S.current.lastName.mandatory(),
                    onChanged: notifier.onChangeText,
                    checkEmpty: true,
                  ),
                ),
              ],
            ),
          ],
        ).visibility(
          visible: provider.lstData.isEmpty && isInviteVisit,
        ),
        SizedBox(
          height: cellHeight,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return VisitorListTile(
                item: provider.lstData[index],
                notifier: notifier,
                isInviteVisit: isInviteVisit,
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(height: 12.h);
            },
            itemCount: provider.lstData.length,
          ),
        )
      ],
    );
  }
}
