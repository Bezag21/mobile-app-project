import 'package:equatable/equatable.dart';

class FullName extends Equatable {
  String? fullName;
  FullName({required this.fullName}) {
    if (this.fullName!.length < 3 || !RegExp(r'^[a-zA-Z .]+$').hasMatch(this.fullName!) ) {
      throw Exception('Enter correct name');
    }
  }

  @override
  String toString() {
    return fullName!;
  }

  @override
  List<Object> get props => [fullName!];
}
'The FullName class has one required string property: fullName. 
The constructor takes this property as a named parameter and requires it to be provided when creating an instance of the class.'
