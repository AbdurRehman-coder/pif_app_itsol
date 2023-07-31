import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class SlidingToast extends StatefulWidget {
  final String message;
  final VoidCallback onCancel;

  SlidingToast({required this.message, required this.onCancel});

  @override
  _SlidingToastState createState() => _SlidingToastState();
}

class _SlidingToastState extends State<SlidingToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 120.h),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              color: darkPrimaryColor,
              height: 70.h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Text(
                        widget.message.toString(),
                        style: TextStyle(
                          color: grayC0,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _animationController.reverse().whenComplete(() {
                        widget.onCancel();
                      });
                    },
                    child: Text(
                      'Cancel Booking',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Show the sliding toast, Use this code on button tap
// showGeneralDialog(
//   context: context,
//   barrierDismissible: true,
//   barrierLabel: '',
//   transitionDuration:
//   const Duration(milliseconds: 400),
//   pageBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double>
//       secondaryAnimation,
//       ) {
//     return Center(
//       child: SlidingToast(
//         message:
//         'Space Booked, did you book this by mistake?',
//         onCancel: () {
//           // Handle cancel booking
//           Navigator.of(context).pop();
//           ScaffoldMessenger.of(context)
//               .showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'Booking canceled!',
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   },
// );
