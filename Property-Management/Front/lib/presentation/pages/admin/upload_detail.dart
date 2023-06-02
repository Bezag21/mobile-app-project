import 'dart:core';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property/application/upload/upload_bloc.dart';
import 'package:property/application/upload/upload_event.dart';
import 'package:property/application/upload/upload_state.dart';
import 'package:property/domain/upload/upload_Domain.dart';
import 'package:property/domain/upload/upload_address.dart';
import 'dart:io';
import '../../../domain/upload/upload_description.dart';
import '../../../domain/upload/upload_photo.dart';
import '../../../domain/upload/upload_price.dart';
import '../../../domain/upload/upload_validater.dart';
import '../../../presentation/core/theme.dart';

import '../../../presentation/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UploadDetail extends StatefulWidget {
  final int? uploadId;

  UploadDetail( {this.uploadId});

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _uploadPrice = TextEditingController();
  TextEditingController _address= TextEditingController();
  TextEditingController _desc = TextEditingController();
  File? _image;
  @override
  void initState() {
    // TODO: implement initState
    _uploadPrice.text = "100000";
    _address.text = "There";
    _desc.text = "Do this";
    super.initState();
  }

  @override
  void dispose() {
   
    _uploadPrice.dispose();
    _desc.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadBLoc>(
      create: (context)=> UploadBLoc(),
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
                        "Listing",
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
                                        controller: _uploadPrice,
                                        decoration: InputDecoration(
                                            labelText: "Price",
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
                                           UploadValidator()
                                                .uploadPriceValidator(value)),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                        controller: _address,
                                        
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
                                            UploadValidator()
                                                .uploadAddressValidator(
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
                                            UploadValidator()
                                                .uploadDescriptionValidator(
                                                    value)),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                             BlocConsumer<UploadBLoc, UploadState>(
                                      listener: (context, state) async {
                                    if (state is uploadAddFailed) {

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Error')),
                                      );
                                    } 
                                    if (state is uploadOperationSuccess) {
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
                                          UploadDomain uploadDomain =
                                             UploadDomain(
                                                  price: UploadPrice(
                                                      uploadPrice:
                                                          _uploadPrice.text),
                                                  descrption:
                                                      UploadDescription(
                                                          uploadDescription:
                                                              _desc.text),
                                                  address: UploadAddress(
                                                      uploadAddress:
                                                          _address.text),
                                                  image:UploadImage(uploadImage:_image));

                                          BlocProvider.of<UploadBLoc>(context)
                                              .add(UploadUpdateEvent(uploadDomain));
                                          _desc.clear();
                                          _address.clear();
                                          _uploadPrice.clear();
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
