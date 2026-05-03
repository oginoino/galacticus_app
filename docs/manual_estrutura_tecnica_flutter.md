# Manual Técnico de Estrutura de Aplicativos Flutter

## Objetivo

Este documento descreve, a partir da análise do projeto, um modelo técnico de estrutura para aplicações Flutter com foco em:

- organização arquitetural
- responsabilidades por camada
- bootstrap da aplicação
- roteamento
- gerenciamento de dependências
- gerenciamento de estado
- configuração de ambiente
- práticas técnicas observadas

O foco aqui não é o domínio funcional do aplicativo, mas sim o desenho técnico que pode servir como base para outros projetos Flutter de médio porte.

## Visão Geral da Arquitetura

O projeto adota uma arquitetura em camadas, com separação relativamente clara entre:

- inicialização da aplicação
- injeção de dependências
- domínio
- transformação de dados
- acesso a dados
- serviços de infraestrutura
- estado da apresentação
- roteamento
- interface

Na prática, a estrutura se aproxima deste fluxo:

`UI -> Provider -> Repository/Service -> DTO/HTTP/Persistência -> Domain`

Esse formato é útil porque:

- reduz acoplamento entre UI e infraestrutura
- concentra regras de acesso a dados em pontos previsíveis
- facilita manutenção incremental
- melhora legibilidade do projeto
- cria uma base razoável para testes e evolução futura

## Estrutura de Pastas

Dentro de `lib/`, a organização principal é:

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

### `app/`

Contém o bootstrap e a composição central da aplicação.

- `app.dart`: define o `MaterialApp.router`
- `bootstrap.dart`: executa inicialização e configuração global antes do `runApp`

Essa pasta concentra o ponto de entrada arquitetural do app.

### `di/`

Contém a configuração de injeção de dependências em `di.dart`, usando `GetIt`.

Nessa camada são registrados:

- serviços de persistência
- clientes HTTP
- repositórios
- utilitários compartilhados
- serviços autenticados e públicos

É o centro de wiring técnico do sistema.

### `domain/`

Contém entidades de domínio puras, como:

- `product.dart`
- `order.dart`
- `location.dart`
- `cart.dart`
- `message.dart`

Essas classes representam o modelo interno da aplicação e devem permanecer independentes de detalhes de transporte ou UI.

### `dto/`

Contém objetos de transferência e adaptação entre JSON e domínio.

Exemplo:

- `product_dto.dart`
- `location_dto.dart`

Os DTOs funcionam como fronteira entre a estrutura externa dos dados e o formato interno consumido pela aplicação.

### `l10n/`

Centraliza internacionalização:

- arquivos `.arb`
- classes geradas de localização
- suporte a múltiplos idiomas

Esse diretório segue o padrão oficial do ecossistema Flutter para i18n.

### `provider/`

Contém os `ChangeNotifier`s responsáveis pelo estado da apresentação.

Exemplos:

- `auth_provider`
- `product_provider`
- `cart_provider`
- `location_provider`
- `message_provider`
- `locale_provider`
- `theme_provider`

Também contém `register_provider.dart`, que registra o conjunto de providers do app.

### `repository/`

Camada de acesso a dados e abstração das fontes.

Exemplos:

- `auth_repository`
- `product_repository`
- `location_repository`
- `message_repository`
- `user_repository`
- `base_repository.dart`

Essa camada evita que a UI ou os providers conheçam detalhes de rede, serialização ou persistência.

### `route/`

Organiza navegação com `go_router`.

Componentes principais:

- `app_route.dart`: abstração sobre `GoRoute`
- `router/router.dart`: árvore principal de rotas
- `routes/routes.dart`: catálogo de rotas
- `handle/handle_redirect.dart`: ponto de redirecionamento e futura proteção de rotas

### `service/`

Camada de infraestrutura técnica.

Exemplos:

- `http/`: cliente HTTP, request, response, status, interceptors e logger
- `api/`: fábrica de clientes
- `persistence/`: persistência local
- `localization/`: serviço auxiliar de textos
- `checkout/`, `search/`, `auth/`, `user/`: serviços especializados

### `ui/`

Camada de apresentação visual.

Subdivisões:

- `components/`: widgets reutilizáveis
- `page/`: telas completas
- `theme/`: temas claro e escuro

