import '../../../domain/inspection/inspection_Domain.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../infrastructure/inspection/inspection_model.dart';
import 'package:equatable/equatable.dart';

abstract class InspectionState extends Equatable {
  const InspectionState();

  @override
  List<Object> get props => [];
}

class inspectionLoading extends InspectionState {}

class inspectionAdding extends InspectionState {}

class inspectionAddSuccessful extends InspectionState {}

class inspectionAddFailed extends InspectionState {}

class inspectionsOperationSuccess extends InspectionState {
  final List<InspectionDomain> inspections;

  inspectionsOperationSuccess([this.inspections = const []]);

  @override
  List<Object> get props => [inspections];
}

class inspectionOperationFailure extends InspectionState {
  final Object error;
  inspectionOperationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
class SearchFailed extends InspectionState{}

class InspectionSearchSuccessful extends InspectionState {
  final InspectionName inspectionName;
  InspectionSearchSuccessful({required this.inspectionName});
}


class SearchingInsp extends InspectionState{}
class InspectionsSearchSuccess extends InspectionState {
  final InspectionModel inspectionModel;
  InspectionsSearchSuccess({required this.inspectionModel});
}
