import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:realtim_innovation_assigment/bloc/addemployee/add_employee_bloc.dart';
import 'package:realtim_innovation_assigment/bloc/employeelistscreen/employee_list_bloc.dart';
import 'package:realtim_innovation_assigment/components/my_form_field.dart';
import 'package:realtim_innovation_assigment/utils/colors_utils.dart';
import 'package:realtim_innovation_assigment/utils/common_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../components/standard_app_bar.dart';
import '../../../../components/standard_regular_text.dart';
import '../../../../model/employee_model.dart';
import '../../../../utils/images_utils.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/strings.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  List<String> listEmployeeType = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime focusedFromDay = DateTime.now();
  DateTime? selectedFromDay;
  DateTime focusedToDay = DateTime.now();
  DateTime? selectedToDay;
  String? formattedFromDate;
  String? formattedToDate = "";
  String? strSelectedEmployeeType;
  int? id;
  late AddEmployeeBloc addEmployeeBloc;
  late EmployeeListBloc employeeListBloc;
  bool isEdit = false;
  TextEditingController textEditingFullName = TextEditingController();

  @override
  void initState() {
    initController();
    super.initState();
  }

  void initController() {
    addEmployeeBloc = BlocProvider.of<AddEmployeeBloc>(context);
    employeeListBloc = BlocProvider.of<EmployeeListBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      if (ModalRoute.of(context)!.settings.arguments != null) {
        Employee employeeData =
            ModalRoute.of(context)!.settings.arguments as Employee;
        setState(() {
          id = employeeData.id;
          textEditingFullName.text = employeeData.strFullName!;

          selectedFromDay =
              DateFormat("d MMM yyyy").parse(employeeData.strFromDate!);
          if (employeeData.strToDate != null && employeeData.strToDate != "") {
            selectedToDay =
                DateFormat("d MMM yyyy").parse(employeeData.strToDate!);
            formattedToDate = employeeData.strToDate!;
          }
          formattedFromDate = employeeData.strFromDate!;

          strSelectedEmployeeType = employeeData.strEmployeeType;
          isEdit = true;
        });
      } else {
        isEdit = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: StandardAppbar(
        title: StandardCustomText(
          label: isEdit ? lblEditEmployee : lblAddEmployee,
          align: TextAlign.start,
          color: whiteColor,
          fontSize: SizeConfig.safeBlockVertical! * 1.9,
        ),
        widgets: [
          isEdit
              ? BlocConsumer<EmployeeListBloc, EmployeeListState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is OnEmployeeByIdDeleted) {
                      const snackBar = SnackBar(
                        content: Text('Employee data has been deleted'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      clearAll();
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                        onTap: () {
                          employeeListBloc.add(DeleteEmployeeByID(id!));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.safeBlockHorizontal! * 3.5),
                          child: SvgPicture.asset(
                            deleteIcon,
                            fit: BoxFit.none,
                          ),
                        ));
                  },
                )
              : const SizedBox(),
        ],
      ),
      body: Column(
        children: [
          addNewEmployeeWidget(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: saveCancelButton(),
          ))
        ],
      ),
    );
    // ),
  }

  Widget saveCancelButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: primaryTransparentColor, width: 0.4),
                      color: primaryTransparentColor,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.safeBlockVertical! * 0.6,
                      )),
                  child: const Center(
                    child: StandardCustomText(
                      label: "Cancel",
                      color: primaryColor,
                      align: TextAlign.start,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ))),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal! * 1.9,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                  if (_formKey.currentState!.validate()) {
                    onSaveButtonClicked();
                  }
                },
                child: Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 0.4),
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.safeBlockVertical! * 0.6,
                      )),
                  child: const Center(
                    child: StandardCustomText(
                        label: "Save",
                        color: whiteColor,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w500),
                  ),
                ))),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal! * 1.9,
        ),
      ],
    );
  }

  Widget addNewEmployeeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical! * 5,
          left: SizeConfig.safeBlockHorizontal! * 2.5,
          right: SizeConfig.safeBlockHorizontal! * 2.5),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 1),
                child: CustomFormField(
                    isIconDisplay: true,
                    icon: userIcon,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.toString().trim().isEmpty) {
                        return nameError;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    controller: textEditingFullName,
                    labelText: lblEmployeeName),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 1),
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (context) {
                              return SizedBox(
                                height: SizeConfig.safeBlockVertical! * 30,
                                child: ListView.builder(
                                    itemCount: listEmployeeType.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              strSelectedEmployeeType =
                                                  listEmployeeType[index];
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title: Center(
                                                      child: Text(
                                                          listEmployeeType[
                                                              index]))),
                                              Container(
                                                height: SizeConfig
                                                        .safeBlockVertical! *
                                                    0.01,
                                                color: blackColor,
                                              )
                                            ],
                                          ));
                                    }),
                              );
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: textColor, width: 0.4),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.safeBlockVertical! * 0.6,
                            )),
                        child: Padding(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockVertical! * 1.5),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                suitCaseIcon,
                                fit: BoxFit.none,
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockVertical! * 1.5,
                              ),
                              Expanded(
                                  child: StandardCustomText(
                                      label: strSelectedEmployeeType == null
                                          ? "Select Role"
                                          : strSelectedEmployeeType!,
                                      color: textColor,
                                      align: TextAlign.start,
                                      fontWeight: FontWeight.w500,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: primaryTextColor,
                                      ))),
                              SvgPicture.asset(
                                downArrowIcon,
                                fit: BoxFit.none,
                              ),
                            ],
                          ),
                        ),
                      ))),
              Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 1),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                showCalenderDialog(
                                    selectedFromDay, focusedFromDay, true);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: textColor, width: 0.4),
                                    borderRadius: BorderRadius.circular(
                                      SizeConfig.safeBlockVertical! * 0.6,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.safeBlockVertical! * 1.5),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        dateIcon,
                                        fit: BoxFit.none,
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.safeBlockVertical! * 1.5,
                                      ),
                                      Expanded(
                                          child: StandardCustomText(
                                              label: formattedFromDate == null
                                                  ? "Today"
                                                  : formattedFromDate!,
                                              color: textColor,
                                              align: TextAlign.start,
                                              fontWeight: FontWeight.w500,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: primaryTextColor,
                                              ))),
                                    ],
                                  ),
                                ),
                              ))),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal! * 2.5,
                            right: SizeConfig.safeBlockHorizontal! * 2.5),
                        child: SvgPicture.asset(
                          rightArrowIcon,
                          fit: BoxFit.none,
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                showCalenderDialog(
                                    selectedToDay, focusedToDay, false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: textColor, width: 0.4),
                                    borderRadius: BorderRadius.circular(
                                      SizeConfig.safeBlockVertical! * 0.6,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.safeBlockVertical! * 1.5),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        dateIcon,
                                        fit: BoxFit.none,
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.safeBlockVertical! * 1.5,
                                      ),
                                      Expanded(
                                          child: StandardCustomText(
                                              label: formattedToDate == ""
                                                  ? "No date"
                                                  : formattedToDate!,
                                              color: textColor,
                                              align: TextAlign.start,
                                              fontWeight: FontWeight.w500,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: primaryTextColor,
                                              ))),
                                    ],
                                  ),
                                ),
                              ))),
                    ],
                  )),
            ],
          )),
    );
  }

  Future<void> showCalenderDialog(
      DateTime? selectedDay, DateTime focusedDay, bool isFromDate) async {
    int intSelected = 0;
    String? formattedDate;
    DateTime? selectedDay;
    DateTime focusedDay = DateTime.now();
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: AlertDialog(
                insetPadding: const EdgeInsets.all(5),
                content: Material(
                    color: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        height: SizeConfig.blockSizeVertical! * 70,
                        // margin: const EdgeInsets.symmetric(horizontal: 3),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              selectedDay != null
                                  ? isFromDate
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 0;
                                                        selectedDay =
                                                            DateTime.now();
                                                        focusedDay =
                                                            DateTime.now();
                                                        DateFormat formatter =
                                                            DateFormat(
                                                                'd MMM yyyy');
                                                        formattedDate =
                                                            formatter.format(
                                                                selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      0
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  0
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child:
                                                            StandardCustomText(
                                                          label: "Today",
                                                          color: intSelected ==
                                                                  0
                                                              ? whiteColor
                                                              : primaryColor,
                                                          align:
                                                              TextAlign.start,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 1;
                                                        selectedDay =
                                                            selectedDay!.next(
                                                                DateTime
                                                                    .monday);
                                                        focusedDay = focusedDay
                                                            .next(DateTime
                                                                .monday);
                                                        DateFormat formatter =
                                                            DateFormat(
                                                                'd MMM yyyy');
                                                        formattedDate =
                                                            formatter.format(
                                                                selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      1
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  1
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child: StandardCustomText(
                                                            label:
                                                                "Next Monday",
                                                            color: intSelected ==
                                                                    1
                                                                ? whiteColor
                                                                : primaryColor,
                                                            align:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 0;

                                                        formattedDate =
                                                            'No date';
                                                        selectedToDay = null;
                                                        formattedToDate = "";
                                                        // selectedDay =
                                                        //     DateTime.now();
                                                        // focusedDay =
                                                        //     DateTime.now();
                                                        // DateFormat formatter =
                                                        // DateFormat('d MMM yyyy');
                                                        // formattedDate = formatter
                                                        //     .format(selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      0
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  0
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child:
                                                            StandardCustomText(
                                                          label: "No date",
                                                          color: intSelected ==
                                                                  0
                                                              ? whiteColor
                                                              : primaryColor,
                                                          align:
                                                              TextAlign.start,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 1;
                                                        selectedDay =
                                                            selectedDay!.next(
                                                                DateTime
                                                                    .monday);
                                                        focusedDay = focusedDay
                                                            .next(DateTime
                                                                .monday);
                                                        DateFormat formatter =
                                                            DateFormat(
                                                                'd MMM yyyy');
                                                        formattedDate =
                                                            formatter.format(
                                                                selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      1
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  1
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child: StandardCustomText(
                                                            label:
                                                                "Next Monday",
                                                            color: intSelected ==
                                                                    1
                                                                ? whiteColor
                                                                : primaryColor,
                                                            align:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                          ],
                                        )
                                  : const SizedBox(),
                              selectedDay != null
                                  ? SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    )
                                  : const SizedBox(),
                              selectedDay != null
                                  ? isFromDate
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 2;
                                                        selectedDay =
                                                            selectedDay!.next(
                                                                DateTime
                                                                    .tuesday);
                                                        focusedDay = focusedDay!
                                                            .next(DateTime
                                                                .tuesday);
                                                        DateFormat formatter =
                                                            DateFormat(
                                                                'd MMM yyyy');
                                                        formattedDate =
                                                            formatter.format(
                                                                selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      2
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  2
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child:
                                                            StandardCustomText(
                                                          label: "Next Tuesday",
                                                          color: intSelected ==
                                                                  2
                                                              ? whiteColor
                                                              : primaryColor,
                                                          align:
                                                              TextAlign.start,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                            Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        intSelected = 3;
                                                        selectedDay =
                                                            selectedDay!.add(
                                                                const Duration(
                                                                    days: 7));
                                                        focusedDay = focusedDay!
                                                            .add(const Duration(
                                                                days: 7));
                                                        DateFormat formatter =
                                                            DateFormat(
                                                                'd MMM yyyy');
                                                        formattedDate =
                                                            formatter.format(
                                                                selectedDay!);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: SizeConfig
                                                              .safeBlockVertical! *
                                                          5.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: intSelected ==
                                                                      3
                                                                  ? primaryColor
                                                                  : primaryTransparentColor,
                                                              width: 0.4),
                                                          color: intSelected ==
                                                                  3
                                                              ? primaryColor
                                                              : primaryTransparentColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            SizeConfig
                                                                    .safeBlockVertical! *
                                                                0.6,
                                                          )),
                                                      child: Center(
                                                        child:
                                                            StandardCustomText(
                                                          label:
                                                              "After One Week",
                                                          color: intSelected ==
                                                                  3
                                                              ? whiteColor
                                                              : primaryColor,
                                                          align:
                                                              TextAlign.start,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ))),
                                            SizedBox(
                                              width: SizeConfig
                                                      .safeBlockHorizontal! *
                                                  1.9,
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                              Container(
                                color: whiteColor,
                                height: SizeConfig.safeBlockVertical! * 50,
                                width: SizeConfig.safeBlockHorizontal! * 140,
                                child: TableCalendar(
                                  focusedDay: focusedDay,
                                  onDaySelected: (selectedDayCalender,
                                      focusedDayCalender) {
                                    if (!isSameDay(
                                        selectedDay, selectedDayCalender)) {
                                      setState(() {
                                        selectedDay = selectedDayCalender;
                                        focusedDay = focusedDayCalender;

                                        DateFormat formatter =
                                            DateFormat('d MMM yyyy');
                                        formattedDate = formatter
                                            .format(selectedDayCalender);
                                      });
                                    }
                                  },
                                  selectedDayPredicate: (day) {
                                    return isSameDay(selectedDay, day);
                                  },
                                  firstDay: DateTime.utc(2010, 10, 20),
                                  lastDay: DateTime.utc(2040, 10, 20),
                                  headerVisible: true,
                                  daysOfWeekVisible: true,
                                  sixWeekMonthsEnforced: true,
                                  shouldFillViewport: false,
                                  headerStyle: HeaderStyle(
                                      headerPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.safeBlockHorizontal! *
                                                  11,
                                          vertical: 10.0),
                                      titleCentered: true,
                                      formatButtonVisible: false,
                                      leftChevronIcon: SvgPicture.asset(
                                        greyLeftArrowIcon,
                                        fit: BoxFit.none,
                                      ),
                                      rightChevronIcon: SvgPicture.asset(
                                        greyRightArrowIcon,
                                        fit: BoxFit.none,
                                      ),
                                      titleTextStyle: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical! *
                                                  1.5)),
                                  calendarStyle: CalendarStyle(
                                      // isTodayHighlighted: true,
                                      selectedDecoration: const BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      selectedTextStyle: const TextStyle(
                                          color: whiteColor,
                                          backgroundColor: primaryColor),
                                      todayDecoration: BoxDecoration(
                                        border: Border.all(
                                            color: primaryColor, width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                      todayTextStyle: const TextStyle(
                                          color: negativeButtonColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          dateIcon,
                                          fit: BoxFit.none,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.safeBlockVertical! * 1,
                                        ),
                                        Expanded(
                                            child: StandardCustomText(
                                                label: selectedDay == null
                                                    ? ""
                                                    : formattedDate != null
                                                        ? formattedDate!
                                                        : "",
                                                color: textColor,
                                                align: TextAlign.start,
                                                fontWeight: FontWeight.w500,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: primaryTextColor,
                                                ))),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Container(
                                                  width: SizeConfig
                                                          .safeBlockHorizontal! *
                                                      20,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              primaryTransparentColor,
                                                          width: 0.4),
                                                      color:
                                                          primaryTransparentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        SizeConfig
                                                                .safeBlockVertical! *
                                                            0.6,
                                                      )),
                                                  child: const Center(
                                                    child: StandardCustomText(
                                                      label: "Cancel",
                                                      color: primaryColor,
                                                      align: TextAlign.start,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ))),
                                        SizedBox(
                                          width:
                                              SizeConfig.safeBlockHorizontal! *
                                                  1.9,
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: InkWell(
                                                onTap: () {
                                                  if (isFromDate) {
                                                    if (selectedToDay != null) {
                                                      // DateTime now = DateTime.now();
                                                      DateTime tempDate =
                                                          DateFormat(
                                                                  "d MMM yyyy")
                                                              .parse(
                                                                  formattedToDate!);
                                                      int intDay = DateTime(
                                                              tempDate.year,
                                                              tempDate.month,
                                                              tempDate.day)
                                                          .difference(DateTime(
                                                              selectedDay!.year,
                                                              selectedDay!
                                                                  .month,
                                                              selectedDay!.day))
                                                          .inDays;
                                                      if (intDay < 0) {
                                                        CommonUtils.utils.showToast(
                                                            "Selected date is smaller then last day of working(to date)",
                                                            backgroundColor:
                                                                redColor,
                                                            textColor:
                                                                whiteColor);
                                                      } else {
                                                        selectedFromDay =
                                                            selectedDay;
                                                        focusedFromDay =
                                                            focusedDay;
                                                        formattedFromDate =
                                                            formattedDate;
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    } else {
                                                      selectedFromDay =
                                                          selectedDay;
                                                      focusedFromDay =
                                                          focusedDay;
                                                      formattedFromDate =
                                                          formattedDate;
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  } else {
                                                    if (selectedFromDay !=
                                                        null) {
                                                      if (formattedFromDate !=
                                                          null) {
                                                        DateTime tempDate =
                                                            DateFormat(
                                                                    "d MMM yyyy")
                                                                .parse(
                                                                    formattedFromDate!);
                                                        int intDay = DateTime(
                                                                tempDate.year,
                                                                tempDate.month,
                                                                tempDate.day)
                                                            .difference(
                                                                DateTime(
                                                                    selectedDay!
                                                                        .year,
                                                                    selectedDay!
                                                                        .month,
                                                                    selectedDay!
                                                                        .day))
                                                            .inDays;

                                                        if (intDay > 0) {
                                                          CommonUtils.utils.showToast(
                                                              "Selected date is smaller then staring day of working(from date)",
                                                              backgroundColor:
                                                                  redColor,
                                                              textColor:
                                                                  whiteColor);
                                                        } else {
                                                          selectedToDay =
                                                              selectedDay;
                                                          focusedToDay =
                                                              focusedDay;
                                                          formattedToDate =
                                                              formattedDate;
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      } else {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    } else {
                                                      int intDay = DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                  .day)
                                                          .difference(DateTime(
                                                              selectedDay!.year,
                                                              selectedDay!
                                                                  .month,
                                                              selectedDay!.day))
                                                          .inDays;

                                                      if (intDay > 0) {
                                                        CommonUtils.utils.showToast(
                                                            "Selected date is smaller then staring day of working(From date)",
                                                            backgroundColor:
                                                                redColor,
                                                            textColor:
                                                                whiteColor);
                                                      } else {
                                                        selectedToDay =
                                                            selectedDay;
                                                        focusedToDay =
                                                            focusedDay;
                                                        formattedToDate =
                                                            formattedDate;
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: SizeConfig
                                                          .safeBlockHorizontal! *
                                                      20,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: primaryColor,
                                                          width: 0.4),
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        SizeConfig
                                                                .safeBlockVertical! *
                                                            0.6,
                                                      )),
                                                  child: const Center(
                                                    child: StandardCustomText(
                                                        label: "Save",
                                                        color: whiteColor,
                                                        align: TextAlign.start,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))),
              ),
              // ),
            );
          });
        });
  }

  void onSaveButtonClicked() {
    if (strSelectedEmployeeType == null) {
      CommonUtils.utils.showToast(employeeTypeError,
          backgroundColor: redColor, textColor: whiteColor);
    }
    // else if (formattedFromDate == null) {
    //   CommonUtils.utils.showToast(fromError,
    //       backgroundColor: redColor, textColor: whiteColor);
    // }
    // else if (formattedToDate == null) {
    //   CommonUtils.utils
    //       .showToast(toError, backgroundColor: redColor, textColor: whiteColor);
    // }
    else {
      if (formattedToDate == "No date") {
        formattedToDate = "";
      }
      if (formattedFromDate == null) {
        selectedFromDay = DateTime.now();
        DateFormat formatter = DateFormat('d MMM yyyy');
        formattedFromDate = formatter.format(selectedFromDay!);
      }

      if (!isEdit) {
        addEmployeeBloc.add(AddEmployeeSubmittedEvent(textEditingFullName.text,
            strSelectedEmployeeType!, formattedFromDate!, formattedToDate!));
        clearAll();
      } else {
        addEmployeeBloc.add(EditEmployeeSubmittedEvent(
            id!,
            textEditingFullName.text,
            strSelectedEmployeeType!,
            formattedFromDate!,
            formattedToDate!));
        clearAll();
      }
    }
  }

  clearAll() {
    setState(() {
      id = null;
      textEditingFullName.clear();
      strSelectedEmployeeType = null;
      formattedFromDate = null;
      formattedToDate = "";
      isEdit = false;
    });
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
