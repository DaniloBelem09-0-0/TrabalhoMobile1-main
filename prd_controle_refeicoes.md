# Product Requirements Document (PRD): Controle de Refeições

## 1. Visão Geral do Produto
O **Controle de Refeições** é um aplicativo mobile focado em registrar e classificar as experiências gastronômicas dos usuários em ambientes comerciais (restaurantes, lanchonetes, padarias, etc.). O objetivo principal é servir como um diário de alimentação fora de casa, ajudando o usuário a lembrar onde comeu, o que achou da experiência e, o mais importante, se voltaria ou não ao estabelecimento.

## 2. Objetivos e Escopo Principal
- Permitir o registro rápido de uma refeição.
- Classificar os locais visitados com critérios claros de avaliação.
- Fornecer um histórico navegável das refeições passadas.
- **Fase atual:** O foco é entregar uma interface finalizada, com navegação completa, uso de listas/páginas para exibição de dados (mesmo que mockados iniciais) e formulários prontos para capturar estados, sem obrigatoriedade de persistência em banco de dados ou backend neste momento inicial.

## 3. Critérios de Avaliação e Classificação dos Locais
O usuário deve indicar se retornaria ao local. Para isso, o critério de classificação baseia-se em uma escala de satisfação atrelada a elementos visuais (ex: ícones, emojis ou botões de seleção):

*   **Verde / Voltaria com certeza! 😄:** Comida excelente, ótimo atendimento e preço justo. Superou ou atendeu plenamente as expectativas.
*   **Amarelo / Talvez 🤔:** A experiência teve pontos positivos e negativos (ex: comida boa, mas caro, ou ambiente barulhento). Vale uma segunda chance testando outros pratos ou em dias com menos movimento.
*   **Vermelho / Não voltaria 😞:** Experiência negativa no geral (comida ruim, mal atendimento, ou local em condições ruins). 

## 4. Requisitos Técnico-Funcionais (Checklist da Entrega)

Para a entrega técnica deste projeto, os seguintes critérios devem ser impreterivelmente alcançados:

### 4.1. Interface e Layout
- O layout de todas as telas requeridas deve estar construído e estruturado.
- **Navegação (Rotas):** A navegação e trânsito entre as telas precisa estar fluída e funcionando (inclusive passando parâmetros entre elas, caso necessário, que podem ser refinados no futuro).

### 4.2. Renderização de Listas e Mocks
- **ListView.builder:** Obrigatório o uso para exibir o histórico de locais avaliados, renderizando os dados, mesmo que sejam de uma lista estática/mockada no código.
- **PageView.builder:** Obrigatório o uso para exibição paginada. Pode ser aplicado para (por exemplo) exibir os 'Locais Destaques' no topo da home ou para fazer a paginação vertical/horizontal entre categorias de refeições.
- A estrutura de dados gerada deve ser consistente, para permitir a posterior facilidade ao incorporar o banco de dados.

### 4.3. Captura de Dados (Formulários)
- Telas de registro de nova refeição devem conter os respectivos **TextFields** para (ex: Nome do Estabelecimento, Prato, Opinião, etc.).
- Os **Controllers (TextEditingControllers)** estarão devidamente posicionados e instanciados para os campos de texto.
- Os formulários devem se demonstrar capazes de capturar os dados informados, mesmo sem serem efetivamente salvos no banco, comprovando através de logs no console ou atualizando o estado do componente temporariamente.
- A estrutura geral deve ser **navegável e testável**.

## 5. Arquitetura de Telas Sugerida (User Flow)

1.  **Home Page:**
    *   *Topo:* Um carrossel usando `PageView.builder` mostrando algumas dicas de favoritos.
    *   *Centro:* Uma lista construída com `ListView.builder` exibindo os locais visitados com seu símbolo de classificação (Cor ou ícone correspondente).
    *   *Ação:* Um Floating Action Button direciona o usuário para a rotina de "Nova Refeição".
2.  **Cadastro de Refeição:**
    *   Campos com `TextFields` vinculados aos `Controllers` capturando dados.
    *   Seletor de avaliação (Voltaria, Talvez, Não Voltaria).
    *   Ação de conclusão (Salvar) que (nesta etapa) envia os dados capturados mockados para visualização ou log no console, e retorna o usuário à tela anterior.
3.  **Detalhe da Refeição (Opcional para a lógica pesada, mas obrigatória na navegação):**
    *   Traz as informações registradas completas passadas como argumento na rota.
