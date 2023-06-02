import 'package:equatable/equatable.dart';

class InspectionName extends Equatable {
  String? inspectionName;
  InspectionName({required this.inspectionName}) {
    if ( !RegExp(r'^([0]\d|[1][0-2])\/([0-2]\d|[3][0-1])\/([2][01]|[1][6-9])\d{2}(\s([0-1]\d|[2][0-3])(\:[0-5]\d){1,2})?$').hasMatch(this.inspectionName!) ) {
      throw Exception('Enter correct date and time. i.e. dd/mm/yyyy TT:TT');
    }
  }

  @override
  String toString() {
    return inspectionName!;
  }

  @override
  List<Object> get props => [inspectionName!];
}
