import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class VersesListWidget extends StatelessWidget {
  const VersesListWidget({
    super.key,
    required this.entity,
    required this.isEdit,
  });

  final bool isEdit;
  final List<VerseEntity> entity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entity.length,
      itemBuilder: (_, index) {
        final currentBlock = entity[index];

        // --- Lógica para Estrofes Normais (não-refrão) ---
        if (!currentBlock.isChorus) {
          return Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            padding: const EdgeInsets.all(16), // Padding padrão
            decoration: BoxDecoration(
              color: isEdit ? AppColors.secondaryGrey2 : AppColors.white,
              borderRadius: BorderRadius.circular(isEdit ? 0 : 16),
            ),
            child: _buildVerseTextColumn(context, currentBlock.versesList),
          );
        }

        // --- LÓGICA DE FUSÃO PARA REFRÕES ---

        // 1. Verificamos o contexto do bloco
        final bool isPreviousChorus = (index > 0) && entity[index - 1].isChorus;
        final bool isNextChorus =
            (index < entity.length - 1) && entity[index + 1].isChorus;

        const double radiusValue = 16.0;

        // 2. Determinamos o BorderRadius
        BorderRadius borderRadius;
        if (!isPreviousChorus && isNextChorus) {
          borderRadius = const BorderRadius.vertical(top: Radius.circular(radiusValue));
        } else if (isPreviousChorus && isNextChorus) {
          borderRadius = BorderRadius.zero;
        } else if (isPreviousChorus && !isNextChorus) {
          borderRadius = const BorderRadius.vertical(bottom: Radius.circular(radiusValue));
        } else {
          borderRadius = const BorderRadius.all(Radius.circular(radiusValue));
        }
        if (isEdit) {
          borderRadius = BorderRadius.zero;
        }

        // ## MUDANÇA PRINCIPAL AQUI ##
        // 3. Determinamos o Padding dinamicamente para reduzir o espaço interno.
        EdgeInsets padding;
        const double fullPadding = 16.0;
        const double halfPadding = 8.0; // Espaçamento reduzido

        if (!isPreviousChorus && isNextChorus) {
          // PRIMEIRO bloco: padding inferior reduzido
          padding = const EdgeInsets.fromLTRB(fullPadding, fullPadding, fullPadding, halfPadding);
        } else if (isPreviousChorus && isNextChorus) {
          // Bloco do MEIO: padding vertical reduzido
          padding = const EdgeInsets.symmetric(horizontal: fullPadding, vertical: halfPadding);
        } else if (isPreviousChorus && !isNextChorus) {
          // ÚLTIMO bloco: padding superior reduzido
          padding = const EdgeInsets.fromLTRB(fullPadding, halfPadding, fullPadding, fullPadding);
        } else {
          // Bloco ÚNICO: padding padrão
          padding = const EdgeInsets.all(fullPadding);
        }

        return Container(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: isNextChorus ? 0 : 12,
          ),
          padding: padding, // Usamos o padding dinâmico calculado
          decoration: BoxDecoration(
            color: AppColors.chorusColor,
            borderRadius: borderRadius,
          ),
          child: _buildVerseTextColumn(context, currentBlock.versesList),
        );
      },
    );
  }

  Widget _buildVerseTextColumn(BuildContext context, List<String> lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            line,
            style: AppFonts.defaultFont(
              color: AppColors.grey10,
              fontSize: context.sizeOf.width > ResponsivityUtil.smallDeviceWidth
                  ? 16
                  : 14,
            ),
          ),
        );
      }).toList(),
    );
  }
}