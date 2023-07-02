part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeEvent {}

class AddEmployeeSubmittedEvent extends AddEmployeeEvent {
  final String strFullName;
  final String strEmployeeType;
  final String strFromDate;
  final String strToDate;

  AddEmployeeSubmittedEvent(
      this.strFullName, this.strEmployeeType, this.strFromDate, this.strToDate);
}

class EditEmployeeSubmittedEvent extends AddEmployeeEvent {
  final int id;
  final String strFullName;
  final String strEmployeeType;
  final String strFromDate;
  final String strToDate;

  EditEmployeeSubmittedEvent(this.id, this.strFullName, this.strEmployeeType,
      this.strFromDate, this.strToDate);
}
