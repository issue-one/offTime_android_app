import 'package:test/test.dart';
import 'package:offTime/off_time.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Create a user on the server', () {
    UserInput hanna= UserInput(password: "user@example.com",email:"stringstring");

    UserDataProvider dataProvider= new UserDataProvider(httpClient: http.Client(),);
    expect(dataProvider.createUser(hanna), equals(true as Future<bool>));
  });

  test('String.trim() removes surrounding whitespace', () {
    var string = '  foo ';
    expect(string.trim(), equals('foo'));
  });
}