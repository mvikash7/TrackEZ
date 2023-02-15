
class Validator {

  String? validateUserName(String? value){
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp =  RegExp(pattern);
    if(value!.isEmpty){
      return '*Required Field';
    } else if(value.length < 3 ){
      return 'Name should be greater than 3 characters';
    } else if(!regExp.hasMatch(value)) {
      return 'Name cannot contain Numbers or Special Characters';
    }
    return null;

  }

  String? validateEmail(String? value){
    String pattern  = r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty){
      return '*Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Please Enter a Valid Email';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value){
    String pattern = r'(?=.*?[#?!@$%^&*-])';
    RegExp regExp =  RegExp(pattern);
    if(value!.isEmpty){
      return '*Required Field';
    } else if(value.length <= 7){
      return 'Password should be more than 8 characters';
    }  else if(!regExp.hasMatch(value)) {
      return 'Passwords must have at least one special character';
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String? value){
    return null;
    /*print('At the before checking ${cp} and ${p} ');
    if(value!.isEmpty){
      return '*Required Field';
    } else if(cp != p){
      print('inside  check ${cp} and ${p} ');
      return 'Password did not match';
    }  else {
      return null;
    }*/
  }

  String? validateLoginPassword(String? value){

    if(value!.isEmpty){
      return '*Required Field';
    } else {
      return null;
    }
  }
}