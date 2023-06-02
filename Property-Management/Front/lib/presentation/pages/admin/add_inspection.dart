import '../../../application/inspection/inspection_bloc.dart';
import '../../../application/inspection/inspection_event.dart';
import '../../../application/inspection/inspection_state.dart';
import '../../../domain/inspection/inspection_Domain.dart';
import '../../../domain/inspection/inspection_description.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../domain/inspection/inspection_address.dart';
import '../../../domain/inspection/inspection_validation.dart';
import '../../../presentation/core/theme.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../presentation/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AddInspection extends StatefulWidget {
  const AddInspection(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<AddInspection> createState() => _AddInspectionState();
}

class _AddInspectionState extends State<AddInspection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController inspectionName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController desc = TextEditingController();

  // @override
  // void dispose() {
  //   
  //   
  //   inspectionName.dispose();
  //   desc.dispose();
  //   address.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<InspectionBLoc>(
        create: (context) => InspectionBLoc(),
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
                            "Add",
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
                                            controller: inspectionName,
                                            decoration: const InputDecoration(
                                              labelText: "Inspection Date",
                                            ),
                                            validator: (value) =>
                                                inspectionValidator()
                                                    .inspectionNameValidator(value)),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextFormField(
                                            controller: address,
                                             keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              labelText: "Address",
                                            ),
                                            validator: (value) =>
                                               inspectionValidator()
                                                    .inspectionAddressValidator(value)),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextFormField(
                                            controller: desc,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              labelText: "Description",
                                            ),
                                            validator: (value) =>
                                                inspectionValidator()
                                                    .inspectionDescriptionValidator( value)),
                                        const SizedBox(
                                          height: 25,

                                        ),
                                      ],
                                    ),

                                  ),
                                  BlocConsumer<InspectionBLoc, InspectionState>(
                                      listener: (context, state) async {
                                    if (state is inspectionAddSuccessful) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Color.fromARGB(108, 25, 172, 221),
                                            content: Text(' Successful')),
                                      );
                                    } else if (state is inspectionAdding) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    } else if (state is inspectionAddFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content:
                                                Text('Failed to add Inspection')),
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
                                                          inspectionName.text),
                                                  descrption:
                                                      InspectionDescription(
                                                          inspectionDescription:
                                                              desc.text),
                                                  address: InspectionAddress(
                                                      inspectionAddress:
                                                          address.text));

                                          BlocProvider.of<InspectionBLoc>(context)
                                              .add(InspectionCreateEvent( inspectionDomain));
                                          desc.clear();
                                          address.clear();
                                          inspectionName.clear();
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

     
   