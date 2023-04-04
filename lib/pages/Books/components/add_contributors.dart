import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Books/upload_widgets.dart';
import 'package:flutter/material.dart';

class AddContributors extends StatefulWidget {
  const AddContributors({Key? key, required this.onAdd}) : super(key: key);
  final void Function(List) onAdd;
  @override
  State<AddContributors> createState() => _AddContributorsState();
}

class _AddContributorsState extends State<AddContributors> {
  String question = '';
  List options = [
    {'firstname': '', 'lastname': '', 'type': 'Author'}
  ];
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  List _authorsTypes = [
    'Author',
    'Translator',
    'Illustrator',
    'Narrator',
    'Introductor',
    'Photographer',
    'Preface',
    'Forward'
  ];

  @override
  Widget build(BuildContext context) {
    var handleAddTopics = () => {
          setState(
            () => options
                .add({'firstname': '', 'lastname': '', 'type': 'Author'}),
          ),
        };
    return Container(
      color: Color(0xffD8EFFF),
      width: size(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  listTextFieldWidget(handleAddTopics),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                  options.length < 6
                      ? MyButton(
                          placeHolder: 'Ok',
                          loadingState: loading,
                          height: 40,
                          textColor: Colors.white,
                          color: myDarkBlue,
                          pressed: () {
                            widget.onAdd(options);
                          },
                          widthRatio: 0.57,
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTextFieldWidget(handleAddTopics) {
    var handleRemoveTopics = (index) => {
          //set links to new list
          setState(() => options.removeAt(index))
        };

    print(options);
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListView.builder(
            itemCount: options.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 81,
                      child: DropdownButton(
                        iconSize: 0.0,
                        alignment: AlignmentDirectional.centerStart,
                        value: options[index]['type'],
                        onChanged: (newValue) {
                          setState(() {
                            options[index]['type'] = newValue!;
                          });
                        },
                        items: _authorsTypes.map((authortype) {
                          return DropdownMenuItem(
                            value: authortype,
                            child: Text(
                              authortype == 'Author'
                                  ? '${authortype} >>'
                                  : '${authortype} ',
                              style: TextStyle(color: myDarkBlue, fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    addTextField(context, width: 115.0, hintText: 'First name',
                        onChanged: (val) {
                      setState(() => {options[index]['firstname'] = val});
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    addTextField(context, width: 115.0, hintText: 'Last name',
                        onChanged: (val) {
                      setState(() => {options[index]['lastname'] = val});
                    }),
                    // (options.length - 1) == index
                    IconButton(
                        onPressed: () => handleRemoveTopics(index),
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.blue,
                        )),
                    GestureDetector(
                        onTap: handleAddTopics,
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                        ))
                  ],
                ),
              );
            }));
  }
}
