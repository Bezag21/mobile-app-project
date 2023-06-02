import '../../domain/upload/upload_Domain.dart';

//import '../../../domain/upload/upload_Domain.dart';
//import '../../../domain/upload/upload_price.dart';
import 'package:equatable/equatable.dart';


abstract class UploadEvent extends Equatable {
  const UploadEvent();
  @override
  List<Object> get props => [];
}

class UploadCreateEvent extends UploadEvent {
  final UploadDomain uploadDomain;
  const UploadCreateEvent(this.uploadDomain);

  @override
  List<Object> get props => [uploadDomain];
}

class uploadLoadAllEvent extends UploadEvent {
  const uploadLoadAllEvent();

  @override
  List<Object> get props => [];
}



class UploadUpdateEvent extends UploadEvent {
  final UploadDomain uploadDomain;
  const UploadUpdateEvent(this.uploadDomain);

  @override
  List<Object> get props => [UploadDomain];
}

class UploadDeleteEvent extends UploadEvent {
  final UploadId id;
  const UploadDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class uploadDetailLoadEvent extends UploadEvent {
  final UploadId id;
  const uploadDetailLoadEvent(this.id);

  @override
  List<Object> get props => [id];
}
class Searchupload extends UploadEvent {
  final String address;
  const Searchupload(this.address);

  @override
  List<Object> get props => [address];
}

class inspIdle extends UploadEvent{}
