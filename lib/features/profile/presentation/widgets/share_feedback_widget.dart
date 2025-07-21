import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShareExperienceWidget extends StatelessWidget {
  final TextEditingController _feedbackController = TextEditingController();
  ShareExperienceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Give us feedback',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          const Text(
            'Share your experience so that we can make the app better for you.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
            ),
          ),
          SizedBox(height: 2.h),
          //
          TextFormField(
            controller: _feedbackController,
            minLines: 8,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Please share your experience with the app.',
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          SizedBox(height: 2.h),
          //
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add your submit logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 6.h),
              ),
              child: const Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
