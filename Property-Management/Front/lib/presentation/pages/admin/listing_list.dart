import 'dart:core';
import 'dart:io';

import '../../../domain/upload/upload_Domain.dart';

import '../../../domain/upload/upload_address.dart';
import '../../../domain/upload/upload_description.dart';

import '../../../domain/upload/upload_price.dart';
import '../../../domain/upload/upload_photo.dart';
import '../../../presentation/pages/admin/adminscreen.dart';


import '../../../application/upload/upload_bloc.dart';
import '../../../application/upload/upload_event.dart';
import '../../../application/upload/upload_state.dart';
import '../../../domain/upload/upload_Domain.dart';
import '../../../presentation/core/theme.dart';
import '../../../presentation/core/loading.dart';

import '../../../presentation/pages/Error/error.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'upload_detail.dart';

class ListOfUpload extends StatelessWidget {
  const ListOfUpload({Key? key}) : super(key: key);
  final data = const [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UploadBLoc>(context).add(const uploadLoadAllEvent());
      
    return  Scaffold(
      
          body: BlocBuilder<UploadBLoc,UploadState>(
              builder: ((context, state) {
               
            if (state is uploadLoading) {
              return Loading();
            } else if (state is uploadOperationSuccess) {
            
              return Stack(
                children: [
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                       SizedBox(height: 70.0),
                        Text(
                          "Listings",
                          style: newTheme.lightTextTheme.headline2,
                        ),
                       SizedBox(height: 10.0),
                        Expanded(
                          child: ListView.builder(
                              
                              itemCount: state.uploads.length,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: (){  
                                
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UploadDetail(),
                                    ),
                                  );},
                                  // onTap: () {  InspectionId inspectionId= InspectionId(
                                  //               id:  state.inspections[index].id .toString(),);
                                  //               BlocProvider.of<InspectionBLoc>(context).add(InspectionDetailLoadEvent(inspectionId)
                                  //               );}  ,
                                  
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                            width: double.maxFinite,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 9.0, vertical: 20.0),
                                            color:
                                                Color.fromARGB(255, 123, 189, 219),
                                            child: Column(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisSize:MainAxisSize.min,
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  
                                                  children: [
                                           IconButton(
                                                        
                                               onPressed: (){
                                               UploadId uploadId= UploadId(
                                                id:  state.uploads[index].id .toString(),);
                                                        
                                                  
                                                BlocProvider.of<UploadBLoc>(context)
                                                        .add(UploadDeleteEvent(uploadId ));},
                                              icon: const Icon(  Icons.delete, ),
                                              alignment :const Alignment(50.0,3.0), 
                                                       ),

                                                      Text(
                                                      state.uploads[index].price
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                   
                                                  Text(
                                                    state.uploads[index].address.toString()
                                                       ,
                                                    style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(state.uploads[index].image as String),
                                                  //  Text(
                                                  //   state.inspections[index].descrption.toString()
                                                  //      ,
                                                  //   style: const TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontWeight:
                                                  //             FontWeight.bold))

                                                
                                                  ],
                                                      )
                                                 ],
                                            ))

                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return NoResultFoundScreen();
            }
          })),


          
        );
  }
}
