# Especificação de Trabalho do Projeto

## Objetivo

Este documento define como o time de desenvolvimento deve trabalhar neste projeto Flutter para garantir:

- consistência arquitetural
- previsibilidade de implementação
- facilidade de manutenção
- menor acoplamento entre camadas
- evolução segura do produto
- alinhamento entre design, dados, estado e UI

Este guia é normativo para o projeto atual. Em caso de dúvida entre "fazer rápido" e "fazer aderente ao padrão", a regra é seguir este documento.

## Contexto do Projeto

O projeto implementa uma base Flutter para o produto Galácticos Club, com foco atual em:

- arquitetura em camadas
- UI modular e reaproveitável
- uso de design tokens centralizados
- simulação de backend via JSON mockado
- preparação para substituição futura por APIs reais

O projeto já adota um fluxo principal semelhante a:

`UI -> Provider -> Repository -> Service -> DTO -> Domain`

Esse fluxo deve ser preservado.

## Princípios de Engenharia

As decisões técnicas do projeto devem seguir os princípios abaixo:

- UI não conhece infraestrutura.
- Provider não conhece JSON bruto.
- Repository não deve conter regra visual.
- Service é a fronteira com fonte de dados.
- DTO traduz transporte para domínio.
- Domain representa o modelo interno do app.
- Theme e design tokens concentram decisões visuais.
- Dados exibidos em tela devem ser preferencialmente dirigidos por payload.
- Componentes devem ser pequenos, composáveis e previsíveis.
- Hardcode funcional em tela deve ser evitado.

## Estrutura Oficial de Pastas

Estrutura base em `lib/`:

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

Responsável pela composição principal da aplicação.

- `app.dart`: configura `MaterialApp.router`
- `bootstrap.dart`: inicialização global antes do `runApp`

Regra:

- nada de regra de negócio aqui
- nada de acesso direto a fonte de dados aqui

### `di/`

Responsável pelo wiring técnico das dependências.

Exemplos de registro:

- serviços
- repositórios
- persistência
- localizações
- factories

Regras:

- toda dependência compartilhada deve ser registrada em `di.dart`
- não criar instâncias soltas em widgets ou providers se elas puderem ser injetadas
- falhas de inicialização de infraestrutura devem ser tratadas com segurança sempre que possível

### `domain/`

Contém o modelo interno do app.

Exemplos atuais:

- `dashboard_overview.dart`
- `lesson.dart`
- `match_invite.dart`
- `quick_access_item.dart`
- `home_messages.dart`
- `home_sections.dart`
- `home_ui_labels.dart`

Regras:

- classes de domínio não devem importar Flutter
- classes de domínio não devem conhecer JSON
- classes de domínio não devem conhecer `BuildContext`, tema ou widgets

### `dto/`

Contém adaptação entre payload externo e domínio interno.

Exemplo atual:

- `dashboard_dto.dart`

Regras:

- parsing de JSON deve ficar em DTO
- mapeamento de chaves externas deve ficar em DTO
- UI nunca deve interpretar mapa bruto vindo de service

### `provider/`

Camada de estado da apresentação.

Exemplos:

- `home_provider.dart`
- `theme_provider.dart`
- `locale_provider.dart`
- `register_provider.dart`

Regras:

- provider coordena carregamento, erro, loading e seleção de estado da tela
- provider não deve carregar asset, JSON ou fazer parse direto
- provider conversa com repository, não com service bruto

### `repository/`

Camada de orquestração de dados para a aplicação.

Exemplo:

- `home_repository.dart`

Regras:

- repository conhece services e DTOs
- repository entrega domínio pronto para provider
- repository não deve conter layout, cores, widgets ou lógica visual

### `service/`

Camada de infraestrutura e acesso a fonte de dados.

Subáreas atuais:

- `home/`
- `http/`
- `api/`
- `persistence/`
- `localization/`

Regras:

- service é responsável por carregar payload bruto
- service mockado pode ler `assets/data/*.json`
- service real poderá consumir HTTP futuramente sem quebrar provider nem UI

### `route/`

Centraliza navegação e catálogo de rotas com `go_router`.

Regras:

- rotas devem ser declaradas na camada de roteamento
- páginas não devem criar rotas de forma ad hoc
- redirecionamento futuro deve passar pelo mecanismo centralizado do router

### `ui/`

Camada visual do projeto.

Subdivisões:

- `components/`: widgets reutilizáveis
- `page/`: telas e composição por página
- `theme/`: tema e tokens

Regras:

- páginas devem ser compostas por widgets menores
- componentes reutilizáveis ficam em `components/`
- tema e tokens não devem ser duplicados dentro dos widgets

### `util/`

Suporte transversal.

Contém:

- constantes
- locale
- environment
- barrel files

Regras:

- `util/` não deve virar depósito genérico
- qualquer helper novo deve ter responsabilidade clara
- se algo representa regra de domínio, não pertence a `util/`

