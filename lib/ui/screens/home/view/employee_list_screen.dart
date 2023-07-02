import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtim_innovation_assigment/bloc/employeelistscreen/employee_list_bloc.dart';
import 'package:realtim_innovation_assigment/model/employee_model.dart';
import 'package:realtim_innovation_assigment/utils/colors_utils.dart';

import '../../../../components/standard_app_bar.dart';
import '../../../../components/standard_regular_text.dart';
import '../../../../utils/images_utils.dart';
import '../../../../utils/route_names.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/strings.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  EmployeeListBloc employeeListBloc = EmployeeListBloc();
  List<Employee?> employeeCurrentListModel = [];
  List<Employee?> employeePreviousListModel = [];

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    employeeListBloc = BlocProvider.of<EmployeeListBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      employeeListBloc.add(
          GetEmployeeList(employeeCurrentListModel, employeePreviousListModel));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: StandardAppbar(
        title: StandardCustomText(
          label: lblEmployeeList,
          color: whiteColor,
          fontSize: SizeConfig.safeBlockVertical! * 1.9,
        ),
      ),
      body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is OnEmployeeListLoaded) {
            employeeCurrentListModel.clear();
            employeePreviousListModel.clear();
            employeeCurrentListModel = state.employeeCurrentListModel;
            employeePreviousListModel = state.employeePreviousListModel;
          }
          if (state is OnEmployeeByIdDeleted) {
            employeeCurrentListModel.clear();
            employeePreviousListModel.clear();
            employeeListBloc.add(GetEmployeeList(
                employeeCurrentListModel, employeePreviousListModel));
          }
        },
        builder: (context, state) {
          return employeeCurrentListModel.isNotEmpty ||
                  employeePreviousListModel.isNotEmpty
              ? employeeListWidget()
              : noRecordFoundWidget();
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: routeAddNewEmployee,
        tooltip: 'Add Employee',
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: const Icon(Icons.add, color: whiteColor),
      ), // This trailing com,
    );
  }

  void routeAddNewEmployee() {
    Navigator.pushNamed(context, routeAddEmployee).whenComplete(() =>
        employeeListBloc.add(GetEmployeeList(
            employeeCurrentListModel, employeePreviousListModel)));
  }

  Widget employeeListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        employeeCurrentListModel.isNotEmpty
            ? Container(
                color: bgColor,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 2.5),
                  child: StandardCustomText(
                    align: TextAlign.start,
                    label: lblCurrentEmployee,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.safeBlockVertical! * 2.5,
                  ),
                ),
              )
            : SizedBox(),
        employeeCurrentListModel.isNotEmpty
            ? Expanded(
                flex: 1,
                child: BlocProvider(
                  create: (context) => employeeListBloc,
                  child: currentEmployeeListView(),
                ),
              )
            : SizedBox(),
        employeePreviousListModel.isNotEmpty
            ? Container(
                color: bgColor,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 2.5),
                  child: StandardCustomText(
                    align: TextAlign.start,
                    label: lblPreviousEmployee,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.safeBlockVertical! * 2.5,
                  ),
                ),
              )
            : SizedBox(),
        employeePreviousListModel.isNotEmpty
            ? Expanded(
                flex: 1,
                child: BlocProvider(
                  create: (context) => employeeListBloc,
                  child: previousEmployeeListView(),
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget noRecordFoundWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          noRecordFound,
          fit: BoxFit.none,
        ),
        StandardCustomText(
          label: lblNoEmployeeRecord,
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.safeBlockVertical! * 1.9,
        )
      ],
    ));
  }

  currentEmployeeListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black12,
      ),
      itemCount: employeeCurrentListModel.isNotEmpty
          ? employeeCurrentListModel.length
          : 0,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            employeeListBloc
                .add(DeleteEmployeeByID(employeeCurrentListModel[index]!.id!));
          },

          // This will show up when the user performs dismissal action
          // It is a red background and a trash icon
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.safeBlockHorizontal! * 3.5),
              child: SvgPicture.asset(
                deleteIcon,
                fit: BoxFit.none,
              ),
            ),
          ),

          // Display item's title, price...
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, routeAddEmployee,
                        arguments: employeeCurrentListModel[index])
                    .then((value) {
                  setState(() {
                    employeeListBloc.add(GetEmployeeList(
                        employeeCurrentListModel, employeePreviousListModel));
                  });
                });
                // .whenComplete(() => employeeListBloc.add(GetEmployeeList(
                //     employeeCurrentListModel, employeePreviousListModel)));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListTile(
                  title: StandardCustomText(
                      align: TextAlign.start,
                      label: employeeCurrentListModel[index]!.strFullName!,
                      fontSize: SizeConfig.blockSizeVertical! * 2.3,
                      color: blackColor),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 1),
                        child: Text(
                            employeeCurrentListModel[index]!.strEmployeeType!),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 1,
                            bottom: SizeConfig.blockSizeVertical! * 1),
                        child: Text(
                            '${employeeCurrentListModel[index]!.strFromDate!} '
                            // ' - ${employeeCurrentListModel[index]!.strToDate!}'
                            ''),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  previousEmployeeListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black12,
      ),
      itemCount: employeePreviousListModel.isNotEmpty
          ? employeePreviousListModel.length
          : 0,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            employeeListBloc
                .add(DeleteEmployeeByID(employeePreviousListModel[index]!.id!));
          },
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.safeBlockHorizontal! * 3.5),
              child: SvgPicture.asset(
                deleteIcon,
                fit: BoxFit.none,
              ),
            ),
          ),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, routeAddEmployee,
                        arguments: employeePreviousListModel[index])
                    .whenComplete(() => employeeListBloc.add(GetEmployeeList(
                        employeeCurrentListModel, employeePreviousListModel)));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListTile(
                  title: StandardCustomText(
                      align: TextAlign.start,
                      label: employeePreviousListModel[index]!.strFullName!,
                      fontSize: SizeConfig.blockSizeVertical! * 2.3,
                      color: blackColor),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 1),
                        child: Text(
                            employeePreviousListModel[index]!.strEmployeeType!),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 1,
                            bottom: SizeConfig.blockSizeVertical! * 1),
                        child: Text(
                            '${employeePreviousListModel[index]!.strFromDate!}  - ${employeePreviousListModel[index]!.strToDate!}'),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
