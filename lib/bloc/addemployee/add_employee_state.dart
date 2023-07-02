part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddingDataInProgressState extends AddEmployeeState {}

class AddingDataValidCompletedState extends AddEmployeeState {}

class AddingDataInValidCompletedState extends AddEmployeeState {}
