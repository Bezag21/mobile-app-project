import 'package:equatable/equatable.dart';

class UploadPrice extends Equatable {
  String? uploadPrice ;
  UploadPrice ({required this.uploadPrice }) {
    if ( !RegExp( r'^\d+(\.\d+)?$').hasMatch(this.uploadPrice !) ) {
      throw Exception('Enter correct date and time. i.e. dd/mm/yyyy TT:TT');
    }
  }

  @override
  String toString() {
    return uploadPrice!;
  }

  @override
  List<Object> get props => [uploadPrice !];
}
