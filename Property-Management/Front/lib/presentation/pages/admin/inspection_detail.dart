import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property/application/inspection/inspection_bloc.dart';
import 'package:property/application/inspection/inspection_event.dart';
import 'package:property/application/inspection/inspection_state.dart';
import 'package:property/domain/inspection/inspection_Domain.dart';
import 'package:property/domain/inspection/inspection_address.dart';

import '../../../domain/inspection/inspection_description.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../domain/inspection/inspection_validation.dart';
import '../../../presentation/core/theme.dart';

import '../../../presentation/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class InspectionDetail extends StatefulWidget {
  final int? inspectionId;

  InspectionDetail( {this.inspectionId});

  @override
  State<InspectionDetail> createState() => _InspectionDetailState();
}

class _InspectionDetailState extends State<InspectionDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inspectionName = TextEditingController();
  TextEditingController _address= TextEditingController();
  TextEditingController _desc = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _inspectionName.text = "12/12/2002";
    _address.text = "Heloo";
    _desc.text = "Do this";
    super.initState();
  }

  @override
  void dispose() {
   
    _inspectionName.dispose();
    _desc.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InspectionBLoc>(
      create: (context)=> InspectionBLoc(),
    child: Scaffold(
     
      body: Stack(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Edit",
                        style: newTheme.lightTextTheme.headline2,
                      ),
                      Text(
                        "Inspection",
                        style: newTheme.lightTextTheme.headline2,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                     
                      const SizedBox(
                        height: 50,
                      ),
                      
                      Form(
                        key: _formKey,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    TextFormField(
                                        controller: _inspectionName,
                                        decoration: InputDecoration(
                                            labelText: "Inspection Date",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Colors.lightBlue,
                                                width: 2.0,
                                              ),
                                            )),
                                        validator: (value) =>
                                           inspectionValidator()
                                                .inspectionNameValidator(value)),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                        controller: _address,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Address",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.lightBlue,
                                                width: 2.0,
                                              ),
                                            )),
                                        validator: (value) =>
                                            inspectionValidator()
                                                .inspectionAddressValidator(
                                                    value)),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                        maxLines: 3,
                                        controller: _desc,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            labelText: "Description",
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.lightBlue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.lightBlue,
                                                width: 2.0,
                                              ),
                                            )),
                                        validator: (value) =>
                                            inspectionValidator()
                                                .inspectionDescriptionValidator(
                                                    value)),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                             BlocConsumer<InspectionBLoc, InspectionState>(
                                      listener: (context, state) async {
                                    if (state is inspectionAddFailed) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Error')),
                                      );
                                    } 
                                    if (state is inspectionsOperationSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Color.fromARGB(108, 43, 138, 205),
                                            content: Text('Edit Successful')),
                                      );
                                    } 
                                   
                                  }, builder: (context, state) {
                                    return TextButton(
                                        onPressed: () {
                                        if(_formKey.currentState!.validate()){
                                          InspectionDomain inspectionDomain =
                                              InspectionDomain(
                                                  name: InspectionName(
                                                      inspectionName:
                                                          _inspectionName.text),
                                                  descrption:
                                                      InspectionDescription(
                                                          inspectionDescription:
                                                              _desc.text),
                                                  address: InspectionAddress(
                                                      inspectionAddress:
                                                          _address.text));

                                          BlocProvider.of<InspectionBLoc>(context)
                                              .add(InspectionUpdateEvent(inspectionDomain));
                                          _desc.clear();
                                          _address.clear();
                                          _inspectionName.clear();
                                        }},
                                        child: CustomButton(title: "Add"));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
