import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart'; // Importe seu LoadingWidget e Cores

class CustomRefreshWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Widget? icon; // Ícone para a fase de "puxar" (Seta ou Logo)

  const CustomRefreshWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    this.icon,
  });

  @override
  State<CustomRefreshWidget> createState() => _CustomRefreshWidgetState();
}

class _CustomRefreshWidgetState extends State<CustomRefreshWidget> {
  // Controle de estado
  bool _isRefreshing = false;
  double _dragOffset = 0.0;

  // Configurações
  final double _triggerDistance = 80.0; // Distância para ativar
  final double _maxDragDistance = 120.0; // Máximo que desce visualmente

  // Lógica de Scroll (NotificationListener)
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.pixels < 0) {
        final double overscroll = notification.metrics.pixels.abs();
        if (!_isRefreshing) {
          setState(() {
            _dragOffset = overscroll.clamp(0.0, _maxDragDistance);
          });
        }
      } else if (_dragOffset > 0 && !_isRefreshing) {
        setState(() {
          _dragOffset = 0.0;
        });
      }
    } else if (notification is ScrollEndNotification) {
      if (_dragOffset >= _triggerDistance && !_isRefreshing) {
        _startRefresh();
      } else {
        _reset();
      }
    }
    return false;
  }

  void _startRefresh() async {
    setState(() {
      _isRefreshing = true;
      _dragOffset = _triggerDistance; // Trava na altura de loading
    });

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        _reset();
      }
    }
  }

  void _reset() {
    setState(() {
      _isRefreshing = false;
      _dragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. A LISTA
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: widget.child,
        ),

        // 2. O INDICADOR
        if (_dragOffset > 0)
          Positioned(
            top: _dragOffset - 45, // Posiciona logo acima do dedo
            left: 0,
            right: 0,
            child: Center(
              child: _buildIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildIndicator() {
    // Porcentagem do puxão (0.0 a 1.0)
    final double percentage = (_dragOffset / _triggerDistance).clamp(0.0, 1.0);

    return Container(
      width: 45, // Tamanho da "bolinha" branca
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Center( // Garante que o conteúdo fique no meio da bolinha
        child: _isRefreshing
            ? _buildLoadingState() // MOSTRA SEU LOADING WIDGET
            : _buildDragState(percentage), // MOSTRA ÍCONE GIRANDO
      ),
    );
  }

  // --- AQUI ESTÁ A INTEGRAÇÃO COM SEU WIDGET ---
  Widget _buildLoadingState() {
    return const LoadingWidget(
      // É CRUCIAL passar o tamanho, senão ele pega a tela toda!
      size: 24,
      androidRadius: 2.5, // Ajuste fino para ficar bonito pequeno
      iosRadius: 10,      // Ajuste fino para o Cupertino
      color: AppColors.darkGreen,
    );
  }

  Widget _buildDragState(double percentage) {
    return Transform.rotate(
      angle: percentage * 2 * math.pi, // Gira conforme puxa
      child: Opacity(
        opacity: percentage,
        child: Transform.scale(
          scale: percentage,
          // Ícone padrão ou sua Logo
          child: widget.icon ??
              const Icon(
                  Icons.refresh,
                  color: AppColors.darkGreen,
                  size: 24
              ),
        ),
      ),
    );
  }
}