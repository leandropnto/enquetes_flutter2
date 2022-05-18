import 'package:enquetes/presentation/presenters/presenters.dart';
import 'package:enquetes/presentation/protocols/protocols.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late Validation validation;
  late StreamLoginPresenter sut;
  late String email;

  When mockValidationCall(String? field) => when(
        () => validation.validate(
          field: field ?? any(named: 'field'),
          value: any(named: 'value'),
        ),
      );

  void mockValidation({String? field, required String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);
    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error with validation fails', () {
    mockValidation(field: 'email', value: 'error');

    expectLater(sut.emailErrorStream, emits("error"));
    sut.validateEmail(email);
  });
}
