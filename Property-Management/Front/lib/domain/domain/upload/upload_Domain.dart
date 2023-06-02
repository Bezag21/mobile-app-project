import 'package:property/domain/upload/upload_photo.dart';
import 'package:property/domain/upload/upload_price.dart';

import '../../../domain/upload/upload_description.dart';
import '../../../domain/upload/upload_price.dart';
import '../../../domain/upload/upload_address.dart';

class UploadDomain {
  UploadPrice price;
  UploadDescription descrption;
  UploadAddress address;
  UploadImage image;
  UploadId? id;


 UploadDomain({
    required this.price,
    required this.descrption,
    required this.address,
    required this.image,
    this.id
  });

}

class UploadId {
  String id;
UploadId({required this.id});

  @override
  String toString() {
    return id.toString();
  }

}