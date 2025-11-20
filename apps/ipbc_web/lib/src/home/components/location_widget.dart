import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> with LaunchUrlMixin {
  Future<void>? locationLink;
  late double vWidth;

  // Separamos os estados para evitar conflitos visuais
  bool isPressed = false;
  bool isHovered = false;

  final Uri _locationLink = Uri(
    scheme: 'https',
    host: 'goo.gl',
    path: 'maps/p25aM3t4Azo23URo7',
  );

  // Getter auxiliar para saber se o botão deve estar destacado
  bool get isActive => isPressed || isHovered;

  @override
  Widget build(BuildContext context) {
    vWidth = context.sizeOf.width;
    if (vWidth > 1200) {
      return web();
    } else if (vWidth > 640) {
      return tablet();
    } else {
      return mobile();
    }
  }

  Container web() => Container(
    width: vWidth,
    margin: const EdgeInsets.only(
      top: 100,
    ),
    padding:
    const EdgeInsets.only(top: 100, bottom: 100, left: 40, right: 40),
    decoration: const BoxDecoration(color: AppColors.grey0),
    child: Column(
      children: [
        SizedBox(
          width: 1200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: imageShadow(),
                child: locationImage(width: 573.26),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(fontSize: 46),
                  subtitle(textAlign: TextAlign.start),
                  address(width: 480),
                  locationButton(size: 215),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Container tablet() => Container(
    width: vWidth,
    margin: const EdgeInsets.only(
      top: 80,
    ),
    padding: const EdgeInsets.only(
      top: 80,
      bottom: 80,
    ),
    decoration: const BoxDecoration(color: AppColors.grey0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: imageShadow(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: locationImage(width: 573.26),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(fontSize: 46),
              subtitle(textAlign: TextAlign.start),
              address(width: 480),
              locationButton(size: 215),
            ],
          ),
        ),
      ],
    ),
  );

  Container mobile() => Container(
    width: vWidth,
    margin: const EdgeInsets.only(
      top: 60,
    ),
    padding: const EdgeInsets.only(
      top: 60,
      bottom: 60,
    ),
    decoration: const BoxDecoration(color: AppColors.grey0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: imageShadow(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: locationImage(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(fontSize: 32),
              subtitle(textAlign: TextAlign.center, width: 360),
              address(width: 360),
              locationButton(size: 342),
            ],
          ),
        ),
      ],
    ),
  );

  Image locationImage({double? width}) => Image(
    width: width,
    fit: BoxFit.cover,
    image: const AssetImage(AppImages.churchLocation),
  );

  Container title({required double fontSize}) => Container(
    margin: const EdgeInsets.only(bottom: 24),
    child: Text(
      'Localização',
      style: AppFonts.defaultFont(
        fontSize: fontSize,
        color: AppColors.grey12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Container subtitle({required TextAlign textAlign, double? width}) => Container(
    width: width,
    margin: const EdgeInsets.only(bottom: 24),
    child: Text(
      textAlign: textAlign,
      'A igreja fica localizada na quadra central em Palmas/TO.',
      style: AppFonts.defaultFont(
        height: 1.5,
        color: AppColors.grey8,
      ),
    ),
  );

  SizedBox address({double? width}) => SizedBox(
    width: width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 7),
          child: Image.asset(
            width: 24,
            height: 24,
            AppIcons.churchLocationIcon,
          ),
        ),
        Flexible(
          child: Text(
            'Quadra Arse 23, Av.Ns 06, Ai 09 - Plano Diretor Sul, Palmas - TO',
            style: AppFonts.defaultFont(
              height: 1.5,
              color: AppColors.grey8,
            ),
          ),
        ),
      ],
    ),
  );

  BoxDecoration imageShadow() => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        blurRadius: 40,
        spreadRadius: 0,
        offset: Offset(4, 4),
        color: Color(0x19000000),
      )
    ],
  );

  Container locationButton({required double size}) => Container(
    margin: const EdgeInsets.only(top: 40),
    child: ButtonWidget(
      // Atualiza apenas o estado de Hover
      onHover: (hovered) {
        setState(() {
          isHovered = hovered;
        });
      },
      adaptiveButtonType: AdaptiveButtonType.outlined,
      fixedSize: Size(size, 49),
      // Usa o getter isActive para decidir a cor base
      sideColor: isActive ? AppColors.highlightGreen : AppColors.darkGreen,
      foregroundColor: AppColors.darkGreen,
      overlayColor: AppColors.grey0,
      sideHoveredColor: AppColors.highlightGreen,
      foregroundHoveredColor: AppColors.highlightGreen,
      action: () {
        // Lógica de clique afeta apenas isPressed
        Future.delayed(Duration.zero, () {
          setState(() {
            isPressed = true;
          });
        });
        Future.delayed(
          const Duration(milliseconds: 600),
              () {
            setState(
                  () {
                locationLink = launchInBrowser(_locationLink, context);
              },
            );
          },
        );
        Future.delayed(
          const Duration(milliseconds: 600),
              () {
            setState(
                  () {
                isPressed = false;
              },
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ver Localização'),
          Container(
            margin: const EdgeInsets.only(left: 16),
            // Troca o ícone se estiver Hovered OU Pressed
            child: Image.asset(
              isActive
                  ? AppIcons.arrowIconHighlightGreen
                  : AppIcons.arrowIconDarkGreen,
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    ),
  );
}