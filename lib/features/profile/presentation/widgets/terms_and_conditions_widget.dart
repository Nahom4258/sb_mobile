import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/settings_content_entity.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.conditions,
  });
  final SettingsContentEntity conditions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              conditions.header,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Effective Date: ${conditions.date}',
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: conditions.singleContent.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conditions.singleContent[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                conditions.singleContent[index].contents.length,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                // const Text('• '),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:3.0),
                                    child: Text(
                                      conditions
                                          .singleContent[index].contents[idx],
                                      style: const TextStyle(
                                          fontSize: 13.0, fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
