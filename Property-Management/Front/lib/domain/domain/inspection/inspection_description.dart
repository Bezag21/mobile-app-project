import 'package:equatable/equatable.dart';

class InspectionDescription extends Equatable {
  String? inspectionDescription;
  InspectionDescription({required this.inspectionDescription}) {
    if (!RegExp(r'^[a-zA-Z . _ 0-9 ]+$').hasMatch(this.inspectionDescription!)) {
      throw Exception('Enter correct inspection description');
    } else if (this.inspectionDescription!.length < 3) {
      throw Exception('Description is too short!');
    }
  }

  @override
  String toString() {
    return inspectionDescription!;
  }

  @override
  List<Object> get props => [inspectionDescription!];
}
