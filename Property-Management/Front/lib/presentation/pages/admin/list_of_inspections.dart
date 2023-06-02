import 'dart:core';

import '../../../domain/inspection/inspection_Domain.dart';

import '../../../domain/inspection/inspection_address.dart';
import '../../../domain/inspection/inspection_description.dart';

import '../../../domain/inspection/inspection_name.dart';
import '../../../presentation/pages/admin/add_inspection.dart';


import '../../../application/inspection/inspection_bloc.dart';
import '../../../application/inspection/inspection_event.dart';
import '../../../application/inspection/inspection_state.dart';
import '../../../domain/inspection/inspection_Domain.dart';
import '../../../presentation/core/theme.dart';
import '../../../presentation/core/loading.dart';

import '../../../presentation/pages/Error/error.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'inspection_detail.dart';

class ListOfInspection extends StatelessWidget {
  const ListOfInspection({Key? key}) : super(key: key);
  final data = const [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InspectionBLoc>(context).add(const inspectionLoadAllEvent());
      
    return  Scaffold(
      
          body: BlocBuilder<InspectionBLoc, InspectionState>(
              builder: ((context, state) {
               
            if (state is inspectionLoading) {
              return Loading();
            } else if (state is inspectionsOperationSuccess) {
            
              return Stack(
                children: [
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                       SizedBox(height: 70.0),
                        Text(
                          "List of Inspections",
                          style: newTheme.lightTextTheme.headline2,
                        ),
                       SizedBox(height: 10.0),
                        Expanded(
                          child: ListView.builder(
                              
                              itemCount: state.inspections.length,
                              itemBuilder: (BuildContext context, index) {
                                return GestureDetector(
                                  onTap: (){  
                                
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InspectionDetail(),
                                    ),
                                  );},
                                  // onTap: () {  InspectionId inspectionId= InspectionId(
                                  //               id:  state.inspections[index].id .toString(),);
                                  //               BlocProvider.of<InspectionBLoc>(context).add(InspectionDetailLoadEvent(inspectionId)
                                  //               );}  ,
                                  
                                  child: Container(
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
                                                InspectionId inspectionId= InspectionId(
                                                id:  state.inspections[index].id .toString(),);
                                                        
                                                  
                                                BlocProvider.of<InspectionBLoc>(context)
                                                        .add(inspectionDeleteEvent(inspectionId ));},
                                              icon: const Icon(  Icons.delete, ),
                                              alignment :const Alignment(50.0,3.0), 
                                                       ),

                                                      Text(
                                                      state.inspections[index].name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    
                                                  Text(
                                                    state.inspections[index].address.toString()
                                                       ,
                                                    style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
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
