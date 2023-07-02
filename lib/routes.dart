import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtim_innovation_assigment/bloc/addemployee/add_employee_bloc.dart';
import 'package:realtim_innovation_assigment/bloc/employeelistscreen/employee_list_bloc.dart';
import 'package:realtim_innovation_assigment/ui/screens/addemployee/view/add_employee_screen.dart';
import 'package:realtim_innovation_assigment/ui/screens/home/view/employee_list_screen.dart';

import 'utils/route_names.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeEmployeeList:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => EmployeeListBloc(),
                  child: const EmployeeListScreen(),
                ));
      case routeAddEmployee:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<AddEmployeeBloc>(
                      create: (BuildContext context) => AddEmployeeBloc(),
                    ),
                    BlocProvider<EmployeeListBloc>(
                      create: (BuildContext context) => EmployeeListBloc(),
                    ),
                  ],
                  child: const AddEmployeeScreen(),
                ),
            settings: settings);
    }
    return null;
  }
}
