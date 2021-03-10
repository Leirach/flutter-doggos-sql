import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sql/models/database.dart';
import 'package:sql/models/db_manager.dart';
import 'package:sql/models/dog.dart';

//https://api.flutter.dev/flutter/material/TextField-class.html
class DogAdd extends StatefulWidget {
  const DogAdd({Key? key}) : super(key: key);

  @override
  _DogAddState createState() => _DogAddState();
}

class _DogAddState extends State<DogAdd> {
  final _formKey = GlobalKey<FormState>();
  bool _dataChanged = false;

  String _dogName = "";
  int _dogAge = 0;

  @override
  Widget build(BuildContext context) {
    // catch will pop and return _dataChanged to signal if an item was added to db
    return WillPopScope(
      onWillPop: () async {
        // pops and sends _dataChanged
        Navigator.pop(context, this._dataChanged);
        return this._dataChanged;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add doggo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // name
                TextFormField(
                  decoration: InputDecoration(hintText: "name"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter some name';

                    return null;
                  },
                  onSaved: (value) => this._dogName = value!,
                ),
                SizedBox(height: 8),
                //age
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "age"),
                  validator: (value) {
                    if (value == null || num.tryParse(value) == null)
                      return 'Please enter valid number';

                    return null;
                  },
                  onSaved: (value) => this._dogAge = int.parse(value!),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // force unwrap database await
                        AppDatabase db = (await DBManager.instance.database)!;
                        this._formKey.currentState?.save();
                        log(this._dogName);
                        log(this._dogAge.toString());
                        Text msg;
                        try {
                          await db.dogDao.insertDog(
                              Dog(name: this._dogName, age: this._dogAge));
                          msg = Text('Saved!');
                          this._dataChanged = true;
                        } catch (err) {
                          log(err.toString());
                          msg = Text('Error!',
                              style: TextStyle(color: Colors.red));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: msg,
                        ));
                      }
                    },
                    child: Text('save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
