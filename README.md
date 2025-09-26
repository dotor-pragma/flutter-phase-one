# Fase 1

Aplicacion Flutter que gestiona un listado de tarjetas informativas y permite crear, editar, revisar y eliminar cada elemento mediante un flujo sencillo basado en Provider y GoRouter.

## Caracteristicas principales
- Lista inicial de tarjetas con titulos y descripciones de ejemplo listos para editar.
- Vistas dedicadas para detalles y formulario de edicion con validaciones basicas.
- Persistencia en memoria mediante `ChangeNotifier` y `Provider`.
- Navegacion declarativa usando `go_router`.
- Tema material personalizable a partir de una paleta predefinida.

## Stack y dependencias
- Flutter 3.9
- go_router para la navegacion.
- provider para el manejo de estado.
- flutter_lints para analisis estatico.

## Requisitos previos
- Flutter SDK >= 3.9 instalado y configurado.
- Dispositivo o emulador Android/iOS configurado, o soporte para ejecutarse en web/desktop.

## Configuracion rapida
```bash
# Instalar dependencias
a flutter pub get

# Ejecutar la aplicacion en un dispositivo disponible
flutter run

# Ejecutar pruebas unitarias
flutter test
```

## Estructura del proyecto
```
lib/
  config/
    router/           # Definicion de rutas con GoRouter
    theme/            # Tema principal de la aplicacion
  domain/
    entities/         # Entidades como InfoCard
  presentation/
    providers/        # ChangeNotifier para la lista de tarjetas
    screens/          # Home, formulario y detalles
    widgets/          # Componentes reutilizables (cards, formulario)
  main.dart           # Punto de entrada con configuracion de Provider y Router
```

## Flujo de uso
1. La pantalla Home muestra todas las tarjetas disponibles y acciones rapidas (ver, editar, eliminar).
2. El boton flotante abre el formulario para crear nuevas tarjetas.
3. El formulario rellena campos automaticamente si se abre en modo edicion.
4. Desde la vista de detalles se puede editar o eliminar directamente la tarjeta seleccionada.

## Buenas practicas y notas
- El proveedor `CardsProvider` valida que titulo y descripcion no esten vacios antes de guardar cambios.
- Los botones de accion emplean estilos consistentes mediante el widget `CardActionButton`.
- El router centraliza la navegacion y facilita agregar nuevas pantallas si se necesitan mas flujos.

## Posibles siguientes pasos
- Persistir la informacion en almacenamiento local (Hive, shared_preferences).
- Agregar pruebas widget para el flujo de creacion y edicion.
- Integrar internacionalizacion y cadenas localizadas.
- Conectar el formulario con una API externa para sincronizar tarjetas reales.
