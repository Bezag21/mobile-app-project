import 'package:equatable/equatable.dart';

class UploadAddress extends Equatable {

  String? uploadAddress;
  UploadAddress ({required this.uploadAddress});


  
  @override
  String toString() {
    return uploadAddress!;
  }
  @override
  List<Object> get props => [uploadAddress!];
}
