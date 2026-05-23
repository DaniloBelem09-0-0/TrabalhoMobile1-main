# GourmetLog - Projeto A1

**Aluno:** Danilo
**Tema:** Controle de refeições (Registro de locais comerciais)

## Descrição do Aplicativo
O **GourmetLog** é um aplicativo desenvolvido para o controle pessoal de experiências gastronômicas. Ele permite que o usuário registre onde comeu, o que consumiu, o valor pago e, o mais importante, se a experiência foi positiva o suficiente para um retorno futuro.

## Estrutura do Projeto (5 Telas)
Para atender e superar os requisitos da Avaliação A1, o projeto conta com as seguintes telas:
1.  **Onboarding:** Tela de boas-vindas com `PageView.builder` apresentando o app.
2.  **Home (Dashboard):** Tela principal com resumo de atividades, destaques dinâmicos (`PageView.builder`) e histórico geral.
3.  **Lista de Refeições:** Listagem dinâmica (`ListView.builder`) de todos os registros.
4.  **Detalhes da Refeição:** Visualização completa de uma experiência específica.
5.  **Perfil:** Espaço do usuário para gestão de dados e configurações.

## Funcionalidades e Recursos Técnicos
- **Persistência de Dados Local:** Implementação total de **SQLite** usando o pacote `sqflite` para armazenamento permanente.
- **Listagem Dinâmica:** Uso de `ListView.builder` para renderização eficiente do histórico.
- **Navegação Horizontal:** Uso de `PageView.builder` tanto no Onboarding quanto no carrossel de destaques na Home.
- **Entrada de Dados:** Formulários completos com `TextFields` e `TextEditingControllers`.
- **Gerenciamento de Estado:** Uso de `StatefulWidget` e `setState` para atualizações em tempo real.
- **Feedback Visual:** Implementação de `SnackBar` para confirmação de salvamento, edição e exclusão.
- **Design Moderno:** Utilização de Material Design 3, Google Fonts (Outfit e Inter) e uma paleta de cores harmoniosa baseada em tons de verde esmeralda.

## Como Executar
1. Certifique-se de ter o Flutter instalado.
2. Execute `flutter pub get` para instalar as dependências (`sqflite`, `path`, `google_fonts`).
3. Execute `flutter run` no seu dispositivo ou emulador.

---
*Desenvolvido para a disciplina de Desenvolvimento de Aplicativo Mobile.*
