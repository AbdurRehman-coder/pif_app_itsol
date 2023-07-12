import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/provider/add_ticket_provider.dart';

class TeamsList extends ConsumerWidget {
  const TeamsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(addOrEditTicketProvider.notifier);
    final provider = ref.watch(addOrEditTicketProvider);
    return provider.teamList.when(
      data: (data) {
        return Wrap(
          spacing: 20.w,
          runSpacing: 10.h,
          children: data
              .map(
                (team) => InkWell(
                  onTap: () => notifier.onUpdateItem(teamsSelect: team),
                  child: Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 120.h,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.r),
                          ),
                          border: team.isTeamSelected
                              ? Border.all(color: primaryColor)
                              : null,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: team.teamImage,
                                placeholder: (context, url) => const SizedBox(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Expanded(
                              child: Text(
                                team.teamText,
                                style: Style.commonTextStyle(
                                  color: hintColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!team.isTeamSelected) ...[
                        Positioned(
                          child: Container(
                            width: 100.w,
                            height: 130.h,
                            color: expireBgColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
      error: (e, s) {
        return const SizedBox();
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
