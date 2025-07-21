import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/bloc/allFriendsBloc/friends_bloc.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/friends_tab.dart';
import 'package:skill_bridge_mobile/features/friends/presentation/widgets/requests_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendsMainPage extends StatefulWidget {
  const FriendsMainPage({super.key});

  @override
  State<FriendsMainPage> createState() => _FriendsMainPageState();
}

class _FriendsMainPageState extends State<FriendsMainPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _tabIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(const GetFriendsEvent());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(() {});
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddFriendspageRoute().go(context);
        },
        backgroundColor: const Color(0xff18786a),
        child: const Icon(
          Icons.person_add_alt_1_sharp,
          color: Colors.white,
          size: 25,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 8.h,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        title: Text(
          AppLocalizations.of(context)!.friends,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       AddFriendspageRoute().go(context);
        //     },
        //     icon: const Icon(Icons.person_add_alt_1_sharp),
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Column(
          children: [
            Container(
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
                indicatorPadding: EdgeInsets.symmetric(horizontal: 20.w),
                indicatorWeight: .001,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _tabIndex == 0
                          ? const Color(0xff1A7A6C)
                          : Colors.transparent,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.friends,
                      style: TextStyle(
                          color: _tabIndex == 0 ? Colors.white : Colors.black,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _tabIndex == 1
                          ? const Color(0xff1A7A6C)
                          : Colors.transparent,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.requests,
                      style: TextStyle(
                        color: _tabIndex == 1 ? Colors.white : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FriendsTab(),
                  RequestsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
