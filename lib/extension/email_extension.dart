extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
//    1 upperCase,1 lowerCase, 1 numeric and min 6 length
  bool isValidPassword() {
    //return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(this);
    return RegExp(r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\S+$).{6,}$').hasMatch(this);
  }

  bool isValidUserName() {
    return RegExp(r'^(?=[a-zA-Z0-9._]{4,20}$)(?!.*[_.]{2})[^_.].*[^_.]$').hasMatch(this);
  }

  bool isString(){
    return RegExp(r'^[a-zA-Z]*$').hasMatch(this);
  }

  bool ismobile(String txt) {
    return txt.length>6 && txt.length<16;
  }
}
