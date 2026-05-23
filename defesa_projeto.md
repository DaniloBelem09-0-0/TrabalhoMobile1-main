# Guia para Defesa do Projeto: Controle de Refeições 🍽️

Este documento foi criado para auxiliar o aluno **Danilo** na defesa do seu projeto individual de Desenvolvimento Mobile (Avaliação A1). Ele resume as escolhas técnicas e como cada requisito obrigatório foi atendido.

---

## 1. Visão Geral do Aplicativo
O aplicativo **Controle de Refeições** resolve o problema de usuários que buscam manter um diário pessoal de experiências gastronômicas. Ele foca na praticidade e no feedback visual imediato, permitindo que o usuário decida rapidamente se vale a pena retornar a um local baseado em avaliações anteriores.

## 2. Defesa Técnica (Conformidade com os Requisitos)

### A. Modelagem POO (Orientação a Objetos)
O projeto utiliza a classe `Meal` (localizada em `lib/models/meal.dart`).
- **Defesa:** "Utilizei uma classe modelo para encapsular os dados da refeição (nome do local, prato, preço, avaliação e observações). Isso garante que os dados trafeguem de forma organizada entre as telas, facilitando futuras implementações como a persistência em banco de dados."

### B. Interface e Layout Moderno
O app utiliza o **Material Design 3** com uma paleta de cores personalizada.
- **Widgets utilizados:** `Scaffold`, `AppBar` customizada, `Column`, `Row`, `Padding` e `Container` para organização espacial.
- **Defesa:** "Priorizei uma UI limpa e gastronômica. Usei `SingleChildScrollView` nas telas de detalhe e cadastro para garantir que o layout seja responsivo e não apresente erros de transbordamento (overflow) quando o teclado é aberto ou em telas menores."

### C. Listagem Dinâmica e Navegação Vertical
- **Widget:** `ListView.builder` na `HomeScreen`.
- **Defesa:** "O histórico de refeições é renderizado dinamicamente via `ListView.builder`. Esta escolha é superior ao `ListView` estático pois otimiza a performance, renderizando apenas os itens visíveis na tela, o que é essencial para escalabilidade."

### D. Componente de Navegação Horizontal (Destaques)
- **Widget:** `PageView.builder` na `HomeScreen`.
- **Defesa:** "Implementei um carrossel de destaques no topo da tela inicial. Ele filtra automaticamente os locais que recebi como favoritos (avaliação 'Voltaria'), proporcionando uma experiência de usuário (UX) premium e intuitiva."

### E. Entrada de Dados e Captura (Comunicação com o Usuário)
- **Componentes:** `TextField` e `TextEditingController`.
- **Defesa:** "Na tela de cadastro, cada campo possui seu próprio `Controller`. Isso me permite capturar e validar os dados em tempo real. Implementei também o `SnackBar` para dar feedback imediato ao usuário quando um item é salvo com sucesso ou quando algum campo obrigatório não é preenchido."

---

## 3. Gestão de Estado e Navegação
- **Estado:** O app utiliza `StatefulWidget` com o método `setState()`.
- **Navegação:** Uso de `Navigator.push` para passagem de parâmetros (enviando o objeto `Meal` para a tela de detalhes) e `Navigator.pop` para retorno de dados.

> [!TIP]
> **Dica para a apresentação:** Durante a demonstração, mostre o processo de adicionar uma nova refeição e como ela aparece imediatamente no topo da lista principal e no carrossel de destaques (se for marcada como 'Voltaria'). Isso prova que o seu gerenciamento de estado (`setState`) está funcionando corretamente.

---

## 4. Evolução do Projeto (Próximos Passos)
Embora os dados atuais sejam mockados conforme solicitado para esta etapa parcial, a estrutura já está preparada para:
1.  **Persistência Local:** Inserção do pacote `sqflite` para salvar os dados permanentemente.
2.  **Imagens Reais:** Substituição de imagens fixas por fotos tiradas pelo próprio usuário (plugin `image_picker`).

---

**Danilo, com este guia, você demonstra que não apenas sabe "fazer" o código, mas entende *o porquê* de ter usado cada componente.**
