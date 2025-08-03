import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EditLiturgyDTO {
  EditLiturgyDTO({required this.heading, required this.image});
  final String heading;
  final String image;
}

class EditLiturgyStore extends ChangeNotifier {

  int index = 0;
  late LiturgyModel entity;
  late EditLiturgyDTO dto;

  late List<LiturgyModel> items;

  fillItems(){
    items = [
      LiturgyModel(
        id: '0',
        isAdditional: false,
        sequence: 'Oração',
        additional: '',
      ),
      LiturgyModel(
        id: '1',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'João 10:1-6',
      ),
      LiturgyModel(
        id: '2',
        isAdditional: true,
        sequence: 'Hino 151',
        additional: 'O Bom Pastor',
      ),
      LiturgyModel(
        id: '3',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'Lucas 15:1-7',
      ),
      LiturgyModel(
        id: '4',
        isAdditional: false,
        sequence: 'Oração de confissão de pecados',
        additional: '',
      ),
      LiturgyModel(
        id: '5',
        isAdditional: false,
        sequence: 'Cânticos',
        additional: '',
      ),
      LiturgyModel(
        id: '6',
        isAdditional: true,
        sequence: 'Pregação',
        additional: 'O Bom Pastor - Salmo 23',
      ),
      LiturgyModel(
        id: '7',
        isAdditional: false,
        sequence: 'Santa Ceia',
        additional: '',
      ),
      LiturgyModel(
        id: '8',
        isAdditional: false,
        sequence: 'Oração final',
        additional: '',
      ),
    ];
    notifyListeners();
  }
  void setEditLiturgyDTO(EditLiturgyDTO dto) {
    this.dto = dto;
    notifyListeners();
  }

  void addBox() {
    items.insert(
      index,
      LiturgyModel(
        id: SupaServicesUtil.createId(),
        isAdditional: true,
        sequence: 'Título',
        additional: 'Descrição',
      ),
    );
    notifyListeners();
  }

  void copyEntity() {
    items.insert(index, entity.copyWith(id: SupaServicesUtil.createId()));
    notifyListeners();
  }

  void delete() {
    items.remove(entity);
    notifyListeners();
  }
}
