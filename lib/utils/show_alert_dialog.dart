// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class ShowAlertDialog {
//   void showAppDialog(
//       {final title,
//       final message,
//       final onCancel,
//       final onConfirm,
//       final cancelColor,
//       final image,
//       final confirmColor,
//       final isCancel,
//       final confirmText = 'OK',
//       final cancelText = 'Cancel',
//       final subtitle,
//       final isSubtitle = false}) {
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         titlePadding: EdgeInsets.all(15),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: SizedBox(),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         title,
//                         maxLines: 2,
//                         style: GoogleFonts.rubik(
//                           fontSize: 20.sp,
//                           color: colorBlack,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 1.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Align(
//                         child: Icon(
//                           Icons.clear,
//                           color: colorIconGrey,
//                           size: SizeConfigs.blockSizeVertical * 3,
//                         ),
//                         alignment: Alignment.topRight,
//                       )),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: spacing_middle,
//             ),
//             SvgPicture.asset(
//               image,
//               width: SizeConfigs.blockSizeHorizontal * 20,
//             ),
//             SizedBox(height: spacing_middle),
//             Text(
//               message,
//               maxLines: 4,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.rubik(
//                 fontSize: 18.sp,
//                 color: colorBlack,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 1.0,
//               ),
//             ),
//             isSubtitle ? SizedBox(height: spacing_standard) : SizedBox(),
//             isSubtitle ? subtitle : Container(),
//           ],
//         ),
//         actionsAlignment: MainAxisAlignment.center,
//         actions: <Widget>[
//           Container(
//             alignment: Alignment.center,
//             margin: EdgeInsets.only(
//                 bottom: spacing_standard_new,
//                 left: spacing_middle,
//                 right: spacing_middle),
//             width: 350.w,
//             child: Column(
//               // Row()
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // ElevatedButton(
//                 //   child: Text(
//                 //     cancelText,
//                 //     maxLines: 4,
//                 //   ),
//                 //   style: ElevatedButton.styleFrom(
//                 //     fixedSize: Size(350.sp, 30.sp),
//                 //     onPrimary: colorWhite,
//                 //     primary: colorPrimary,
//                 //     textStyle: GoogleFonts.rubik(
//                 //       fontSize: 16.sp,
//                 //       fontWeight: FontWeight.w500,
//                 //     ),
//                 //   ),
//                 //   onPressed: onConfirm,
//                 // ),
//                 isCancel
//                     ? ElevatedButton(
//                         child: Text(
//                           cancelText,
//                           maxLines: 4,
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: Size(350.w, 30.h),
//                           onPrimary: colorWhite,
//                           primary: colorPrimary,
//                           textStyle: GoogleFonts.rubik(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         onPressed: onCancel,
//                       )
//                     // GestureDetector(
//                     //     onTap: onCancel,
//                     //     child: Container(
//                     //       padding: EdgeInsets.symmetric(horizontal: 6),
//                     //       height: SizeConfigs.blockSizeVertical * 4.5,
//                     //       width: SizeConfigs.blockSizeHorizontal * 25,
//                     //       decoration: BoxDecoration(
//                     //         color: cancelColor,
//                     //         borderRadius:
//                     //             BorderRadius.all(Radius.circular(6.0)),
//                     //       ),
//                     //       child: Center(
//                     //         child: Text(
//                     //           cancelText,
//                     //           maxLines: 4,
//                     //           textAlign: TextAlign.center,
//                     //           style: GoogleFonts.rubik(
//                     //             fontSize: 16.sp,
//                     //             color: colorBlack,
//                     //             fontWeight: FontWeight.w600,
//                     //             letterSpacing: 1.0,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   )
//                     : SizedBox(),
//                 ElevatedButton(
//                   child: Text(
//                     cancelText,
//                     maxLines: 4,
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: Size(350.w, 30.h),
//                     onPrimary: colorWhite,
//                     primary: colorPrimary,
//                     textStyle: GoogleFonts.rubik(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   onPressed: onConfirm,
//                 )
//                 // GestureDetector(
//                 //   onTap: onConfirm,
//                 //   child: Container(
//                 //     padding: EdgeInsets.symmetric(horizontal: 6),
//                 //     height: SizeConfigs.blockSizeVertical * 4.5,
//                 //     width: SizeConfigs.blockSizeHorizontal * 25,
//                 //     decoration: BoxDecoration(
//                 //       color: confirmColor,
//                 //       borderRadius: BorderRadius.all(Radius.circular(6.0)),
//                 //     ),
//                 //     child: Text(
//                 //       confirmText,
//                 //       maxLines: 4,
//                 //       textAlign: TextAlign.center,
//                 //       style: GoogleFonts.rubik(
//                 //         fontSize: 16.sp,
//                 //         color: colorBlack,
//                 //         fontWeight: FontWeight.w600,
//                 //         letterSpacing: 1.0,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // )
//               ],
//             ),
//           )
//         ],
//       ),
//   }
//
//   void showAlertDialog(
//       {final title,
//       final message,
//       final onCancel,
//       final onConfirm,
//       final cancelColor,
//       final confirmColor,
//       final isCancel,
//       final confirmText = 'OK',
//       final cancelText = 'Cancel',
//       final subtitle,
//       final isSubtitle = false}) {
//     Get.dialog(
//       AlertDialog(
//         alignment: Alignment.center,
//         scrollable: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         actionsAlignment: MainAxisAlignment.center,
//         titlePadding: EdgeInsets.all(spacing_standard_new),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: SizedBox(),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       title,
//                       maxLines: 2,
//                       style: GoogleFonts.rubik(
//                         fontSize: 20.sp,
//                         color: colorBlack,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: 1.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Align(
//                       child: Icon(
//                         Icons.clear,
//                         color: colorIconGrey,
//                         size: SizeConfigs.blockSizeVertical * 3,
//                       ),
//                       alignment: Alignment.topRight,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: spacing_standard,
//             ),
//             SizedBox(
//               height: spacing_standard,
//             ),
//             Text(
//               message,
//               maxLines: 4,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.rubik(
//                 fontSize: 16.sp,
//                 color: colorBlack,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 1.0,
//               ),
//             ),
//             isSubtitle
//                 ? SizedBox(
//                     height: spacing_standard,
//                   )
//                 : SizedBox(),
//             isSubtitle ? subtitle : Container(),
//           ],
//         ),
//         actions: <Widget>[
//           Container(
//             margin: EdgeInsets.only(
//                 bottom: spacing_standard_new,
//                 left: spacing_middle,
//                 right: spacing_middle),
//             alignment: Alignment.center,
//             width: 350.w,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 isCancel
//                     ? GestureDetector(
//                         onTap: onCancel,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 6),
//                           height: SizeConfigs.blockSizeVertical * 4.5,
//                           width: 150.w,
//                           decoration: BoxDecoration(
//                             color: cancelColor,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(6.0)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               cancelText,
//                               maxLines: 4,
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.rubik(
//                                 fontSize: 16.sp,
//                                 color: colorWhite,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     : SizedBox(),
//                 SizedBox(
//                   height: spacing_standard,
//                 ),
//                 GestureDetector(
//                   onTap: onConfirm,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 6.w),
//                     height: SizeConfigs.blockSizeVertical * 4.5,
//                     width: 150.w,
//                     decoration: BoxDecoration(
//                       color: confirmColor,
//                       borderRadius: BorderRadius.all(Radius.circular(6.r)),
//                     ),
//                     child: Center(
//                       child: Text(
//                         confirmText,
//                         maxLines: 4,
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.rubik(
//                           fontSize: 16.sp,
//                           color: colorWhite,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 1.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   showDialogLogout(
//       {String? header,
//       String? description,
//       onConfirmText,
//       String? hintText,
//       final passwordController,
//       final onConfirmFunction,
//       final onEditingComplete,
//       final onClosFunction}) {
//     Get.dialog(
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SingleChildScrollView(
//             physics: NeverScrollableScrollPhysics(),
//             child: AlertDialog(
//               alignment: Alignment.center,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               titlePadding: EdgeInsets.symmetric(horizontal: 0.w),
//               title: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 50.h,
//                       child: Stack(
//                         alignment: Alignment.centerRight,
//                         children: [
//                           Center(
//                             child: customText(header!,
//                                 fontSize: 24.sp,
//                                 fontWeight: FontWeight.w500,
//                                 textColor: colorWhite,
//                                 isCentered: true),
//                           ),
//                           GestureDetector(
//                             onTap: onClosFunction,
//                             /*() {
//                               Get.back();
//                             },*/
//                             child: Container(
//                               margin: EdgeInsets.only(right: 20.w),
//                               child: SvgPicture.asset(
//                                 logOutCancelIcon,
//                                 color: colorWhite,
//                                 height: 20.sp,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       decoration: BoxDecoration(
//                           color: colorPrimary,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10.r),
//                               topRight: Radius.circular(10.r))),
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       child: Text(
//                         description!,
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.rubik(
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.w400,
//                           color: colorBlack,
//                           height: 1.5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25.h),
//                     Padding(
//                       padding: EdgeInsets.all(20.sp),
//                       child: CustomRoundedTextfield(
//                           isPassword: true,
//                           onEditingComplete: onEditingComplete,
//                           mFocus: null,
//                           inputType: TextInputType.text,
//                           height: 53.h,
//                           width: 337.w,
//                           hintText: hintText,
//                           obscure: true,
//                           mController: passwordController,
//                           onSubmit: (v) {
//                             FocusManager.instance.primaryFocus?.unfocus();
//                           }),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 20.w, /*vertical: 20.h*/
//                             ),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 onPrimary: colorLightRed,
//                                 primary: colorRedLight,
//                                 elevation: 2.sp,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.sp)),
//                                 padding: EdgeInsets.zero,
//                               ),
//                               onPressed: onConfirmFunction,
//                               // textColor: colorLightRed,
//                               // elevation: 0,
//                               // shape: RoundedRectangleBorder(
//                               //     borderRadius: BorderRadius.circular(25.0)),
//                               // padding: const EdgeInsets.all(0.0),
//                               child: Text(
//                                 onConfirmText,
//                                 style: GoogleFonts.rubik(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500,
//                                   // color: colorLightRed,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 20.h),
//                       // height: ,
//                       decoration: BoxDecoration(
//                           color: colorPrimary,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(10.r),
//                               bottomLeft: Radius.circular(10.r))),
//                     ),
//                   ]),
//             ),
//           ),
//         ],
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   showDialogUserInactivity(
//       {String? header, String? description, final onConfirmFunction}) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         titlePadding: EdgeInsets.symmetric(horizontal: 0),
//         title: Container(
//           width: 500.w,
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 50.h,
//                   child: Stack(
//                     alignment: Alignment.centerRight,
//                     children: [
//                       Center(
//                         child: customText(header!,
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.w500,
//                             textColor: colorWhite,
//                             isCentered: true),
//                       )
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                       color: colorPrimary,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10.r),
//                           topRight: Radius.circular(10.r))),
//                 ),
//                 SizedBox(height: 20.h),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   child: Text(
//                     description!,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.rubik(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w400,
//                       color: colorBlack,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 40.w, vertical: 25.h),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             onPrimary: colorLightRed,
//                             primary: colorRedLight,
//                             elevation: 2.5.sp,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.r)),
//                             padding: EdgeInsets.zero,
//                           ),
//                           onPressed: onConfirmFunction,
//                           child: Text(
//                             'I\'m working',
//                             style: GoogleFonts.rubik(
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.w500,
//                               color: colorLightRed,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Container(
//                 //   margin: EdgeInsets.only(top: SizeConfigs.blockSizeVertical * 2),
//                 //   height: 9,
//                 //   decoration: BoxDecoration(
//                 //       color: colorPrimary,
//                 //       borderRadius: BorderRadius.only(
//                 //           bottomRight: Radius.circular(12),
//                 //           bottomLeft: Radius.circular(12))),
//                 // ),
//               ]),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   void showSuccessDialog(String? message) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         alignment: Alignment.center,
//         title: customText('Success',
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w500,
//             isCentered: true,
//             textColor: colorPrimary),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 15.h),
//             Image.asset(iconThumbsUp),
//             SizedBox(height: 30.h),
//             customText(message,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w400,
//                 textColor: colorBlack),
//           ],
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
// }
