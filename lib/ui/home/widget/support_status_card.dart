import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';
import 'package:pif_flutter/routes/routes.dart';

import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';

class SupportStatusCard extends StatelessWidget {
  const SupportStatusCard({
    required this.tickets,
    super.key,
  });

  final SupportTicketModel tickets;

  @override
  Widget build(BuildContext context) {
    final lastActive = tickets.ticketComments!.isNotEmpty
        ? tickets.ticketComments!.last.dateCreated!.daysBetweenWithNow
        : tickets.dateModified!.daysBetweenWithNow;
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.ticketDetailsScreen,
        args: tickets,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.supportStatusBackground,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.supportStatus,
                  style: Style.commonTextStyle(
                    color: blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TicketStatus(ticketStatus: tickets.ticketStatus!),
              ],
            ),
            Text(
              '${S.current.lastActivity}: $lastActive',
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    tickets.ticketComments!.isNotEmpty
                        ? tickets.ticketComments!.last.commentDescription!
                                .removeAllHtmlTags ??
                            ''
                        : tickets.description ?? '',
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Expanded(child: SizedBox()),
                if (tickets.ticketComments != null &&
                    tickets.ticketComments!.isNotEmpty) ...[
                  if (tickets.ticketComments!.last.creator!.image != null) ...[
                    Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: whiteColor),
                        image: DecorationImage(
                          image: NetworkImage(
                            tickets.ticketComments!.last.creator!.image!
                                .getImageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ] else ...[
                    ImageProfileVisitor(
                      height: 32.h,
                      width: 32.w,
                      fontSize: 14,
                      firstName:
                          tickets.ticketComments!.last.creator!.givenName ?? '',
                      lastName:
                          tickets.ticketComments!.last.creator!.familyName ??
                              '',
                    ),
                  ],
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
