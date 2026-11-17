// This unit test demonstrates repository behavior using mock implementations.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/features/auth/data/models/authmodel.dart';
import 'package:rojeta_doctor/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rojeta_doctor/features/auth/domain/datasources/auth_remote_data_source.dart';
import 'package:rojeta_doctor/features/auth/domain/datasources/auth_local_data_source.dart';

class MockRemoteDS extends Mock implements AuthRemoteDataSource {}
class MockLocalDS extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteDS mockRemote;
  late MockLocalDS mockLocal;

  setUpAll(() {
    registerFallbackValue(AuthModel.fake());
  });

  setUp(() {
    mockRemote = MockRemoteDS();
    mockLocal = MockLocalDS();
    repository = AuthRepositoryImpl(remote: mockRemote, local: mockLocal);
  });

  test('should return cached data if exists', () async {
    final fakeModel = AuthModel.fake();
    when(() => mockLocal.load()).thenAnswer((_) async => fakeModel);

    final result = await repository.getAuth();

    expect(result.id, fakeModel.id);
    verifyNever(() => mockRemote.fetch());
  });

  test('should fetch from remote when cache is empty', () async {
    final fakeModel = AuthModel.fake();
    when(() => mockLocal.load()).thenAnswer((_) async => null);
    when(() => mockRemote.fetch()).thenAnswer((_) async => fakeModel);
    when(() => mockLocal.save(any())).thenAnswer((_) async {});

    final result = await repository.getAuth();

    expect(result.id, fakeModel.id);
    verify(() => mockRemote.fetch()).called(1);
    verify(() => mockLocal.save(any())).called(1);
  });
}
