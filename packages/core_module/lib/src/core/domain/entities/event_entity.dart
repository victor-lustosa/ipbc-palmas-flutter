//import 'package:core_module/core_module.dart';

class EventEntity {
  EventEntity(
      {required this.id,
        required this.title,
        required this.subtitle,
        required this.image,
        required this.dateHour,
        required this.description,
        required this.location,
        required this.link,
        required this.linkDescription,
        required this.createAt});

  final String id;
  final String title;
  final String subtitle;
  final String image;
  final DateTime dateHour;
  final String description;
  final String location;
  //TODO: TIRAR DUVIDA SOBRE LOCALIZAÇÃO DO EVENTO E SOBRE O QUE É A DESCRIÇÃO DO LINK E (ONDE FICARIA), E DUVIDA DOS CONTATOS, SERIA UM NUMERO DE WHATSAPP?
  final String link;
  final String linkDescription;
  final DateTime createAt;
}
