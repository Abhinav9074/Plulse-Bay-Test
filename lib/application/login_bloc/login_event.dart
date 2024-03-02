abstract class LoginEvent{}

class LoggedInEvent extends LoginEvent{
  final String password;
  final String email;

  LoggedInEvent({required this.password, required this.email});
}