É uma divisão adequada para projetos que querem evitar páginas muito pesadas e incentivar composição.

### `util/`

Pasta de apoio transversal ao projeto.

Contém:

- constantes
- variáveis de ambiente
- configurações de locale
- helpers
- logs
- barrel files em `import/`

É uma pasta útil, mas que precisa de disciplina para não virar repositório genérico de utilidades sem fronteira clara.

## Dependências Principais

O `pubspec.yaml` indica um conjunto enxuto e coerente com a arquitetura observada.

### Dependências de arquitetura e estado

- `provider`: gerenciamento de estado baseado em `ChangeNotifier`
- `get_it`: service locator para DI
- `go_router`: roteamento declarativo

Essas três dependências formam a espinha dorsal estrutural do app.

### Dependências de infraestrutura

- `shared_preferences`: persistência local leve
- `http`: cliente HTTP efetivamente usado na implementação
- `intl`: formatação e suporte regional
- `flutter_localizations`: integração nativa com localizações do Flutter
- `flutter_localization`: suporte complementar de localização

### Dependências de UI

- `google_fonts`: tipografia customizada
- `cached_network_image`: cache de imagens remotas
- `flutter_animate`: animações declarativas
- `cupertino_icons`: ícones adicionais

### Dependências de build e setup visual

- `flutter_native_splash`
- `flutter_launcher_icons`
- `flutter_lints`
- `flutter_test`

### Observação importante sobre dependências

O pacote `dio` está declarado em `pubspec.yaml`, mas não há uso aparente dele no código analisado em `lib/`. A implementação HTTP atual usa `package:http`.

Isso sugere uma de duas situações:

- dependência remanescente de uma abordagem anterior
- preparação para adoção futura

Como prática técnica, dependências não utilizadas devem ser removidas para evitar:

- aumento desnecessário do grafo de dependências
- confusão arquitetural
- falsa expectativa sobre o stack real de infraestrutura

## Bootstrap da Aplicação

O fluxo de inicialização está bem definido e distribuído entre `lib/main.dart`, `lib/app/bootstrap.dart` e `lib/app/app.dart`.

### `main.dart`

O ponto de entrada faz:

1. `WidgetsFlutterBinding.ensureInitialized()`
2. `Bootstrap.init()`
3. `runApp(...)` com `MultiProvider`

Esse formato é correto para aplicações que dependem de inicialização assíncrona antes da árvore de widgets.

Também existe tratamento de exceção no `main`, delegando para `ErrorHandler`.

### `Bootstrap.init()`

O bootstrap executa duas responsabilidades principais:

1. registrar dependências
2. configurar o roteador

Atualmente:

- `_registerDependencies()` chama `DependencyInjection.register()`
- `_configureRouter()` ativa `GoRouter.optionURLReflectsImperativeAPIs = true`

Essa separação é saudável porque evita poluir o `main.dart` com detalhes estruturais.

### `App`

Em `app.dart`, a aplicação é montada com `MaterialApp.router`, consumindo:

- `ThemeProvider`
- `LocaleProvider`
- `appRouter`
- `LocaleConfig`
- `AppConstants`

Esse desenho mostra uma composição centralizada e orientada a estado global controlado.

## Injeção de Dependências

O projeto usa `GetIt` como service locator em `lib/di/di.dart`.

### O que é registrado

O registro atual cobre:

- `PersistenceService`
- `AppConstants`
- `LocalizationService`
- `UiToken`
- serviços HTTP públicos, autenticados e de autenticação
- `CheckoutService`
- repositórios de produto, localização, autenticação, usuário e mensagens
- repositórios de serviço específicos como `AuthServiceRepository` e `UserServiceRepository`

### Estratégia adotada

São usados principalmente:

- `registerSingleton`
- `registerLazySingleton`

Isso favorece compartilhamento global e inicialização sob demanda.

### Pontos positivos

- ponto único para wiring da aplicação
- redução de acoplamento entre camadas
- facilita reuso de serviços e persistência
- torna bootstrap previsível

### Pontos de atenção

- o uso de getters globais como `productRepository`, `publicService`, `appConstants` simplifica o acesso, mas reforça o padrão de service locator e reduz a explicitude das dependências
- para cenários de testes mais rigorosos, injeção por construtor tende a ser mais previsível
- existe o getter duplicado `persistenseService` e `persistenceService`, o que indica dívida técnica nominal

