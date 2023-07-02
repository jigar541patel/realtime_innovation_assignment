part of 'employee_list_bloc.dart';

@immutable
abstract class EmployeeListEvent {}

class GetEmployeeList extends EmployeeListEvent {
  List<Employee?> employeeListModel;
  List<Employee?> employeePreviousListModel;

  GetEmployeeList(this.employeeListModel,this.employeePreviousListModel);
}

class DeleteEmployeeByID extends EmployeeListEvent {
  int id;

  DeleteEmployeeByID(this.id);
}
