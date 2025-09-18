import '../../../../core_module.dart';
import '../dtos/auth_user_dto.dart';
import '../repositories/auth_repositories.dart';

class AuthUseCases implements IAuthUseCases {
  final IRepository _offlineRepository;
  final IOnlineAuthRepository _onlineRepository;

  AuthUseCases({
    required IRepository offlineRepository,
    required IOnlineAuthRepository onlineRepository,
  }) : _offlineRepository = offlineRepository,
       _onlineRepository = onlineRepository;

  @override
  Future<String?> createAccount(String email, String password) async {
    var entity = await _onlineRepository.createAccount(email, password);
    return Future.value(entity as String);
  }
  
  @override
  Future<String?> signInWithEmail(String email, String password) async {
    AuthUserDTO? authUserDTO = await _onlineRepository.signInWithEmail(email, password);
    String jwtToken = authUserDTO?.auth.token ?? "";
    await _saveUserAndCredentials(
      authUserDTO?.user,
      AuthCredentials(
        token: jwtToken,
        provider: authUserDTO?.user.provider ?? '',
        role: authUserDTO?.user.role ?? '',
      ),
    );
    return Future.value(jwtToken);
  }

  @override
  Future<String?> signInWithGoogle() async {
    final String? jwtToken = await _onlineRepository.signInWithGoogle();
    if(jwtToken == null) return null;
    UserEntity? currentUser = _onlineRepository.getCurrentUser();
    await _saveUserAndCredentials(
      currentUser,
      AuthCredentials(
        token: jwtToken,
        provider: currentUser?.provider ?? '',
        role: currentUser?.role ?? '',
      ),
    );
    return jwtToken;
  }

  Future<void> _saveUserAndCredentials(
    UserEntity? currentUser,
    AuthCredentials auth,
  ) async {
    await saveCredentials(auth);
    if (currentUser != null) saveLocalUser(currentUser);
  }

  @override
  Future<String?> getCredentials() async {
    IsarCredentialsDTO? entity = await _offlineRepository
        .get<IsarCredentialsDTO>();
    if (entity != null) {
      return entity.token;
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity?> getLocalUser() async {
    final user = await _offlineRepository.get<IsarUserDTO>();
    if (user != null) {
      return UserEntity.fromIsar(user);
    } else {
      return null;
    }
  }

  @override
  dynamic saveCredentials(AuthCredentials auth) =>
      _offlineRepository.add<IsarCredentialsDTO>(
        data: IsarCredentialsDTO(
          token: auth.token,
          provider: auth.provider,
          role: auth.role,
        ),
      );

  @override
  void saveLocalUser(UserEntity user) =>
      _offlineRepository.add<IsarUserDTO>(data: IsarUserDTO.create(user));

  @override
  dynamic logout({required int id, required String? provider}) async {
    switch (provider ?? '') {
      case 'google':
        await _onlineRepository.logoutWithGoogle();
        break;
      case 'facebook':
        break;
      default:
    }
    await _offlineRepository.delete<IsarUserDTO>(params: {'id': id});
    return await _offlineRepository.delete<IsarCredentialsDTO>();
  }

  @override
  Future<void> signInWithFacebook() async {
    await _onlineRepository.signInFacebook();
  }

}
