// fake model for Auth
class AuthModel {
  final String id;
  final String title;

  AuthModel({required this.id, required this.title});

  factory AuthModel.fake() {
    return AuthModel(id: '1', title: 'Fake Auth');
  }
}
