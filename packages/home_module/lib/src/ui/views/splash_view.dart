import 'package:flutter/material.dart';
import 'package:home_module/home_module.dart';
import '../blocs/database_bloc.dart'; // Ajuste de acordo com sua estrutura de pastas

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DatabaseBloc bloc;

  @override
  void initState() {
    bloc = Modular.get<DatabaseBloc>();
    bloc.add(GetInHiveEvent<DatabasesEvent>());
    super.initState();

    // Verificação de autenticação do Supabase
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final user = Modular.get<Supabase>().client.auth.currentUser;

    if (user != null) {
      // Usuário já logado, vá para a tela inicial
      navigate(AppRoutes.initialRoute);
    }
    // Caso contrário, o fluxo normal de navegação acontece no listener abaixo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, GenericState<DatabasesState>>(
        listener: (context, state) async {
          if (state is FetchingDataState<DatabasesState>) {
            if (state.isData) {
              navigate(
                AppRoutes.initialRoute,
              ); // Usuário logado ou com dados válidos
            } else {
              navigate(
                AppRoutes.authRoute + AppRoutes.loginRoute,
              ); // Tela de login
            }
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState<DatabasesState> ||
              state is FetchingDataState<DatabasesState>) {
            return const LoadingWidget(
              androidRadius: 4,
              iosRadius: 14,
              color: AppColors.darkGreen,
            );
          } else {
            return const GenericErrorView();
          }
        },
      ),
    );
  }
}