## Fluxo de Dados Oficial

O fluxo de dados adotado neste projeto é:

`assets/data ou API -> Service -> Repository -> DTO -> Domain -> Provider -> UI`

### Regra prática

Ao implementar uma nova funcionalidade orientada a dados:

1. definir o domínio
2. definir o payload esperado
3. criar ou ajustar o service
4. adaptar o DTO
5. expor no repository
6. consumir no provider
7. renderizar na UI

### O que não fazer

- widget lendo JSON diretamente
- provider fazendo `rootBundle.loadString`
- widget mapeando `Map<String, dynamic>` cru
- repository retornando JSON cru para UI

## Regra de Mock e Preparação para API Real

Durante a fase atual, dados mockados em `assets/data/` são a fonte oficial para simular backend.

Exemplo atual:

- `assets/data/home_feed.json`

Regras:

- sempre que possível, novos conteúdos visuais devem entrar no JSON mockado
- labels, mensagens de ação, títulos de seção e conteúdo de cards devem preferencialmente vir do payload
- hardcodes funcionais em widgets devem ser removidos
- fallback técnico pode existir, mas deve ficar centralizado fora da UI de negócio

### Definição de hardcode funcional

É qualquer texto, valor, regra de exibição ou comportamento de conteúdo embutido diretamente na tela e que deveria ser configurável por payload, domínio ou constante central.

Exemplos a evitar:

- título de card dentro do widget
- label da navegação escrita diretamente no componente
- mensagem de snackbar escrita diretamente na página
- prefixos e textos de ranking embutidos no widget

### Exceções aceitáveis

Os itens abaixo podem permanecer como constantes técnicas:

- ícones do Material
- espaçamentos estruturais definidos em tokens
- valores internos de composição visual que não representam conteúdo de negócio
- mensagens técnicas centralizadas em constantes do app

## Padrão para UI

### Composição

Toda página deve ser decomposta em widgets pequenos.

No caso da home, a organização por arquivos especializados é o padrão esperado:

- `home_content.dart`
- `home_top_widgets.dart`
- `home_cards_widgets.dart`
- `home_dashboard_widgets.dart`
- `home_quick_access_widgets.dart`

### Regras de UI

- evitar widgets gigantes com múltiplas responsabilidades
- extrair seções coesas para arquivos próprios
- manter nomenclatura previsível
- preferir composição a herança
- preferir widgets puros e previsíveis

### Responsabilidade visual

Os widgets devem:

- renderizar
- reagir a estado pronto
- disparar callbacks

Os widgets não devem:

- buscar dados
- interpretar payload bruto
- inicializar dependências
- decidir regras de fonte de dados

## Design System e Tokens

O projeto adota design tokens centralizados em `ui/theme/app_theme.dart`.

Categorias atuais incluem:

- `AppPalette`
- `AppOpacity`
- `AppSpacing`
- `AppRadius`
- `AppStroke`
- `AppBlur`
- `AppShadow`
- `AppIconSize`
- `AppFontSize`
- `AppLetterSpacing`
- `AppSize`
- `AppChartHeights`
- `AppHeroLayout`
- `AppInsets`

### Regra obrigatória

Não introduzir números mágicos em componentes se o valor puder ser representado por token.

### Antes de criar um valor novo

Verificar:

- já existe token equivalente
- o valor pertence a cor, spacing, radius, font size, opacity, blur, icon size ou dimensão estrutural
- o valor deve entrar no design system

### Quando criar novo token

Criar novo token quando:

- o valor se repete
- o valor tem semântica visual clara
- o valor participa do padrão visual do produto
- o valor ajudará a padronizar futuras telas

### Quando não criar novo token

Evitar criar token quando:

- o valor é pontual e estritamente interno de um cálculo local
- o valor não tem significado reutilizável
- o token só aumentaria ruído sem ganho real

## Convenções de Nome

### Arquivos

- usar `snake_case.dart`
- nomes devem refletir a responsabilidade
- evitar nomes genéricos como `helper.dart`, `utils.dart`, `common.dart`

### Classes

- classes de domínio com nome do conceito de negócio
- widgets com nome visual claro
- interfaces de service com sufixo `Interface` se esse já for o padrão adotado

### Métodos

- preferir nomes verbais e objetivos
- `fetch`, `load`, `get`, `map`, `toDomain`, `selectTab`

## Estado e Tratamento de Erro

### Provider

O provider deve controlar:

- carregamento
- erro
- estado atual da tela
- interações de seleção simples

### Mensagens de erro

Mensagens técnicas ou genéricas devem ficar centralizadas.

Exemplo atual:

- `AppConstants`

Regra:

- não espalhar mensagens de erro repetidas em múltiplas telas
- se a mensagem for de conteúdo da feature, preferir payload ou camada apropriada

## Persistência Local

Persistência leve usa `shared_preferences`.

Regras:

- uso centralizado via `PersistenceService`
- inicialização protegida contra falhas de plugin
- UI não deve acessar `SharedPreferences` diretamente

