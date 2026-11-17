// This unit test demonstrates repository behavior using mock implementations.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rojeta_doctor/features/doctor/homelayout/data/models/doctor_dashboard_stats.dart';
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

  setUpAll(() {
    registerFallbackValue(HomelayoutModel.fake());
  });

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

  group('DoctorDashboardStats todayIncome linkage', () {
    test('when todayAppointments is 0 and totalEarnings is 405, todayIncome is 0', () {
      final json = {
        'todayAppointments': 0,
        'pendingRequests': 0,
        'completedAppointments': 1,
        'newRequests': 0,
        'rating': 5.0,
        'totalEarnings': '405',
      };
      final stats = DoctorDashboardStats.fromJson(json);
      expect(stats.todayAppointments, 0);
      expect(stats.totalEarnings, '405');
      expect(stats.todayIncome, '0');
    });

    test('when todayAppointments is 0 and totalEarnings is 765, todayIncome is 0', () {
      final json = {
        'todayAppointments': 0,
        'pendingRequests': 1,
        'completedAppointments': 1,
        'newRequests': 1,
        'rating': 5.0,
        'totalEarnings': '765',
      };
      final stats = DoctorDashboardStats.fromJson(json);
      expect(stats.todayAppointments, 0);
      expect(stats.totalEarnings, '765');
      expect(stats.todayIncome, '0');
    });

    test('when todayIncome is explicitly provided from today payments, todayIncome is parsed', () {
      final json = {
        'todayAppointments': 2,
        'pendingRequests': 1,
        'completedAppointments': 1,
        'newRequests': 0,
        'rating': 4.9,
        'totalEarnings': '1500',
        'todayIncome': '250',
      };
      final stats = DoctorDashboardStats.fromJson(json);
      expect(stats.todayAppointments, 2);
      expect(stats.totalEarnings, '1500');
      expect(stats.todayIncome, '250');
    });
  });
}
