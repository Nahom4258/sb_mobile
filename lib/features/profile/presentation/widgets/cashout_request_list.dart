import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/widgets/empty_list_widget.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/withdraw_requests_entity.dart';

class RequestsList extends StatelessWidget {
  const RequestsList({
    super.key,
    required this.requests,
  });
  final List<WithdrawRequestsEntity> requests;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        // child: Text(
        //   'No Requests',
        //   style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
        // ),
        child: EmptyListWidget(
            message: 'You have not requests',
            icon: 'assets/images/illustration.svg'),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F4F6),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/cashoutSent.png',
                  height: 25,
                  width: 25,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sent',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          child: Text(
                            requests[index].accountId,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd').format(requests[index].date),
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                requests[index].ammountInCash.toStringAsFixed(2),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 3.h,
        ),
        itemCount: requests.length,
      ),
    );
  }
}
