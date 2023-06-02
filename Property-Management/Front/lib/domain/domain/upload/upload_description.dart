import 'package:equatable/equatable.dart';

class UploadDescription extends Equatable {
  String?  uploadDescription;
   UploadDescription({required this.uploadDescription}) {
    if (!RegExp(r'^[a-zA-Z . _ 0-9 ]+$').hasMatch(this.uploadDescription!)) {
      throw Exception('Enter correct  description');
    } else if (this.uploadDescription!.length < 3) {
      throw Exception('Description is too short!');
    }
  }

  @override
  String toString() {
    return uploadDescription!;
  }

  @override
  List<Object> get props => [uploadDescription!];
}
