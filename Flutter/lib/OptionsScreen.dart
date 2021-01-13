import 'package:flutter/material.dart';
import 'Options.dart';
import 'app_localizations.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Language Selector'),
        leading: FlatButton(
          textColor: Colors.black,
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 100.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: _selectedOption == index - 1
                  ? Border.all(color: Colors.black26)
                  : null,
            ),
            child: ListTile(
              leading: options[index - 1].icon,
              title: Text(
                options[index - 1].title,
                style: TextStyle(
                  color: _selectedOption == index - 1
                      ? Colors.black
                      : Colors.grey[600],
                ),
              ),
              selected: _selectedOption == index - 1,
              onTap: () {
                setState(() {
                  _selectedOption = index - 1;
                  if(_selectedOption == 0){ // English
                    // TODO: Change this locale to english
                    // AppLocalizations.of(context).load(Locale('en', ''));
                    // Locale('en', '').load();
                    // print(AppLocalizations.of(context));
                  } else if (_selectedOption == 1){ // Spanish
                    // TODO: Change this locale to spanish
                    // Locale('es', '').load();
                    // _AppLocalizationsDelegate.load(Locale('es', ''));
                  }
                  // print(_selectedOption);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
