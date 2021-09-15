class ResponseHandler {
  Map<String, dynamic> possibleErrors = {
    "SomethingWentWrong": "SomethingWentWrong",
    "SomethingWentWrong": "حدث خطأ ما"
  };
  Map<String, dynamic> initiateErrors(language) {
    switch (language) {
      case 'Ar':
        return possibleErrors = {
          "SomethingWentWrong": "حدث خطأ ما",
          "InternetError": "برجاء التأكد من خدمة الإنترنت لديك"
        };
      default:
        return possibleErrors = {
          "SomethingWentWrong": "Something Went Wrong",
          "InternetError": "Kindly Check your internet connection"
        };
    }
  }

  Map<String, dynamic> successPrinter() {
    return {'Err_Flag': false, 'Err_Desc': 'Done!'};
  }

  Map<String, dynamic> errorPrinter(String language, String errorMessage) {
    initiateErrors(language);
    return {'Err_Flag': true, 'Err_Desc': possibleErrors[errorMessage]};
  }

  Map<String, dynamic> timeOutPrinter() {
    return {'Err_Flag': true, 'Err_Desc': 'Server Timeout!'};
  }
}