Como prática para projetos maiores, vale padronizar:

- nomes consistentes
- registro modular por feature ou camada
- estratégia clara de reset/substituição das dependências em testes

## Configuração de Ambiente

O projeto usa `String.fromEnvironment` em `lib/util/const/environment/environment.dart`, o que indica uso de `--dart-define`.

Variáveis observadas:

- `APP_NAME`
- `APP_VERSION`
- `APP_TITLE`
- `APP_DESCRIPTION`
- `AUTH_BASE_URL`
- `AUTH_TIMEOUT_MS`
- `AUTH_API_PREFIX`
- `CORE_API_BASE_URL`
- `CORE_API_PREFIX`

### Leitura técnica

Essa abordagem é adequada para:

- separação entre ambientes
- customização por build
- evitar hardcode de endpoints

### Boa prática derivada

Em uma estrutura base de aplicativo Flutter, essa pasta e esse padrão devem existir desde o início, junto com:

- convenção documentada de `dart-defines`
- arquivos de exemplo de execução
- validação mínima de variáveis obrigatórias em bootstrap

Atualmente o código usa fallback para alguns valores, o que reduz falha em tempo de execução, mas pode esconder configuração incompleta.

## Camadas de Domínio, DTO e Dados

### Domínio

A pasta `domain/` representa bem a camada de modelo interno.

O arquivo `product.dart`, por exemplo, mostra:

- entidade rica
- boa tipagem
- composição com subobjetos
- helpers limitados e simples

Isso é um bom sinal: o domínio não está contaminado por detalhes de API ou widgets.

### DTO

Os DTOs fazem serialização e adaptação.

No `product_dto.dart`, é possível observar:

- `fromJson`
- `toJson`
- `fromDomain`
- `toDomain`

Esse padrão é tecnicamente sólido porque:

- preserva independência do domínio
- facilita mudança de contrato externo
- evita espalhar parsing JSON pela aplicação

### Repositórios

O projeto usa `BaseRepository` como classe base para padronizar:

- `handleResponse`
- `handleListResponse`
- composição de URL
- limpeza de query params
- tratamento de erro

Esse é um bom ponto de centralização de comportamento transversal.

### Observação relevante

Há uma mistura intencional de fontes:

- `ProductRepository` carrega dados de `assets/data/products.json`
- `AuthRepository` opera sobre API

Ou seja, o padrão estrutural já suporta tanto:

- dados mockados ou estáticos
- dados remotos

Isso é útil para apps em evolução, protótipos avançados e cenários offline-first parciais.

## Camada de Serviços

## HTTP

O stack HTTP foi implementado de forma própria em `service/http/`, com:

- interface `HttpServiceInterface`
- implementação `HttpService`
- `HttpRequest`
- `HttpResponse`
- `HttpStatus`
- logger
- interceptors
- wrapper de retry

### Características importantes

- cliente baseado em `package:http`
- suporte a métodos `GET`, `POST`, `PUT`, `PATCH`, `DELETE` e upload
- tratamento de timeout, parsing e erros de rede
- suporte a interceptadores de request e response

### `ApiServiceFactory`

A fábrica cria três perfis de serviço:

- `createAuthService()`
- `createAuthenticatedService()`
- `createPublicService()`

Esse desenho é muito apropriado para separar:

- endpoints públicos
- endpoints de autenticação
- endpoints que exigem token

### `AuthInterceptor`

O interceptador:

- adiciona token automaticamente
- evita incluir auth em endpoints públicos de login/registro/reset
- tenta refresh em caso de renovação necessária
- limpa autenticação se o refresh falhar

É uma base técnica boa para ciclo de autenticação, embora a robustez real dependa do comportamento do backend.

### `RetryInterceptor`

Há suporte a retry com:

- backoff exponencial
- jitter
- lista de status codes reprocessáveis

Esse é um ponto positivo de resiliência.

## Persistência Local

`PersistenceService` encapsula `SharedPreferences` e centraliza:

- preferências de tema
- locale
- onboarding
- access token
- refresh token
- expiração do token

Essa centralização é recomendada porque evita espalhar chaves e regras de persistência pelo projeto.

## Localização

O projeto possui:

- `lib/l10n/`
- `l10n.yaml`
- `LocaleConfig`
- `LocalizationService`

