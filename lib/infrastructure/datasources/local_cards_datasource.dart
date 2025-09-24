import 'package:fase_1/domain/entities/info_card.dart';

/// Simple in-memory data source used to bootstrap the examples cards.
class LocalCardsDataSource {
  LocalCardsDataSource();

  final List<InfoCard> _cards = [
    const InfoCard(
      title: 'Guía de Café de Especialidad',
      description:
          'Aprende a identificar los perfiles de sabor según la región y el método de filtrado.',
    ),
    const InfoCard(
      title: 'Plan de Viaje a Kyoto',
      description:
          'Templos imprescindibles, barrios históricos y recomendaciones culinarias para cinco días.',
    ),
    const InfoCard(
      title: 'Rutina HIIT de 20 Minutos',
      description:
          'Secuencia de entrenamiento con calentamiento, bloques de alta intensidad y estiramientos finales.',
    ),
    const InfoCard(
      title: 'Checklist de Lanzamiento de App',
      description:
          'Revisión final de QA, marketing assets y métricas clave antes de publicar en stores.',
    ),
    const InfoCard(
      title: 'Introducción al Arte Barroco',
      description:
          'Características principales, artistas destacados y obras representativas del movimiento.',
    ),
    const InfoCard(
      title: 'Receta de Tacos Veganos',
      description:
          'Tortillas de maíz con relleno de coliflor rostizada, salsa de aguacate y pico de gallo.',
    ),
    const InfoCard(
      title: 'Checklist de Seguridad en la Web',
      description:
          'Autenticación multifactor, protección CSRF y gestión segura de contraseñas para proyectos pequeños.',
    ),
    const InfoCard(
      title: 'Plan de Lectura de Ciencia Ficción',
      description:
          'Cinco novelas esenciales que exploran viajes en el tiempo, IA y contacto extraterrestre.',
    ),
    const InfoCard(
      title: 'Tips de Productividad en Remote Work',
      description:
          'Bloques de tiempo, comunicación asíncrona efectiva y diseño de espacio ergonómico.',
    ),
    const InfoCard(
      title: 'Glosario de Términos de UX Writing',
      description:
          'Microcopy, tono y voz, jerarquía de contenidos y buenas prácticas para mensajes claros.',
    ),
  ];

  List<InfoCard> fetchCards() => List.unmodifiable(_cards);

  void saveCard(InfoCard card) {
    _cards.add(card);
  }

  void updateCard(int index, InfoCard card) {
    if (index < 0 || index >= _cards.length) {
      throw RangeError.index(index, _cards, 'index');
    }
    _cards[index] = card;
  }

  void removeCard(int index) {
    if (index < 0 || index >= _cards.length) {
      throw RangeError.index(index, _cards, 'index');
    }
    _cards.removeAt(index);
  }
}
