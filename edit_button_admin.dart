

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth.dart';
import '../../../provider/users_table.dart';
import '../../registration/widgets/radiobuttons.dart';

class EditButtonAdmin extends StatefulWidget {
  const EditButtonAdmin({Key key}) : super(key: key);

  @override
  State<EditButtonAdmin> createState() => _EditButtonAdminState();
}

class _EditButtonAdminState extends State<EditButtonAdmin> {
  String genderSelected;
  String roleSelected;


  AuthProvider authproviderInstance = AuthProvider();
  List<Map<String,dynamic>> selectedRows;
  String selectedUid;

  String _birthDateInString;
  DateTime birthDate;
  bool isDateSelected= false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmedController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();



  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmedController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final UsersTable userTable = Provider.of<UsersTable>(context);

    return TextButton.icon(
      onPressed: () =>
      { selectedRows = userTable.selecteds,
        if(selectedRows.length == 1) {



        emailController.value = TextEditingValue(
            text: selectedRows[0]['email'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['username'].length)
            )
        ),

        firstNameController.value = TextEditingValue(
            text: selectedRows[0]['first name'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['username'].length)
            )
        ),

        lastNameController.value = TextEditingValue(
            text: selectedRows[0]['last name'],
            selection: TextSelection.fromPosition(
                TextPosition(offset: selectedRows[0]['username'].length)
            )
        ),

        genderSelected = selectedRows[0]['gender'],

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    Text("User bearbeiten",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight
                                                .bold
                                        )),
                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                        labelText: "Benutzername",
                                        hintText: "Max123",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20)
                                        )
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        labelText: "E-Mail",
                                        hintText: "abc@domain.com",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20)
                                        )
                                    ),
                                  ),),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                        labelText: "Vorname",
                                        hintText: "Max",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20)
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                        labelText: "Nachname",
                                        hintText: "Mustermann",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .circular(20)
                                        )
                                    ),
                                  ),
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [

                                    //SizedBox(width: 11,),

                                    Text(
                                      "Geburtsdatum:",
                                      style: TextStyle(
                                          fontSize: 18),
                                    ),

                                    //SizedBox(width: 90,),

                                    GestureDetector(
                                      child: new Icon(
                                        Icons.calendar_today,
                                        size: 30,),
                                      onTap: () async {
                                        final DateTime datePick = await showDatePicker(
                                          context: context,
                                          initialDate: new DateTime
                                              .now(),
                                          firstDate: new DateTime(
                                              1900),
                                          lastDate: new DateTime(
                                              2100),
                                          initialEntryMode: DatePickerEntryMode
                                              .input,
                                          errorFormatText: 'Enter valid date',
                                          errorInvalidText: 'Enter date in valid range',
                                          fieldLabelText: 'Birthdate',
                                          fieldHintText: 'TT/MM/YYYY',
                                        );
                                        if (datePick != null &&
                                            datePick != birthDate) {
                                          setState(() {
                                            birthDate = datePick;
                                            isDateSelected = true;

                                            // birthdate in string
                                            _birthDateInString =
                                            "${birthDate
                                                .day}/${birthDate
                                                .month}/${birthDate
                                                .year}";
                                            print('' +
                                                _birthDateInString);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[

                                    Text(
                                      "Geschlecht:",
                                      style: TextStyle(
                                          fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(width: 10,),


                                    RadioButtonGender(
                                        0, 'Männlich', genderSelected, (
                                        newValue) {
                                      print(newValue);
                                      setState(() =>
                                      genderSelected = newValue);
                                    }),
                                    RadioButtonGender(
                                        1, 'Weiblich', genderSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      genderSelected = newValue);
                                    }),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Rolle:",
                                      style: TextStyle(
                                          fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(width: 10,),


                                    RadioButtonRole(
                                        0, 'User', roleSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),
                                    RadioButtonRole(
                                        1, 'Wissenschaftler', roleSelected, (
                                        newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),
                                    RadioButtonRole(
                                        2, 'Admin', roleSelected, (newValue) {
                                      print(newValue);
                                      setState(() =>
                                      roleSelected = newValue);
                                    }),

                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(
                                      8.0),
                                  child: ElevatedButton(
                                    child: Text("Bearbeiten"),
                                    onPressed: () async {
                                      selectedRows = userTable.selecteds;

                                      if (_formKey.currentState.validate()) {
                                        //alle infos von den controllern holen und alles updaten.
                                        selectedUid = selectedRows[0]['uid'];

                                        await authproviderInstance.updateUser(selectedUid,
                                            _birthDateInString,genderSelected, roleSelected);

                                        _formKey.currentState.save();
                                        Navigator.of(context).pop();
                                        userTable.selecteds.clear();
                                        userTable.initializeData();
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            })
      } else {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error: Bitte wähle genau einen User aus."),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }),
        }
      },
      icon: Icon(
        IconData(0xf00d, fontFamily: 'MaterialIcons'),
        color: Colors.black,),
      label: Text("Bearbeiten",
          style: TextStyle(
              color: Colors.black
          )
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(Colors.grey),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(10)),
      ),
    );
    }
}
