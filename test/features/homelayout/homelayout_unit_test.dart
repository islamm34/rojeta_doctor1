// This unit test demonstrates repository behavior using mock implementations.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/homelayoutmodel.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/repositories/homelayout_repository_impl.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/domain/datasources/homelayout_remote_data_source.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/domain/datasources/homelayout_local_data_source.dart';

class MockRemoteDS extends Mock implements HomelayoutRemoteDataSource {}
class MockLocalDS extends Mock implements HomelayoutLocalDataSource {}

void main() {
  late HomelayoutRepositoryImpl repository;
  late MockRemoteDS mockRemote;
  late MockLocalDS mockLocal;

  setUp(() {
    mockRemote = MockRemoteDS();
    mockLocal = MockLocalDS();
    repository = HomelayoutRepositoryImpl(remote: mockRemote, local: mockLocal);
  });

  test('should return cached data if exists', () async {
    final fakeModel = HomelayoutModel.fake();
    when(() => mockLocal.load()).thenAnswer((_) async => fakeModel);

    final result = await repository.getHomelayout();

    expect(result.id, fakeModel.id);
    verifyNever(() => mockRemote.fetch());
  });

  test('should fetch from remote when cache is empty', () async {
    final fakeModel = HomelayoutModel.fake();
    when(() => mockLocal.load()).thenAnswer((_) async => null);
    when(() => mockRemote.fetch()).thenAnswer((_) async => fakeModel);
    when(() => mockLocal.save(any())).thenAnswer((_) async {});

    final result = await repository.getHomelayout();

    expect(result.id, fakeModel.id);
    verify(() => mockRemote.fetch()).called(1);
    verify(() => mockLocal.save(any())).called(1);
  });
}
