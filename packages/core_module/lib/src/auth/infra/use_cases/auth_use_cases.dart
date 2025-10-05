import '../../../../core_module.dart';
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
    final response = await _onlineRepository.signInWithEmail(email, password);
    return response.fold(
      (authUserDTO) async {
        String jwtToken = authUserDTO.auth.token ?? "";
        await _saveUserAndCredentials(
          authUserDTO.user,
          AuthCredentials(
            token: jwtToken,
            provider: authUserDTO.user.provider ?? '',
            role: authUserDTO.user.role ?? '',
          ),
        );
        return Future.value(jwtToken);
      },
      (exception) {
        switch(exception.statusCode) {
          case '400':
            return Future.value('Por favor, verifique seu e-mail ou senha e tente novamente.');
          case '403':
            return Future.value('Acesso proibido. Verifique suas credenciais.');
          case '404':
            return Future.value('Usuário não encontrado. Verifique o email informado.');
          case '500':
            return Future.value('Erro no servidor. Tente novamente mais tarde.');
          default:
            return Future.value('Erro desconhecido. Código: ${exception.code}');
        }
      },
    );
  }

  @override
  Future<String?> signInWithGoogle() async {
    final String? jwtToken = await _onlineRepository.signInWithGoogle();
    if (jwtToken == null) return null;
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
    HiveCredentialsDTO? entity = await _offlineRepository
        .get<HiveCredentialsDTO>();
    if (entity != null) {
      return entity.token;
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity?> getLocalUser() async {
    final user = await _offlineRepository.get<HiveUserDTO>();
    if (user != null) {
      return UserEntity.fromIsar(user);
    } else {
      return null;
    }
  }

  @override
  dynamic saveCredentials(AuthCredentials auth) =>
      _offlineRepository.add<HiveCredentialsDTO>(
        data: HiveCredentialsDTO(
          token: auth.token,
          provider: auth.provider,
          role: auth.role,
        ),
      );

  @override
  void saveLocalUser(UserEntity user) =>
      _offlineRepository.add<HiveUserDTO>(data: HiveUserDTO.create(user));

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
    await _offlineRepository.delete<HiveUserDTO>(params: {'id': id});
    return await _offlineRepository.delete<HiveCredentialsDTO>();
  }

  @override
  Future<void> signInWithFacebook() async {
    await _onlineRepository.signInFacebook();
  }
}
