// login exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class WrongAuthException implements Exception {}

// register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exception
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class InputRequiredException implements Exception {}

class UserIsNotExistException implements Exception {}
