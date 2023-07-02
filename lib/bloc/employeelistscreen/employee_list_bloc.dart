import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:realtim_innovation_assigment/model/employee_model.dart';

import '../../provider/db_provider.dart';

part 'employee_list_event.dart';

part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(EmployeeListInitial()) {
    // on<EmployeeListEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<GetEmployeeList>((event, emit) async {
      var res = await DBProvider.db.getAllEmployees();
      if (res.isNotEmpty) {
        List<Employee> employeeCurrentListModel = [];
        List<Employee> employeePreviousListModel = [];

        // employeeCurrentListModel=res.where((element) => element.strToDate=="");
        for (int i = 0; i < res.length; i++) {
          if (res[i].strToDate == "") {
            employeeCurrentListModel.add(res[i]);
          } else {
            if (res[i].strToDate != null) {
              // DateTime curren
              DateTime now = DateTime.now();
              DateTime tempDate =
                   DateFormat("d MMM yyyy").parse(res[i].strToDate!);
              int intDay = DateTime(tempDate.year, tempDate.month, tempDate.day)
                  .difference(DateTime(now.year, now.month, now.day))
                  .inDays;
              if (intDay < 0) {
                employeePreviousListModel.add(res[i]);
              } else {
                employeeCurrentListModel.add(res[i]);
              }
            }
          }
        }
        emit(OnEmployeeListLoaded(
            employeeCurrentListModel, employeePreviousListModel));
      }
    });
    on<DeleteEmployeeByID>((event, emit) async {
      var res = await DBProvider.db.deleteEmployeesByID(event.id);
      // if (res)
      {
        emit(OnEmployeeByIdDeleted());
      }
    });
  }
}
