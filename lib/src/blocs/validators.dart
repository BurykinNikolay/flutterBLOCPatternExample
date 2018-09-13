import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.length >= 1) {
      sink.add(email);
    } else {
      sink.addError("");
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 1) {
      sink.add(name);
    } else {
      sink.addError("");
    }
  });

    final validateSurname =
      StreamTransformer<String, String>.fromHandlers(handleData: (suname, sink) {
    if (suname.length >= 1) {
      sink.add(suname);
    } else {
      sink.addError("");
    }
  });

  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length >= 1) {
      sink.add(phone);
    } else {
      sink.addError("");
    }
  });

  final validateConfirm =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (confirm, sink) {
    print(confirm);
    sink.add(confirm);
  });

  final validateScreenSaver = StreamTransformer<bool, bool>.fromHandlers(
      handleData: (screenSaver, sink) {
    print(screenSaver);
    sink.add(screenSaver);
  });

  final validateSubmitPhoto = StreamTransformer<bool, bool>.fromHandlers(
      handleData: (submitPhoto, sink) {
    sink.add(submitPhoto);
  });

  final validateCameraOn = StreamTransformer<bool, bool>.fromHandlers(
      handleData: (cameraOn, sink) {
    sink.add(cameraOn);
  });


  final validateChannel =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    sink.add(data);
  });
  final validateSubmit =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {

        print(data);
    sink.add(data);
  });
}
