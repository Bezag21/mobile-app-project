import 'dart:async';

import '../../../application/inspection/inspection_event.dart';
import '../../../application/inspection/inspection_state.dart';
//import '../../../domain/inspection/inspection_Domain.dart';
import '../../../infrastructure/inspection/inspection_repository.dart';
//import '../../../presentation/core/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionBLoc extends Bloc<InspectionEvent, InspectionState> {
  InspectionRepo inspectionRepo = InspectionRepo();

  InspectionBLoc() : super(inspectionLoading()) {
    on<InspectionCreateEvent>((event, emit) async {
      await _oninspectionCreate(event, emit);
    });
    on<InspectionUpdateEvent>((event, emit) async {
      await _oninspectionUpdate(event, emit);
    });
    on<Searchinspection>((event, emit) async {
      await _oninspectionSearch(event, emit);
    });
    on<inspectionDeleteEvent>((event, emit) async {
      await _oninspectionDelete(event, emit);
    });
   

    on<inspectionLoadAllEvent>((event, emit) async {
      await _oninspectionLoadAll(event, emit);
    });
    
  }



//  load all insp
  Future<void> _oninspectionLoadAll(event, emit) async {
    emit(inspectionLoading());
    try {
      final inspections = await inspectionRepo.getAllinspection();
      emit(inspectionsOperationSuccess(inspections));
    } catch (error) {
      emit(inspectionOperationFailure(error: error));
    }
  }

//  done with create inspection
  Future<void> _oninspectionCreate(event, emit) async {
    emit(inspectionAdding());
    try {
      await inspectionRepo.createInspection(event.inspectionDomain);
      print("here");
      emit(inspectionAddSuccessful());
    } catch (error) {
      emit(inspectionAddFailed());
    }
  }

//  done inspection editint
  Future<void> _oninspectionUpdate(event, emit) async {
    try {
      await inspectionRepo.editinspection(event.inspectionDomain);
      emit(inspectionsOperationSuccess());
    } catch (error) {
      emit(inspectionOperationFailure(error: error));
    }
  }
 Future<void> _onInspectionDetailLoad(event, emit) async {
    try {
      final inspection = await inspectionRepo.getInspectionDetail(event.id);

      emit(inspectionsOperationSuccess());
    } catch (error) {
      emit(inspectionOperationFailure(error: error));
    }
  }
//  done with inspection delete
  Future<void> _oninspectionDelete(event, emit) async {
    try {
      await inspectionRepo.deleteInspection(event.id);
      emit(inspectionsOperationSuccess());
    } catch (error) {
      emit(inspectionOperationFailure(error: error));
    }
  }

  Future<void> _oninspectionSearch(event, emit) async {
    emit(SearchingInsp());
    
      emit(SearchFailed());
    
  }
}
