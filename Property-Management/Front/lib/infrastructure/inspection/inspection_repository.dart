import '../../../domain/inspection/inspection_Domain.dart';
import '../../../domain/inspection/inspection_description.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../domain/inspection/inspection_address.dart';
import '../../../infrastructure/inspection/inspection_data_provider.dart';
import '../../../infrastructure/inspection/inspection_model.dart';

class InspectionRepo {
  InspectionProvider inspectionProvider = InspectionProvider();
  InspectionRepo();

  Future<void> createInspection(InspectionDomain inspectionDomain) async {
    InspectionModel inspectionModel = InspectionModel(
        name: inspectionDomain.name.toString(),
        descrption: inspectionDomain.descrption.toString(),
        address: inspectionDomain.address.toString());

    inspectionProvider.createInspection(inspectionModel);
  }

//  done inspection edit
  Future<void> editinspection(InspectionDomain inspectionDomain) async {
    InspectionModel inspectionModel = InspectionModel(
        name: inspectionDomain.name.toString(),
        descrption: inspectionDomain.descrption.toString(),
        address: inspectionDomain.address.toString(),
        id: inspectionDomain.id.toString());

    inspectionProvider.editInspection(inspectionModel);
  }

  Future<List<InspectionDomain>> getAllinspection() async {
    List<InspectionModel> list_of_insp = await inspectionProvider.getAllInspection();
    print(InspectionName(inspectionName: list_of_insp[0].name));
    try {
      final mapped = list_of_insp.map((e) => InspectionDomain(
              name: InspectionName(inspectionName: e.name),
              descrption: InspectionDescription(inspectionDescription: e.descrption),
              address: InspectionAddress(inspectionAddress: e.address),
              id: InspectionId(id: e.id!)))
          .toList();
      return mapped;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<InspectionDomain>> getInspectionDetail(String id) async {
   
    InspectionModel insp = await inspectionProvider.getInspection(id.toString());

    final InspectionDomain inspection = InspectionDomain(
        descrption:
            InspectionDescription(inspectionDescription: insp.descrption.toString()),
        name: InspectionName(inspectionName: insp.name.toString()),
        address: InspectionAddress(
           inspectionAddress: insp.address.toString()),
        id: InspectionId(id: insp.id.toString()));

    return [inspection];
  }

  Future<void> deleteInspection(InspectionId id) async {
    await inspectionProvider.deleteInspection(id.toString());
  }

  Future<InspectionModel> searchinspection(String inspectionName) async {
    print(inspectionName);
    print("endepata");
    final response = await inspectionProvider.searchInspection(inspectionName);
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
