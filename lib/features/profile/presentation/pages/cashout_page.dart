import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/cashoutRequestsBloc/cashout_requests_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/cashout_header.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/cashout_request_list.dart';

class CashoutPage extends StatefulWidget {
  const CashoutPage({super.key});

  @override
  State<CashoutPage> createState() => _CashoutPageState();
}

class _CashoutPageState extends State<CashoutPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    context.read<CashoutRequestsBloc>().add(getCashoutRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CashoutHeaderSection(),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF2F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                indicatorColor: const Color(0xffF2F4F6),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                indicatorWeight: .001,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _tabIndex == 0
                          ? const Color(0xff18786a)
                          : Colors.transparent,
                    ),
                    child: Text(
                      'Pending',
                      style: TextStyle(
                          color: _tabIndex == 0 ? Colors.white : Colors.black,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _tabIndex == 1
                          ? const Color(0xff18786a)
                          : Colors.transparent,
                    ),
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: _tabIndex == 1 ? Colors.white : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: BlocBuilder<CashoutRequestsBloc, CashoutRequestsState>(
              builder: (context, state) {
                if (state is CashoutRequestsFailedState) {
                  return const Center(
                    child: Text('Error happend!'),
                  );
                } else if (state is CashoutRequestsLoadingState) {
                  return const Center(
                    child: CustomProgressIndicator(),
                  );
                } else if (state is CashoutRequestsLoadedState) {
                  final userAccounts = state.userCashoutRequestsEntity.accounts;
                  final pendingRequests =
                      state.userCashoutRequestsEntity.pending;
                  final history = state.userCashoutRequestsEntity.history;
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      RequestsList(
                        requests: pendingRequests,
                      ),
                      RequestsList(
                        requests: history,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}


