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

  Future<void> _openWhatsAppWeb() async {
    String phone = "+556332132775";
    String message = "Olá! Gostaria de entrar em contato com o pastor.";

    launchInBrowser(
      Uri(
        scheme: 'https',
        host: 'wa.me',
        path: phone,
        queryParameters: {'text': message},
      ),
      context,
      width: 350,
      alignment: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = context.sizeOf.width;
    floatingActionRightPadding() {
      if (width > 1200) {
        return 115.0;
      } else if (width > 800) {
        return 24.0;
      } else {
        return 5.0;
      }
    }

    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          right: floatingActionRightPadding(),
        ),
        child: FloatingButtonWidget(
          iconPath: AppIcons.whatsappIcon,
          iconFormat: IconFormat.svg,
          backgroundColor: AppColors.whatsappButton,
          iconColor: AppColors.white,
          fit: BoxFit.scaleDown,
          width: 60,
          height: 60,
          padding: EdgeInsets.only(bottom: 2, left: 2),
          action: _openWhatsAppWeb,
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
