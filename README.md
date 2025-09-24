# Fase 1 – Clean Flutter Showcase

Una aplicación Flutter que ejemplifica una arquitectura limpia y una experiencia de usuario moderna para administrar una galería de tarjetas informativas. Incluye un flujo completo de listado, creación, edición y eliminación con transiciones suaves, validaciones ricas y separación clara por capas.

## 🧱 Arquitectura

El proyecto está organizado según principios de Clean Architecture:

- **domain**: Entidades puras y casos de uso (`InfoCard`, `AddCardUseCase`, etc.).
- **infrastructure**: Implementaciones concretas (por ejemplo, `LocalCardsDataSource`, `CardsRepositoryImpl`).
- **presentation**: UI y estado. Se utiliza `provider` para exponer los casos de uso a la capa de widgets.
- **config**: Router (`go_router`) y tema central.

```
lib/
├── config/
├── domain/
├── infrastructure/
├── presentation/
│   ├── providers/
│   ├── screens/
│   └── widgets/
└── main.dart
```

## ✨ Características principales

- Lista animada de tarjetas con _hero animations_ y confirmación al eliminar.
- Formulario con validaciones en tiempo real, mensajes de error amigables y feedback contextual.
- Pantalla de detalles con estilo consistente y recomendaciones.
- Navegación declarativa usando `go_router` con transiciones personalizadas.
- Gestión de estado con `ChangeNotifier` y dependencias inyectadas vía casos de uso.

## 🚀 Puesta en marcha

1. **Requisitos**
   - Flutter 3.9.2 o superior (`flutter --version`)
   - Dart SDK 3.9.2 o superior

2. **Instalación de dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecución**
   ```bash
   flutter run
   ```

4. **Análisis estático**
   ```bash
   flutter analyze
   ```

## 🧩 Detalles técnicos

| Área                 | Implementación |
| -------------------- | -------------- |
| Estado               | `provider` (`CardsProvider`) con listas inmutables. |
| Navegación           | `go_router` (`appRouter`) con páginas de transición personalizada. |
| UI                   | Widgets desacoplados en `presentation/widgets/` (por ejemplo, `HomeView`, `CustomInfoCard`). |
| Diseño               | `ThemeData` basado en `ColorScheme.fromSeed` configurable desde `AppTheme`. |
| Datos                | Fuente en memoria (`LocalCardsDataSource`) siguiendo contrato `CardsRepository`. |

## 🛠️ Guía de desarrollo

- **Nuevas funcionalidades**: Implementa un caso de uso en `domain/usecases/`, añade la fuente de datos correspondiente en `infrastructure/` y expón la lógica a través de un provider o controlador en `presentation/`.
- **Componentes UI**: Coloca widgets reutilizables dentro de `presentation/widgets/` manteniendo responsabilidades pequeñas.
- **Rutas**: Registra nuevas pantallas en `config/router/app_router.dart` devolviendo instancias o `CustomTransitionPage` según necesidad.
- **Temas**: Ajusta colores globales en `config/theme/app_theme.dart` o extiende el `ThemeData` con tipografías propias.

## 📈 Rendimiento y buenas prácticas

- Los `Selector`s en `HomeView` minimizan reconstrucciones al escuchar cambios específicos del provider.
- Las listas se exponen como `UnmodifiableListView` para evitar mutaciones accidentales.
- Se reutilizan animaciones y widgets especializados (por ejemplo, `AnimatedCardItem`) para mantener la UI reactiva.
- `flutter analyze` se mantiene limpio, lo que facilita la integración continua.

### Ideas futuras

- Persistir las tarjetas usando almacenamiento local o remoto.
- Añadir pruebas unitarias/widget para casos de uso críticos.
- Implementar `ThemeMode` con soporte claro/oscuro.
- Incluir internacionalización (`intl`) para mensajes y validaciones.

## 📄 Licencia

Este proyecto es de uso interno para el proceso Talent Pool. Ajusta y reutiliza libremente según tus necesidades.