## Internacionalização

Internacionalização oficial do projeto usa:

- `flutter_localizations`
- `intl`
- arquivos em `lib/l10n/`

Regras:

- evitar dependências redundantes de localização
- textos do app que pertençam ao produto devem ser internacionalizáveis quando fizer sentido
- não criar solução paralela fora de `l10n` sem necessidade real

## Roteamento

Rotas devem ser definidas centralmente.

Regras:

- nomes de rota previsíveis
- navegação concentrada no `go_router`
- lógica de proteção e redirect em pontos centralizados

## Regras para Assets

### Imagens

Assets permanentes devem estar em:

- `assets/images/prototype/`
- `assets/images/png/`

### Dados mockados

Payloads mockados devem estar em:

- `assets/data/`

### Regra

Qualquer novo asset precisa:

- estar declarado no `pubspec.yaml`
- seguir organização previsível
- ter nome consistente

## Regras para Quick Access e Conteúdos Variantes

Hoje `quick_access` ainda usa um modelo flexível orientado por `Map<String, dynamic>` em `content`.

Isso é aceitável como etapa intermediária, mas o padrão-alvo é:

- reduzir mapas dinâmicos
- criar tipagem por variante
- aproximar o mock da futura API real

### Direção recomendada

Se a complexidade de `quick_access` crescer:

1. criar subtipos por tipo de card
2. criar DTOs por variante
3. reduzir casting manual na UI
4. mover interpretação de forma para camadas de dados

## Critérios para Novas Features

Toda nova feature deve responder:

- qual domínio ela introduz
- qual provider controla o estado
- qual repository entrega os dados
- qual service consome a fonte
- qual payload mockado ou endpoint real a alimenta
- quais tokens de design ela reutiliza
- quais componentes podem ser reaproveitados

## Checklist de Implementação

Antes de considerar uma tarefa pronta, verificar:

- arquitetura respeitada
- sem acesso direto a JSON na UI
- sem regra visual no repository
- sem números mágicos desnecessários
- sem hardcode funcional disperso na tela
- assets declarados no `pubspec.yaml`
- provider com loading e erro adequados
- nomes consistentes
- widgets modulados
- tokens reaproveitados

## Checklist de Revisão de Código

Em revisão, observar:

- a responsabilidade está na camada certa
- o código novo segue o fluxo oficial de dados
- houve criação indevida de acoplamento
- o widget ficou grande demais
- há casting dinâmico excessivo na UI
- houve duplicação de token, cor ou espaçamento
- textos de negócio foram colocados diretamente em widget
- a solução prepara ou dificulta integração futura com API real

## Padrão para Pull Requests

Toda entrega idealmente deve deixar claro:

- objetivo da mudança
- camadas impactadas
- motivo técnico
- impacto visual
- impacto em dados
- follow-ups pendentes

Formato sugerido:

```text
Resumo
- O que foi feito

Arquitetura
- Quais camadas foram alteradas

UI
- Quais componentes ou páginas foram afetados

Dados
- Quais payloads, DTOs, services ou repositories mudaram

Pendências
- O que fica para próxima etapa
```

## Regras de Evolução

Ao evoluir o projeto:

- preferir refactor incremental
- evitar reescrever camadas sem necessidade
- preservar contratos entre provider, repository e service
- introduzir novas abstrações apenas quando houver ganho real
- registrar decisões importantes em documentação

## Anti-padrões Proibidos

Não fazer:

- widget lendo asset JSON
- lógica de negócio em `build()`
- `BuildContext` entrando em domínio ou repository
- textos de negócio espalhados em múltiplos widgets
- criar tema paralelo fora de `app_theme.dart`
- criar utilitário genérico sem fronteira clara
- usar valores visuais arbitrários sem consultar tokens
- misturar carregamento de dados com composição visual

## Decisão Atual do Projeto

No estado atual do projeto, valem as seguintes decisões:

- a home é data-driven
- dados da home devem vir do fluxo `service -> repository -> provider -> UI`
- design tokens são obrigatórios para valores visuais relevantes
- componentes da home devem permanecer modularizados
- mocks em `assets/data` são a referência até a chegada da API real
- fallbacks técnicos devem ser centralizados e não espalhados pela UI

## Quando Atualizar Este Documento

Este documento deve ser atualizado quando houver mudança em:

- arquitetura principal
- padrão de estado
- convenções de UI
- estratégia de dados
- design system
- política de mocks
- fluxo de build e integração nativa

## Conclusão

Este projeto não deve crescer como uma coleção de telas independentes. Ele deve evoluir como um sistema coerente, com responsabilidades claras, dados bem definidos e UI orientada por padrões.

O objetivo deste guia é garantir que qualquer desenvolvedor do time consiga:

- entender rapidamente como o projeto funciona
- implementar novas features sem quebrar a arquitetura
- manter consistência visual e técnica
- preparar o app para integração real com backend
