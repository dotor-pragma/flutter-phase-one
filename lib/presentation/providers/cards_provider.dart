import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:fase_1/domain/entities/info_card.dart';

class CardsProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final List<InfoCard> _cardsList = [
    InfoCard(
      title: 'Guía de Café de Especialidad',
      description:
          'Aprende a identificar los perfiles de sabor según la región y el método de filtrado.',
    ),
    InfoCard(
      title: 'Plan de Viaje a Kyoto',
      description:
          'Templos imprescindibles, barrios históricos y recomendaciones culinarias para cinco días.',
    ),
    InfoCard(
      title: 'Rutina HIIT de 20 Minutos',
      description:
          'Secuencia de entrenamiento con calentamiento, bloques de alta intensidad y estiramientos finales.',
    ),
    InfoCard(
      title: 'Checklist de Lanzamiento de App',
      description:
          'Revisión final de QA, marketing assets y métricas clave antes de publicar en stores.',
    ),
    InfoCard(
      title: 'Introducción al Arte Barroco',
      description:
          'Características principales, artistas destacados y obras representativas del movimiento.',
    ),
    InfoCard(
      title: 'Receta de Tacos Veganos',
      description:
          'Tortillas de maíz con relleno de coliflor rostizada, salsa de aguacate y pico de gallo.',
    ),
    InfoCard(
      title: 'Checklist de Seguridad en la Web',
      description:
          'Autenticación multifactor, protección CSRF y gestión segura de contraseñas para proyectos pequeños.',
    ),
    InfoCard(
      title: 'Plan de Lectura de Ciencia Ficción',
      description:
          'Cinco novelas esenciales que exploran viajes en el tiempo, IA y contacto extraterrestre.',
    ),
    InfoCard(
      title: 'Tips de Productividad en Remote Work',
      description:
          'Bloques de tiempo, comunicación asíncrona efectiva y diseño de espacio ergonómico.',
    ),
    InfoCard(
      title: 'Glosario de Términos de UX Writing',
      description:
          'Microcopy, tono y voz, jerarquía de contenidos y buenas prácticas para mensajes claros.',
    ),
  ];

  UnmodifiableListView<InfoCard> get cardsList =>
      UnmodifiableListView(_cardsList);

  void addCard(String title, String description) {
    if (title.isEmpty || description.isEmpty) return;

    final newCard = InfoCard(title: title, description: description);

    _cardsList.add(newCard);
    notifyListeners();
  }

  void removeCard(int index) {
    _cardsList.removeAt(index);
    notifyListeners();
  }

  void editCard(
    int index, {
    required String title,
    required String description,
  }) {
    _cardsList[index] = InfoCard(title: title, description: description);
    notifyListeners();
  }
}
