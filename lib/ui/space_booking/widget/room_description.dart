import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';

class RoomDescription extends StatelessWidget {
  const RoomDescription({required this.description, super.key});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final provider = ref.watch(spaceBookingProvider);
        final notifier = ref.read(spaceBookingProvider.notifier);
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDescriptionLong = description.length > 120;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: provider.isReadMore!
                        ? description
                        : description.substring(
                            0,
                            isDescriptionLong ? 120 : description.length,
                          ),
                    style: Style.commonTextStyle(
                      color: grayTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      if (isDescriptionLong) ...[
                        TextSpan(
                          text: provider.isReadMore!
                              ? ' ${S.current.readLess}'
                              : ' ... ${S.current.readMore}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = notifier.toggleReadMore,
                          style: Style.commonTextStyle(
                            color: grayTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
