import 'package:crud_bloc_api/constants/snack_bar.dart';
import 'package:crud_bloc_api/model/spice_model.dart';
import 'package:crud_bloc_api/service/service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LogicState {}

abstract class LogicEvent {}

class LogicInitializeState extends LogicState {}

class LogicErrorState extends LogicState {
  final String error;
  LogicErrorState({required this.error});
}

class LogicLoadingState extends LogicState {}

class ReadSpiceState extends LogicState {
  final UserSpice spiceModel;
  ReadSpiceState({required this.spiceModel});
}

class ReadSpiceEvent extends LogicEvent {}

class AddSpiceEvent extends LogicEvent {
  final String nama_rempah;
  final String nama_latin;
  final String image;
  final String deskripsi;
  final BuildContext context;
  AddSpiceEvent(
      {required this.nama_rempah,
      required this.nama_latin,
      required this.image,
      required this.deskripsi,
      required this.context});
}

class AddSpiceLoading extends LogicState {
  bool isLoading;
  AddSpiceLoading({required this.isLoading});
}

class UpdateSpiceEvent extends LogicEvent {
  final String rempah_id;
  final String nama_rempah;
  final String nama_latin;
  final String image;
  final String deskripsi;
  final BuildContext context;
  UpdateSpiceEvent(this.context,
      {required this.rempah_id,
      required this.nama_rempah,
      required this.nama_latin,
      required this.deskripsi,
      required this.image});
}

class UpdateSpiceLoading extends LogicState {
  bool isLoading;
  UpdateSpiceLoading({required this.isLoading});
}

class DeleteSpiceEvent extends LogicEvent {
  final String id;
  DeleteSpiceEvent({required this.id});
}

class DeleteSpiceLoading extends LogicState {
  bool isLoading;
  DeleteSpiceLoading({required this.isLoading});
}

class LogicalService extends Bloc<LogicEvent, LogicState> {
  final RestAPIService _service;
  LogicalService(this._service) : super(LogicInitializeState()) {
    on<AddSpiceEvent>((event, emit) async {
      await _service
          .addSpiceService(
              event.nama_rempah, event.nama_latin, event.image, event.deskripsi)
          .then((value) {
        emit(AddSpiceLoading(isLoading: false));
        snackBar(event.context, "Spice has been Added");
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace) {
        emit(AddSpiceLoading(isLoading: false));
      });
    });

    on<ReadSpiceEvent>((event, emit) async {
      emit(LogicLoadingState());
      await _service.readSpiceService().then((value) {
        emit(ReadSpiceState(spiceModel: value));
      }).onError((error, stackTrace) {
        emit(LogicErrorState(error: error.toString()));
      });
    });

    on<UpdateSpiceEvent>((event, emit) async {
      emit(UpdateSpiceLoading(isLoading: true));
      await _service
          .updateSpiceService(event.rempah_id, event.nama_rempah,
              event.nama_latin, event.image, event.deskripsi)
          .then((value) {
        emit(UpdateSpiceLoading(isLoading: false));
        snackBar(event.context, "Spice has been Update");

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(event.context);
        });
      }).onError((error, stackTrace) {
        emit(UpdateSpiceLoading(isLoading: false));
      });
    });

    on<DeleteSpiceEvent>((event, emit) async {
      emit(DeleteSpiceLoading(isLoading: true));
      await _service.deleteSpiceService(event.id).then((value) {
        emit(DeleteSpiceLoading(isLoading: false));
      }).onError((error, stackTrace) {
        emit(DeleteSpiceLoading(isLoading: false));
      });
    });
  }
}
