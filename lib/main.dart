import 'package:crud_bloc_api/logic/logic.dart';
import 'package:crud_bloc_api/service/service.dart';
import 'package:crud_bloc_api/view/add_spice_view.dart';
import 'package:crud_bloc_api/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  RestAPIService service = RestAPIService();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LogicalService>(
            create: (context) => LogicalService(service))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      )));
}
