import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/alert_popup.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    required this.selectedVisit,
    this.isFromDetails = false,
    super.key,
  });

  final VisitModel? selectedVisit;

  final bool? isFromDetails;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(visitListProvider.notifier);
        return PopupMenuButton(
          padding: EdgeInsets.only(top: 5.h),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              onTap: () => notifier.navigateToEditVisit(
                selectedVisit: selectedVisit,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.editIcon,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    S.of(context).edit,
                    style: Style.commonTextStyle(
                      color: dayTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              onTap: () => Future.delayed(
                const Duration(milliseconds: 200),
                () {
                  alertPopup(
                    context: context,
                    deleteMessage: S.current.deleteVisitMessage,
                    onClickYes: () => notifier.cancelVisit(
                      context: context,
                      visitId: selectedVisit!.id,
                    ),
                  );
                },
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.trashBit,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    S.of(context).delete,
                    style: Style.commonTextStyle(
                      color: dayTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ],
          icon: Align(
            alignment: Alignment.topRight,
            child: isFromDetails!
                ? Container(
                    height: 34.h,
                    width: 34.w,
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeBgColor,
                    ),
                    child: const Icon(
                      Icons.more_vert_outlined,
                      color: grayTextColor,
                    ),
                  )
                : const Icon(
                    Icons.more_vert_outlined,
                    color: grayTextColor,
                  ),
          ),
          color: whiteColor,
          elevation: 2,
        );
      },
    );
  }
}
