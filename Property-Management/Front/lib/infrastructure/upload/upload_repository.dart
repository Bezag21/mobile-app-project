import 'dart:io';

import 'package:property/domain/upload/upload_address.dart';
import 'package:property/domain/upload/upload_photo.dart';

import '../../../domain/upload/upload_Domain.dart';
import '../../../domain/upload/upload_description.dart';
import '../../../domain/upload/upload_price.dart';
import '../../../domain/upload/upload_photo.dart';
import '../../../infrastructure/upload/upload_data_provider.dart';
import '../../../infrastructure/upload/upload_model.dart';

class UploadRepo {
  UploadProvider uploadProvider = UploadProvider();
  UploadRepo();

  Future<void> createUpload(UploadDomain uploadDomain) async {
    UploadModel uploadModel = UploadModel(
        price: uploadDomain.price.toString(),
        descrption: uploadDomain.descrption.toString(),
        address: uploadDomain.address.toString(),
        image:uploadDomain.image as File,
         id: uploadDomain.id.toString());
    uploadProvider.createUpload(uploadModel);
  }

//   edit
  Future<void> editupload(UploadDomain uploadDomain) async {
    UploadModel uploadModel = UploadModel(
        price: uploadDomain.price.toString(),
        descrption: uploadDomain.descrption.toString(),
        address: uploadDomain.address.toString(),
        image:uploadDomain.image as File,
        id: uploadDomain.id.toString());

    uploadProvider.editUpload(uploadModel);
  }

  Future<List<UploadDomain>> getAllUploads() async {
    List<UploadModel> list_of_upload = await uploadProvider.getAllUploads();
    print(UploadDescription(uploadDescription: list_of_upload[0].descrption));
    try {
      final mapped = list_of_upload.map((e) => UploadDomain(
              price: UploadPrice(uploadPrice: e.price),
              descrption: UploadDescription(uploadDescription: e.descrption),
              address: UploadAddress(uploadAddress: e.address),
              image:UploadImage(uploadImage: e.image),
              id: UploadId(id: e.id!)))
          .toList();
      return mapped;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<UploadDomain>> getUploadDetail(String id) async {
   
    UploadModel up= await uploadProvider.getUpload(id.toString());

    final UploadDomain upload =UploadDomain(
        descrption:
            UploadDescription(uploadDescription: up.descrption.toString()),
       price: UploadPrice(uploadPrice: up.price.toString()),
        address: UploadAddress(
           uploadAddress: up.address.toString()),
            image:UploadImage(uploadImage:up.image as File),
        id: UploadId(id: up.id.toString()));

    return [upload];
  }

  Future<void> deleteUpload(UploadId id) async {
    await uploadProvider.deleteUpload(id.toString());
  }

  Future<UploadModel> searchupload(String uploadDescription) async {
    print(uploadDescription);
    print("endepata");
    final response = await uploadProvider.searchUpload(uploadDescription);
    return response;
  }
}

 
  // Future<List<InspectionDomain>> getInspectionDetail(String id) async {
    
  //       InspectionModel insp = await InspectionProvider.getInspection(id.toString());

  //   final InspectionDomain inspection= InspectionDomain(
  //       descrption:
  //           InspectionDescription(inspectionDescription: insp.descrption.toString()),
  //       name: InspectionName(inspectionName: insp.name.toString()),
  //       address: InspectionAddress(
  //           inspectionAddress: insp.address.toString()),
  //     id : InspectionId(id: insp.id.toString()));

  //   return[inspection];
  // }
