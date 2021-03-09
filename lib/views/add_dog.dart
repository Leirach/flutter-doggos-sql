import 'package:flutter/material.dart';

//https://api.flutter.dev/flutter/material/TextField-class.html
class DogAdd extends StatefulWidget {
  const DogAdd({Key? key}) : super(key: key);

  @override
  _DogAddState createState() => _DogAddState();
}

class _DogAddState extends State<DogAdd> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Saved!'),
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
    );
  }
}
