import 'package:equatable/equatable.dart';
import 'dart:io';
class UploadImage extends Equatable {
  File? uploadImage;
  UploadImage ({required this.uploadImage});

  

  @override
  List<Object> get props => [uploadImage !];
}
