import 'package:property/domain/upload/upload_description.dart';

import '../../../domain/upload/upload_Domain.dart';
//import '../../../domain/upload/upload_price.dart';
import '../../../infrastructure/upload/upload_model.dart';
import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class uploadLoading extends UploadState {}

class  uploadAdding extends UploadState {}

class  uploadAddSuccessful extends UploadState {}

class  uploadAddFailed extends UploadState {}

class  uploadOperationSuccess extends UploadState {
  final List< UploadDomain>  uploads;

   uploadOperationSuccess([this. uploads = const []]);

  @override
  List<Object> get props => [ uploads];
}

class  uploadOperationFailure extends UploadState {
  final Object error;
   uploadOperationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
class SearchFailed extends UploadState{}

class  UploadSearchSuccessful extends UploadState {
  final UploadDescription uploadDescription;
  UploadSearchSuccessful({required this.uploadDescription});
}

class Idle extends UploadState{}
class SearchingInsp extends UploadState{}
class InspectionsSearchSuccess extends UploadState {
  final UploadModel inspectionModel;
  InspectionsSearchSuccess({required this.inspectionModel});
}
