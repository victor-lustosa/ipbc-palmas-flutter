import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../layout/footer/footer_widget.dart';
import '../../../layout/top_bar/top_bar_widget.dart';
import '../components/about_church_widget.dart';
import '../components/about_services_widget.dart';
import '../components/app_stores_widget.dart';
import '../components/contact_form_widget.dart';
import '../components/location_widget.dart';
import '../view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, LaunchUrlMixin {
  late final AnimationController _shimmerController;

  @override
  initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  Future<void> _abrirWhatsAppWeb() async {
    String numeroTelefone = "5511987654321";
    String mensagem = "Olá! Vi seu site e gostaria de mais informações.";

    launchInBrowser(
      Uri(
        scheme: 'https',
        host: 'wa.me',
        path: numeroTelefone,
        queryParameters: {'text': mensagem},
      ),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10, right: 5),
        child: FloatingButtonWidget(
          iconPath: AppIcons.whatsappIcon,
          iconFormat: IconFormat.svg,
          backgroundColor: AppColors.whatsappButton,
          iconColor: AppColors.white,
          fit: BoxFit.scaleDown,
          size: 60,
          padding: EdgeInsets.only(bottom: 2, left: 2),
          action: _abrirWhatsAppWeb,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: Modular.get<HomeViewModel>().scrollController,
          child: Column(
            children: [
              const TopBarWidget(),
              AboutChurchWidget(shimmerController: _shimmerController),
              const LocationWidget(),
              AboutServicesWidget(shimmerController: _shimmerController),
              const AppStoresWidget(),
              const ContactFormWidget(),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
