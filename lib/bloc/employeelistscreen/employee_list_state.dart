part of 'employee_list_bloc.dart';

@immutable
abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class OnEmployeeListLoaded extends EmployeeListState {
  final List<Employee?> employeeCurrentListModel;
  final List<Employee?> employeePreviousListModel;

  OnEmployeeListLoaded(this.employeeCurrentListModel,this.employeePreviousListModel);
}

class OnEmployeeByIdDeleted extends EmployeeListState {}
class EmployeeListLoading extends EmployeeListState {}
class ErrorEmployeeListLoading extends EmployeeListState {}
