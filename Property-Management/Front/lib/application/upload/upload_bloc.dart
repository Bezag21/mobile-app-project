import 'dart:async';

import '../../../application/upload/upload_event.dart';
import '../../../application/upload/upload_state.dart';
//import '../../../domain/upload/upload_Domain.dart';
import '../../../infrastructure/upload/upload_repository.dart';
//import '../../../presentation/core/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBLoc extends Bloc<UploadEvent, UploadState> {
  UploadRepo uploadRepo = UploadRepo();

  UploadBLoc() : super(uploadLoading()) {
    on<UploadCreateEvent>((event, emit) async {
      await _onuploadCreate(event, emit);
    });
    on<UploadUpdateEvent>((event, emit) async {
      await _onuploadUpdate(event, emit);
    });
    on<Searchupload>((event, emit) async {
      await _onuploadSearch(event, emit);
    });
    on<UploadDeleteEvent>((event, emit) async {
      await _onUploadDelete(event, emit);
    });
    on<inspIdle>((event, emit) async {
      emit(Idle());
    });

    on<uploadLoadAllEvent>((event, emit) async {
      await _onuploadLoadAll(event, emit);
    });
    
  }



//  load all insp
  Future<void> _onuploadLoadAll(event, emit) async {
    emit(uploadLoading());
    try {
      final uploads = await uploadRepo.getAllUploads();
      emit(uploadOperationSuccess(uploads));
    } catch (error) {
      emit(uploadOperationFailure(error: error));
    }
  }

//  done with create 
  Future<void> _onuploadCreate(event, emit) async {
    emit(uploadAdding());
    try {
      await uploadRepo.createUpload(event.uploadDomain);
      print("here");
      emit(uploadAddSuccessful());
    } catch (error) {
      emit(uploadAddFailed());
    }
  }

//  done  editing
  Future<void> _onuploadUpdate(event, emit) async {
    try {
      await uploadRepo.editupload(event.uploadDomain);
      emit(uploadOperationSuccess());
    } catch (error) {
      emit(uploadOperationFailure(error: error));
    }
  }
//  Future<void> _onInspectionDetailLoad(event, emit) async {
//     try {
//       final inspection = await inspectionRepo.getInspectionDetail(event.id);

//       emit(inspectionsOperationSuccess());
//     } catch (error) {
//       emit(inspectionOperationFailure(error: error));
//     }
//   }
//  done with delete
  Future<void> _onUploadDelete(event, emit) async {
    try {
      await uploadRepo.deleteUpload(event.id);
      emit(uploadOperationSuccess());
    } catch (error) {
      emit(uploadOperationFailure(error: error));
    }
  }

  Future<void> _onuploadSearch(event, emit) async {
    emit(SearchingInsp());
    
      emit(SearchFailed());
    
  }
}
