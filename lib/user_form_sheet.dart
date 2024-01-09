import 'package:flutter/material.dart';
import 'package:site_reporter/main.dart';
import 'package:site_reporter/spreed_sheet_model.dart';

class UserFormSheet extends StatefulWidget {
  final ValueChanged<UserField> onSaveData;
  const UserFormSheet({super.key, required this.onSaveData});

  @override
  State<UserFormSheet> createState() => _UserFormSheetState();
}

class _UserFormSheetState extends State<UserFormSheet> {
  final name =TextEditingController();
   final date =TextEditingController();
    final location =TextEditingController();
     final description =TextEditingController();
  
  late TextEditingController nameController ;
    late TextEditingController locationController ;

  late TextEditingController dateController ;

  late TextEditingController descriptionController ;
  final formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   //initState();
    
  }

  void initValue(
      ){
        nameController = TextEditingController(text: '');
        dateController = TextEditingController(text: '');
        locationController = TextEditingController(text: '');
        descriptionController =TextEditingController(text: '');
      }
  @override
  Widget build(BuildContext context) {

    return  Form(
      key:formKey ,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          buildDate(),
          const SizedBox(height: 8,),
          buildLocation(),
          const SizedBox(height: 8,),
          buildName(),
          const SizedBox(height: 8,),
          buildDescription(),
          const SizedBox(height: 16,),
          buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDate()=> TextFormField(
    controller: date,
    validator:(val)=> val !=null && val.isEmpty ? 'Enter Date':null,
    decoration: const InputDecoration(
      labelText: 'date',
      border: OutlineInputBorder(),
      
    ),
  );

    Widget buildLocation()=> TextFormField(
          controller: location,
              validator:(val)=> val !=null && val.isEmpty ? 'Enter Location':null,
    decoration: const InputDecoration(
      labelText: 'location',
      border: OutlineInputBorder(),
    ),
  );

   Widget buildName()=> TextFormField(
        controller: name,
            validator:(val)=> val !=null && val.isEmpty ? 'Enter Name':null,
    decoration: const InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
  );

   Widget buildDescription()=> TextFormField(
        controller: description,
             validator:(val)=> val !=null && val.isEmpty ? 'Enter Description':null,
    decoration: const InputDecoration(
      labelText: 'description',
      border: OutlineInputBorder(),
    ),
  );

  Widget buildButton()=>ButtonWidget(text: 'Save', 
  onClicked: ()async{
final form = formKey.currentState!;
final isValid = form.validate();
    if(isValid){
      final user = UserField(
        date: date.text,
         location: location.text,
          name: name.text,
           description: description.text);
               widget.onSaveData(user);
               date.clear();
                location.clear();
                 name.clear();
                  description.clear();
    }
       
      });
}