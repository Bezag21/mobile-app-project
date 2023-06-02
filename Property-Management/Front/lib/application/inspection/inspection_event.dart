import '../../domain/inspection/inspection_Domain.dart';

//import '../../../domain/inspection/inspection_Domain.dart';
//import '../../../domain/inspection/inspection_name.dart';
import 'package:equatable/equatable.dart';

//import '../../domain/inspection/inspection_Domain.dart';

abstract class InspectionEvent extends Equatable {
  const InspectionEvent();
  @override
  List<Object> get props => [];
}

class InspectionCreateEvent extends InspectionEvent {
  final InspectionDomain inspectionDomain;
  const InspectionCreateEvent(this.inspectionDomain);

  @override
  List<Object> get props => [inspectionDomain];
}

class inspectionLoadAllEvent extends InspectionEvent {
  const inspectionLoadAllEvent();

  @override
  List<Object> get props => [];
}



class InspectionUpdateEvent extends InspectionEvent {
  final InspectionDomain inspectionDomain;
  const InspectionUpdateEvent(this.inspectionDomain);

  @override
  List<Object> get props => [InspectionDomain];
}

class inspectionDeleteEvent extends InspectionEvent {
  final InspectionId id;
  const inspectionDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InspectionDetailLoadEvent extends InspectionEvent {
  final InspectionId id;
  const InspectionDetailLoadEvent(this.id);

  @override
  List<Object> get props => [id];
}
class Searchinspection extends InspectionEvent {
  final String address;
  const Searchinspection(this.address);

  @override
  List<Object> get props => [address];
}


