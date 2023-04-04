import 'package:flutter/material.dart';

class Author {
  final String name;
  Author({required this.name});
}

class DynamicTextFields extends StatefulWidget {
  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {
  final List<Author> _authors = [
    Author(name: 'Author 1'),
    Author(name: 'Author 2'),
    Author(name: 'Author 3'),
  ];
  final List<GlobalKey<FormState>> _formKeys = [];

  @override
  void initState() {
    super.initState();
    _formKeys.add(GlobalKey<FormState>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _authors.length,
              itemBuilder: (BuildContext context, int index) {
                return Form(
                  key: _formKeys[index],
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Author>(
                          value: _authors[index],
                          onChanged: (Author? newValue) {
                            setState(() {
                              _authors[index] = newValue!;
                            });
                          },
                          items: _authors.map((Author author) {
                            return DropdownMenuItem<Author>(
                              value: author,
                              child: Text(author.name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Author',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _authors.removeAt(index);
                            _formKeys.removeAt(index);
                          });
                        },
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _authors.add(Author(name: 'New Author'));
                            _formKeys.add(GlobalKey<FormState>());
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
