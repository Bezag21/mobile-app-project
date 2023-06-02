
import 'dart:io';

import '../../../application/admin/bloc/admin_bloc.dart';
import '../../../application/signup_form/bloc/signup_bloc.dart';
import '../../../domain/admin_register_user/admin_register_user_domian.dart';
import '../../../domain/signup/confirm_password_validator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/signup/fullname_domain.dart';
import '../../../domain/signup/password_domain.dart';
import '../../../domain/signup/signup_user_domain.dart';
import '../../../domain/signup/signup_validator.dart';
import '../../../domain/signup/username_domain.dart';
import '../../../presentation/routes/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

import '../../core/widgets/brand_name.dart';
import './add_inspection.dart';
import './list_of_inspections.dart';
import '../../core/widgets/custom_button.dart';

class AdminAdd extends StatefulWidget {
  const AdminAdd({Key? key}) : super(key: key);

  @override
  State<AdminAdd> createState() => _SignupState();
}

class _SignupState extends State<AdminAdd> {
  late bool _passwordVisible;
  late bool _passwordConfirmVisible;

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  
  TextEditingController dateinput = TextEditingController();
  String _chosenValue = 'admin';
  @override
  void initState() {
    _passwordVisible = true;
    _passwordConfirmVisible = true;
    dateinput.text = "";
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    
    passwordConfirmController.dispose();
    super.dispose();
  }

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
     final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(const PopupMenuItem(
      value: 'Add Inspections',
      child: Text('Add Inspections'),  
    ));
      menuItems.add(const PopupMenuItem(
      value: 'List Inspections',
      child: Text('List Inspections'),  
    ));
   
    return Scaffold(
         appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
              onSelected: (i) { 
                if(i == 'Add Inspections') {
                 
                   Navigator.push(context,MaterialPageRoute(builder: (context) => AddInspection(context),),);
                }if(i == 'List Inspections') {
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>  const ListOfInspection(),),);
                }
              
              }
          ),
           
        ],
          ),

  
      body: SafeArea(
        
        child: Stack(children: [
        
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 60, 15, 5),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      "Upload Appartment Info",
                      style: newTheme.lightTextTheme.headline2,
                    ),
                    Text(
                      "Welcome",
                      style: newTheme.lightTextTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // BrandName(),
                    // Form(child: child)
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  TextFormField(
                                      key: Key("Description"),
                                      controller: fullNameController,
                                      decoration: const InputDecoration(
                                        labelText: "Enter Description",
                                      ),
                                      validator: (value) => SignupValidator()
                                          .fullNameValidater(value)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                 
                                  // const SizedBox(height: 25),
                                  TextFormField(
                                    key: Key("Address"),
                                    controller: usernameController,
                                    decoration: const InputDecoration(
                                      labelText: "Enter Address",
                                    ),
                                    validator: (value) => SignupValidator()
                                        .usernameValidater(value),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    key: Key("Price"),
                                   
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(_passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      // suffixIcon: Icon(Icons.scuba_diving),
                                      labelText: "Price",
                                    ),
                                    validator: (value) => SignupValidator()
                                        .passwordValidater(value),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                InkWell(
  onTap: () {
    _pickImage(ImageSource.gallery);
  },
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    height: 120,
    width: 120,
    child: _image == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate),
                const SizedBox(height: 5.0),
                Text('Upload Image'),
              ],
            ),
          )
        : Image.file(
            _image!,
            fit: BoxFit.cover,
          ),
  ),
),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            
                            BlocConsumer<AdminBloc, AdminState>(
                                listener: (context, state) {
                              if (state is AdminSuccessful) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(108, 60, 190, 237),
                                      content: Text('AdminAdd Successful')),
                                );
                               
                              } else if (state is AdminAdding) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              } else if (state is AdminFailed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content:
                                          Text('AdminAdd Failed Try again')),
                                );
                              }
                            }, builder: (context, state) {
                              return TextButton(
                                key: Key("button"),
                                  onPressed: () {
                                   
                                    if (_formKey.currentState!.validate()) {
                                     
                                      AddUserDomainRequest addUserDomainRequest = AddUserDomainRequest(username:usernameController.text, name: fullNameController.text, password: passwordController.text, roles: _chosenValue);
                                       BlocProvider.of<AdminBloc>(context).add(AdminRegisterUser(addUserDomainRequest));
                                   
                                    }
                                  },
                                  child: CustomButton(title: "Add"));
                            }),
                         
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