Idiomas observados:

- português
- inglês
- espanhol

### Leitura técnica

Há uma combinação entre geração oficial de localizações e um serviço estático (`LocalizationService`) para acesso simplificado a strings.

Funciona, mas exige disciplina de inicialização. O próprio código deixa isso claro ao carregar locale padrão durante o registro das dependências.

Como prática, esse modelo é aceitável, mas pode evoluir para um acesso menos estático se o projeto crescer muito.

## Gerenciamento de Estado

O projeto usa `Provider` com `ChangeNotifier`.

### Registro

Os providers são centralizados em `lib/provider/register_provider.dart` e injetados por `MultiProvider` no `main.dart`.

### Papel dos providers

Cada provider atua como camada de estado e orquestração da UI.

Exemplos observados:

- `ProductProvider`: carrega produtos, filtra, pagina, ordena e fornece sugestões
- `AuthProvider`: executa login, logout, registro e reset de senha
- `ThemeProvider` e `LocaleProvider`: mantêm estado global de aparência e idioma

### Interpretação arquitetural

O provider aqui cumpre papel próximo de ViewModel ou Presenter leve:

- recebe eventos da UI
- chama repositórios/serviços
- mantém estado observável
- notifica mudanças

### Boa prática observada

As telas não precisam conhecer diretamente detalhes de infraestrutura.

### Limitação estrutural atual

Os providers chamam repositórios diretamente, sem uma camada explícita de casos de uso ou `use_cases`.

Isso significa que a arquitetura é organizada, mas ainda não está em um formato de Clean Architecture mais estrito.

Em resumo:

- existe separação de camadas
- mas não existe uma camada de aplicação explícita entre provider e repository

Para muitos apps isso é suficiente. Para apps com regras de negócio mais complexas, recomenda-se adicionar:

- `usecase/` ou `application/`
- comandos e consultas
- orquestração de regras de negócio fora da UI state layer

## Roteamento

O projeto usa `go_router` com abstrações próprias.

### Componentes principais

- `Routes`: catálogo de paths e nomes
- `appRouter`: instância global de `GoRouter`
- `AppRoute`: encapsula configuração repetitiva de páginas
- `HandleRedirect`: ponto de controle de redirecionamento

### Aspectos positivos

- rotas centralizadas
- `initialLocation` explícita
- preparação para deep link e redirect
- uso de `MaterialApp.router`

### `AppRoute`

A classe `AppRoute` abstrai `GoRoute` e aplica:

- `Scaffold` padrão
- transição com fade
- parâmetros adicionais para composição futura

Isso reduz repetição, mas precisa ser usado com cuidado. Quanto mais responsabilidades forem colocadas nessa abstração, maior o risco de o roteamento passar a carregar regras de layout que deveriam viver na UI.

### `HandleRedirect`

Existe estrutura para rotas públicas e protegidas, mas no estado atual:

- apenas `home` está explicitamente pública
- `protectedRoutes` está vazia
- o redirecionamento efetivo ainda não protege nada

Isso é importante do ponto de vista técnico: a arquitetura está preparada para auth guard, mas a implementação ainda está incompleta.

## UI e Composição de Widgets

A camada `ui/` está separada em:

- `page/`
- `components/`
- `theme/`

Esse desenho é adequado para Flutter porque:

- incentiva composição
- reduz widgets gigantes
- melhora reaproveitamento
- facilita testes de widgets isolados

O componente `custom_image.dart` mostra atenção a detalhes como:

- cache de imagem
- validação de URL
- placeholders
- fallback visual
- retry

Esse tipo de componente compartilhado é um bom exemplo de abstração visual reutilizável.

## Barrel Files e Convenções de Importação

O projeto usa arquivos agregadores em `lib/util/import/`, como:

- `packages.dart`
- `service.dart`
- `repository.dart`
- `provider.dart`
- `route.dart`
- `domain.dart`

### Vantagens

- reduz verbosidade de imports
- padroniza pontos de entrada
- acelera desenvolvimento

### Riscos

- dificulta rastrear dependências reais
- pode aumentar acoplamento implícito
- facilita importações excessivas
- complica refatorações em projetos grandes

Como prática, barrel files funcionam melhor quando:

- são pequenos e bem segmentados
- não misturam múltiplas camadas sem necessidade
- seguem convenção estável

## Testes

