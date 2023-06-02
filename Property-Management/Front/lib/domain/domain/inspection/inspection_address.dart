import 'package:equatable/equatable.dart';

class InspectionAddress extends Equatable {

  String? inspectionAddress;
  InspectionAddress ({required this.inspectionAddress});


  
  @override
  String toString() {
    return inspectionAddress!;
  }
  @override
  List<Object> get props => [inspectionAddress!];
}
