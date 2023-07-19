import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/empty_ticket_view.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_card.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_list_status.dart';
import 'package:pif_flutter/widgets/debouncer.dart';

class MyTicketsView extends ConsumerStatefulWidget {
  const MyTicketsView({
    super.key,
  });

  @override
  ConsumerState createState() => _MyTicketsViewState();
}

class _MyTicketsViewState extends ConsumerState<MyTicketsView> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(myTicketsProvider);
    final notifier = ref.read(myTicketsProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: AppRouter.pop,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 22,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SearchTextField(
            textEditingController: notifier.searchController,
            hintText: S.current.searchByDescription,
            onChanged: (txt) {
              _debouncer.run(() {
                notifier.onSearchTicket(txt);
              });
            },
          ),
        ),
        titleSpacing: 0,
      ),
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: [
              expireBgColor,
              expireBgColor,
              expireBgColor,
              gray98.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              if (notifier.searchController.text.isEmpty) ...[
                TicketListStatus(
                  notifier: notifier,
                  provider: provider,
                ),
              ],
              Expanded(
                child: provider.lstData.when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      return _setListView(notifier, provider, data);
                    } else {
                      return const EmptyTicketView();
                    }
                  },
                  error: (e, s) {
                    return const EmptyTicketView();
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => AppRouter.pushNamed(Routes.addOrEditTicketScreen),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 21.w),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.forum,
                    colorFilter: const ColorFilter.mode(
                      whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    S.current.getSupport,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setListView(
    MyTicketsNotifier notifier,
    MyTicketsState provider,
    List<SupportTicketModel> lstData,
  ) {
    return RefreshIndicator(
      onRefresh: notifier.getMyTickets,
      child: ListView.separated(
        controller: notifier.scrollController,
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 60.h, top: 10.h),
        itemBuilder: (_, index) {
          if (lstData.length == index) {
            return Center(
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ).visibility(visible: provider.isLoading);
          }
          return TicketCard(
            ticketModel: lstData[index],
            index: index,
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: lstData.length + 1,
      ),
    );
  }
}
