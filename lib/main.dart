import 'package:flutter/material.dart';
import 'package:site_reporter/controller.dart';
import 'package:site_reporter/spreed_sheet_model.dart';
import 'package:site_reporter/user_form_sheet.dart';

void main()  async{
 WidgetsFlutterBinding.ensureInitialized();
 await UserSheetApi.init(); 
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: UserFormSheet(
        onSaveData: (user)async{
              await UserSheetApi.insert([user.toJson()]);
        }
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
    super.key, required this.text, required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          minimumSize: Size.fromHeight(50),
          shape: StadiumBorder(),
        ),
        child:  FittedBox(child:  Text(text)),
      onPressed: onClicked,
      ),
    );
  }
}
  
