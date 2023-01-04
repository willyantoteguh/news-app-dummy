class AppConstants {
  const AppConstants();

  static Api appApi = const Api();
  static ApiKey apiKey = const ApiKey();
  static ErrorKey errorKey = const ErrorKey();
  static ErrorMessage errorMessage = const ErrorMessage();
}

class Api {
  const Api();

  String get baseUrlProd => 'https://newsapi.org/v2/';

  String get baseUrlDev => 'https://newsapi.org/v2/';

  String get homeAll => 'top-headlines?';

  String get homeByCategory => 'everything?';
}

class ApiKey {
  const ApiKey();

  String get myApiKey => 'apiKey=f997e4d819c040ac9e1264c55bf372b7';
}

class ErrorKey {
  const ErrorKey();

  String get message => "message";
}

class ErrorMessage {
  const ErrorMessage();

  String get apiKeyDisabled => "username must not empty";

  String get apiKeyExhausted => "password must not empty";

  String get apiKeyInvalid => "confirm password must not empty";

  String get apiKeyMissing => "password and confirm password must same";

  String get parameterInvalid => "username and password must not empty";

  String get parametersMissing => 'failed get onboarding status';

  String get rateLimited => 'failed get onboarding status';

  String get sourcesTooMany => "full name must not empty";

  String get sourceDoesNotExist => "email must not empty";

  String get unexpectedError => "address must not empty";
}
