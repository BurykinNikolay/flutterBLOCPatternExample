import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../blocs/provider.dart';
import 'disc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
        decoration: BoxDecoration(color: Color(0xFFF4F5F5)),
        child: Container(
            margin: const EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(color: Color(0xFFF4F5F5)),
            child: Column(children: <Widget>[
              logoWidget(),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                    newGuest(bloc),
                    nameField(bloc),
                    surnameField(bloc),
                    phoneField(bloc),
                    emailField(bloc),
                    confirmBox(bloc),
                    submitButton(bloc),
                  ])),
                  Expanded(
                      child: Column(children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: startPhoto(bloc)),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: takePhoto(bloc)),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: screenSaver(bloc)),
                    //screensaver
                  ])),
                ],
              ),
            ])));
  }

  Widget logoWidget() {
    var assetsImage = new AssetImage('assets/audi_logo.png');
    var image = new Image(image: assetsImage, width: 460.0, height: 160.0);
    return new Container(child: image);
  }

  Widget newGuest(bloc) {
    return ButtonTheme(
        minWidth: 180.0,
        height: 40.0,
        child: RaisedButton(
          child: Text('Новый гость'),
          color: Color(0xFFFFFFFF),
          textColor: Color(0xFF757575),
          onPressed: bloc.clear,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)),
        ));
  }

  Widget nameField(bloc) {
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
              child: TextField(
            controller: TextEditingController(text: snapshot.data),
            onChanged: bloc.changeName,
            decoration: InputDecoration(
              labelText: 'Имя*',
            ),
          ));
        } else {
          return TextField(
            onChanged: bloc.changeName,
            decoration: InputDecoration(
              labelText: 'Имя*',
            ),
          );
        }
      },
    );
  }

  Widget surnameField(bloc) {
    return StreamBuilder(
      stream: bloc.surname,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
              child: TextField(
            controller: TextEditingController(text: snapshot.data),
            onChanged: bloc.changeSurname,
            decoration: InputDecoration(
              labelText: 'Фамилия*',
            ),
          ));
        } else {
          return TextField(
            onChanged: bloc.changeSurname,
            decoration: InputDecoration(
              labelText: 'Фамилия*',
            ),
          );
        }
      },
    );
  }

  Widget emailField(bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return TextField(
            controller: TextEditingController(text: snapshot.data),
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Электронная почта*',
            ),
          );
        } else {
          return TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Электронная почта*',
            ),
          );
        }
      },
    );
  }

  Widget phoneField(bloc) {
    return StreamBuilder(
      stream: bloc.phone,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return TextField(
            controller: TextEditingController(text: snapshot.data),
            onChanged: bloc.changePhone,
            decoration: InputDecoration(
              labelText: 'Телефон*',
            ),
            obscureText: false,
          );
        } else {
          return TextField(
            onChanged: bloc.changePhone,
            decoration: InputDecoration(
              labelText: 'Телефон*',
            ),
            obscureText: false,
          );
        }
      },
    );
  }

  Widget confirmBox(bloc) {
    return StreamBuilder(
        stream: bloc.confirm,
        builder: (context, snapshot) {
          bool value;
          if (snapshot.hasData) {
            value = snapshot.data;
          } else
            value = false;
          return Row(children: <Widget>[
            Checkbox(
                value: value,
                onChanged: (bool value) {
                  bloc.changeConfirm(value);
                  bloc.validAll(value);
                }),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DicsScreen()),
                  );
                },
                child: Text('Даю согласие на обработку персональных данных',
                    textAlign: TextAlign.left),
              ),
            ),
          ]);
        });
  }

  Widget submitButton(bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        print("return button");
        print(snapshot.data);
        if (!snapshot.hasData) {
          return ButtonTheme(
              minWidth: 180.0,
              height: 40.0,
              child: RaisedButton(
                child: Text('Зарегистрировать'),
                color: Color(0xFFFFFFFF),
                textColor: Color(0xFF757575),
                onPressed: null,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
              ));
        } else
          return ButtonTheme(
              minWidth: 180.0,
              height: 40.0,
              child: RaisedButton(
                child: Text('Зарегистрировать'),
                color: Color(0xFFFFFFFF),
                textColor: Color(0xFF757575),
                onPressed: snapshot.data ? bloc.submit : null,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
              ));
      },
    );
  }

  Widget startPhoto(bloc) {
    return StreamBuilder(
      stream: bloc.cameraOn,
      builder: (context, snapshot) {
        return ButtonTheme(
            minWidth: 180.0,
            height: 40.0,
            child: RaisedButton(
              child: Text('Включить камеру'),
              color: Color(0xFFFFFFFF),
              textColor: Color(0xFF757575),
              onPressed: snapshot.data == true ? bloc.startPhoto : null,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
            ));
      },
    );
  }

  Widget takePhoto(bloc) {
    return StreamBuilder(
      stream: bloc.submitPhoto,
      builder: (context, snapshot) {
        return ButtonTheme(
            minWidth: 180.0,
            height: 40.0,
            child: RaisedButton(
              child: Text('Сделать снимок'),
              color: Color(0xFFFFFFFF),
              textColor: Color(0xFF757575),
              onPressed: snapshot.data == true ? bloc.takePhoto : null,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
            ));
      },
    );
  }

  Widget screenSaver(bloc) {
    return StreamBuilder(
      stream: bloc.screenSaver,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return ButtonTheme(
                minWidth: 180.0,
                height: 40.0,
                child: RaisedButton(
                  child: Text('Заставка'),
                  color: Color(0xFFFFFFFF),
                  textColor: Color(0xFF757575),
                  onPressed: bloc.stopScreenSaver,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ));
          }
        } else {}
        return ButtonTheme(
            minWidth: 180.0,
            height: 40.0,
            child: RaisedButton(
              child: Text('Заставка'),
              color: Color(0xFFFFFFFF),
              textColor: Color(0xFF757575),
              onPressed: bloc.startScreenSaver,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
            ));
      },
    );
  }
}
