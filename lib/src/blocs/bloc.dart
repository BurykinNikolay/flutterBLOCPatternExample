import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();

  final _surname = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _channel = BehaviorSubject<String>();
  final _confirm = BehaviorSubject<bool>();

  final _screenSaver = BehaviorSubject<bool>();
  final _submitPhoto = BehaviorSubject<bool>();
  final _submitValid = BehaviorSubject<bool>();
  final _cameraOn = BehaviorSubject<bool>();

  IOWebSocketChannel socketChannel;

  // retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get surname => _name.stream.transform(validateSurname);
  Stream<String> get phone => _phone.stream.transform(validatePhone);
  Stream<String> get channel => _channel.stream.transform(validateChannel);
  Stream<bool> get confirm => _confirm.stream.transform(validateConfirm);
  Stream<bool> get submitPhoto =>
      _submitPhoto.stream.transform(validateSubmitPhoto);

  Stream<bool> get screenSaver =>
      _screenSaver.stream.transform(validateScreenSaver);
  Stream<bool> get submitValid => _submitValid.stream.transform(validateSubmit);
  Stream<bool> get cameraOn => _cameraOn.stream.transform(validateCameraOn);

  //Stream<bool> get submitValid => Observable.combineLatest5(
  //    name, surname, email, phone, confirm, (n, su, e, p, c) => true);

  // add data to stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeSurname => _surname.sink.add;
  Function(String) get changePhone => _phone.sink.add;
  Function(bool) get changeConfirm => _confirm.sink.add;
  Function(bool) get changeScreenSaver => _screenSaver.sink.add;
  Function(bool) get changeValid => _submitValid.sink.add;

  Bloc() {
    //Bloc constructor
    socketChannel = IOWebSocketChannel.connect('ws://192.168.137.1:8000');
    socketChannel.stream.listen(_onData, onError: _onError);
  }
  void _onData(Object data) {
    _channel.sink.add(data);
  }

  void _onError(Object error) {
    print(error);
  }

  submit() {
    var data = [
      {'email': _email.value},
      {'name': _name.value},
      {'suname': _surname.value},
      {'phone': _phone.value}
    ];
    List<int> bytes = utf8.encode(jsonEncode(data));

    socketChannel.sink.add(bytes);
    _cameraOn.sink.add(true);
  }

  check(String n, String su, String e, String p, String c) {
    return true;
  }

  clear() {
    print("clear");
    _email.sink.add("");
    _name.sink.add("");
    _surname.sink.add("");

    _phone.sink.add("");
    _confirm.sink.add(false);

    socketChannel.sink.add("_newGuest");
    _submitPhoto.sink.add(false);
    _submitValid.sink.add(false);
    _cameraOn.sink.add(false);
  }

  validAll(bool valid) {
    _submitValid.sink.add(valid);
  }

  startPhoto() {
    _submitPhoto.sink.add(true);
    print("start photo");
    socketChannel.sink.add("_startPhoto");
    _cameraOn.sink.add(false);
  }

  takePhoto() {
    socketChannel.sink.add("_takePhoto");
    _cameraOn.sink.add(true);
    _submitPhoto.sink.add(false);
  }

  screenSaverChange(bool value) {
    if (value == true) {
      socketChannel.sink.add("_startScreenSaver");
    } else {
      socketChannel.sink.add("_startScreenSaver");
    }
  }

  startScreenSaver() {
    print("start screen saver");
    socketChannel.sink.add("_startScreenSaver");
    _screenSaver.sink.add(true);
  }

  stopScreenSaver() {
    print("stop screen saver");
    socketChannel.sink.add("_startScreenSaver");
    _screenSaver.sink.add(false);
  }

  dispose() {
    _email.close();
    _name.close();
    _surname.close();
    _phone.close();
    _channel.close();
    _confirm.close();
    _screenSaver.close();
    _submitPhoto.close();
    _submitValid.close();
  }
}