Há pelo menos dois testes em `test/`:

- `run_app_test.dart`
- `profile_bottom_sheet_test.dart`

Eles validam:

- bootstrap mínimo
- renderização de componentes
- integração básica de providers com a árvore de widgets

### Leitura técnica

Existe uma base inicial de testes, mas ainda enxuta.

Para um manual técnico de estrutura, isso indica que a base recomendada para projetos semelhantes deveria evoluir para cobrir:

- testes unitários de providers
- testes unitários de repositórios
- testes de serialização de DTO
- testes de widget para componentes críticos
- testes de navegação

## Assets e Recursos

O `pubspec.yaml` registra:

- `assets/images/png/`
- `assets/data/`

Isso mostra dois usos estruturais relevantes:

- assets visuais
- dados locais mockados

Como padrão técnico, manter dados mockados em `assets/data/` é útil para:

- desenvolvimento desacoplado de backend
- testes manuais
- prototipação funcional

## Práticas Técnicas Positivas Observadas

- bootstrap explícito antes do `runApp`
- DI centralizada
- separação entre domínio, DTO, serviços e UI
- roteamento centralizado
- providers segmentados por responsabilidade
- encapsulamento de persistência
- cliente HTTP próprio com retry e interceptação
- uso de `dart-define` para ambiente
- internacionalização já prevista desde a base
- componentes reutilizáveis na UI

## Pontos de Atenção e Melhorias Recomendadas

### 1. Ausência de camada explícita de casos de uso

Hoje os providers falam diretamente com repositórios. Para regras de negócio mais complexas, vale introduzir uma camada intermediária.

### 2. Dependência declarada sem uso aparente

`dio` está no projeto, mas a implementação atual usa `http`.

### 3. Guardas de rota ainda incompletos

`HandleRedirect` já existe, porém a proteção de rotas ainda não está implementada de fato.

### 4. Service locator com acesso global

É prático, mas pode mascarar dependências e dificultar testes mais granulares.

### 5. Uso de barrel files deve ser controlado

Em times maiores, esse padrão pode prejudicar rastreabilidade.

### 6. Cobertura de testes ainda limitada

A base existe, mas ainda está abaixo do ideal para uma arquitetura que pretende ser referência.

### 7. Inicialização estática de localização

Funciona, mas exige cuidado para não gerar dependência implícita entre bootstrap e consumo de strings.

## Modelo Técnico Recomendado para Aplicativos Flutter Semelhantes

Com base neste projeto, um aplicativo Flutter tecnicamente bem estruturado pode seguir este blueprint:

```text
lib/
├── app/          # composição da aplicação e bootstrap
├── di/           # registro de dependências
├── domain/       # entidades e value objects
├── dto/          # mapeadores de dados externos
├── repository/   # acesso a dados
├── service/      # infraestrutura transversal
├── provider/     # estado da apresentação
├── route/        # roteamento e guards
├── ui/           # páginas, componentes e temas
├── l10n/         # localização
└── util/         # constantes, helpers e ambiente
```

Se houver aumento de complexidade, a próxima evolução natural é:

```text
lib/
├── application/  # use cases, commands, queries
├── domain/
├── infrastructure/
├── presentation/
```

Ou, alternativamente, manter a estrutura atual e modularizar por feature:

```text
lib/
├── features/
│   ├── auth/
│   ├── product/
│   ├── cart/
│   └── checkout/
├── core/
└── app/
```

## Conclusão

Do ponto de vista técnico, o projeto apresenta uma base madura para servir como referência estrutural de aplicativo Flutter, especialmente para times que desejam:

- separação clara de responsabilidades
- bootstrap previsível
- estado simples e compreensível
- navegação centralizada
- infraestrutura desacoplada da UI

Ele não representa uma Clean Architecture rígida, mas sim uma arquitetura em camadas pragmática, suficiente para sustentar boa manutenção e expansão, desde que alguns pontos sejam fortalecidos:

- camada de aplicação ou casos de uso
- guards reais de navegação
- limpeza de dependências
- maior cobertura de testes
- maior explicitude no fluxo de dependências

Como manual técnico-base, a principal lição do projeto é esta:

> um bom aplicativo Flutter não começa pela tela, mas pela definição clara de como inicializa, injeta dependências, organiza dados, controla estado e navega entre contextos de forma previsível.
