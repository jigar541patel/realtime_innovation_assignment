import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:realtim_innovation_assigment/model/employee_model.dart';
import 'package:realtim_innovation_assigment/utils/colors_utils.dart';
import 'package:realtim_innovation_assigment/utils/common_utils.dart';

import '../../provider/db_provider.dart';

part 'add_employee_event.dart';

part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  AddEmployeeBloc() : super(AddEmployeeInitial()) {
    on<AddEmployeeSubmittedEvent>((event, emit) async {
      emit.call(AddingDataInProgressState());
      Employee employeeRequest = Employee(
        strFullName: event.strFullName.toLowerCase(),
        strEmployeeType: event.strEmployeeType,
        strFromDate: event.strFromDate,
        strToDate: event.strToDate,
      );
      DBProvider.db
          .checkEmployeeExist(event.strFullName.toLowerCase())
          .then((value) {
        if (value == 0) {
          DBProvider.db.insertEmployee(employeeRequest).then((value) {
            if (value > 0) {
              CommonUtils().showToast(
                  "Employee data has been added successfully",
                  textColor: whiteColor,
                  backgroundColor: greenDarkColor);
            } else {
              CommonUtils().showToast("Something went wrong");
            }
          });
        } else {
          CommonUtils().showToast("Employee data already exist",
              textColor: whiteColor, backgroundColor: redColor);
        }
      });
    });

    on<EditEmployeeSubmittedEvent>((event, emit) async {
      emit.call(AddingDataInProgressState());
      Employee employeeRequest = Employee(
        id: event.id,
        strFullName: event.strFullName.toLowerCase(),
        strEmployeeType: event.strEmployeeType,
        strFromDate: event.strFromDate,
        strToDate: event.strToDate,
      );

      DBProvider.db.updateEmployee(employeeRequest).then((value) {
        if (value > 0) {
          CommonUtils().showToast("Employee data has been edited successfully",
              textColor: whiteColor, backgroundColor: greenDarkColor);
        } else {
          CommonUtils().showToast("Something went wrong");
        }
      });
    });
  }
}
