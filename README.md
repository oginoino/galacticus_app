# galacticus_app

Base Flutter estruturada a partir do blueprint descrito em `docs/manual_estrutura_tecnica_flutter.md` para reproduzir o protótipo do Galácticos Club.

## Arquitetura

Estrutura principal em `lib/`:

```text
lib/
├── app/
├── di/
├── domain/
├── dto/
├── l10n/
├── provider/
├── repository/
├── route/
├── service/
├── ui/
└── util/
```

## Como executar

```bash
flutter pub get
flutter run
```

## Dart defines opcionais

```bash
flutter run --dart-define=APP_NAME="Galácticos Club" --dart-define=APP_TITLE="Galácticos Club"
```
