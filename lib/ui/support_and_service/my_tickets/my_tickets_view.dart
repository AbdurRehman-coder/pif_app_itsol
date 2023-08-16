import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/empty_ticket_view.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/shimmer_tickets_list_view.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_card.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_list_status.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/tickets_list_view.dart';
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
      appBar: CustomAppBar(
        titleWidget: SearchTextField(
          textEditingController: notifier.searchController,
          hintText: S.current.searchByDescription,
          onChanged: (txt) {
            _debouncer.run(() {
              notifier.onSearchTicket(txt);
            });
          },
        ),
      ),
      body: BackgroundWidget(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              if (notifier.searchController.text.isEmpty) ...[
                TicketListStatus(
                  notifier: notifier,
                  provider: provider,
                ),
              ],
              Expanded(
                child: RefreshIndicator(
                  onRefresh: notifier.getStatusAsync,
                  child: provider.lstData.when(
                    data: (data) {
                      if (data.isNotEmpty) {
                        return TicketsListView(
                          lstData: data,
                          notifier: notifier,
                          provider: provider,
                        );
                      } else {
                        return const EmptyTicketView();
                      }
                    },
                    error: (e, s) {
                      return const EmptyTicketView();
                    },
                    loading: () {
                      return const ShimmerTicketsListView();
                    },
                  ),
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
}
