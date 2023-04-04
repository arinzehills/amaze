import 'package:amaze/components/loading.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthorsProfileEdit extends StatefulWidget {
  const AuthorsProfileEdit({super.key});

  @override
  State<AuthorsProfileEdit> createState() => _AuthorsProfileEditState();
}

class _AuthorsProfileEditState extends State<AuthorsProfileEdit> {
  String caption = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[myPurple, myBlue])),
          )),
      body: FutureBuilder<User>(
          future: AuthService().getuserFromStorage(),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Loading();
            }
            User user = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10).copyWith(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: myDarkBlue,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/svg/usericon.svg',
                                color: myDarkBlue,
                              ),
                            ),
                            Text(
                              'About Author- ${user.first_name} ${user.first_name}',
                              style: TextStyle(
                                  color: myDarkBlue, fontSize: 22, height: 2),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? 'Enter a caption' : null,
                                keyboardType: TextInputType.multiline,
                                initialValue: user.about_author ?? '',
                                maxLines: 23,
                                decoration: InputDecoration(
                                  filled: true, //<-- SEE HERE
                                  fillColor: Color.fromARGB(43, 108, 193, 254),
                                  hintText:
                                      'Enter Information about yourself...',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() => caption = val);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    MyButton(
                      placeHolder: 'Save',
                      loadingState: loading,
                      pressed: () async {
                        setState(() => {loading = true});
                        var data = {'about_author': caption};
                        var res =
                            await AuthService().updateUser(dataToupdate: data);
                        print('res');
                        print(res);
                        if (res['success']) {
                          setState(() => {});
                          setState(() => {loading = false});
                        } else {
                          setState(() => {loading = false});
                        }
                      },
                      height: 40,
                      widthRatio: 0.4,
                      color: myDarkBlue,
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
