# Gerenciador Empresarial

## Descrição

Este é um aplicativo desenvolvido em Flutter para gestão empresarial. Ele permite o cadastro de clientes, produtos, unidades de medida, vendas e um módulo financeiro para acompanhar os registros das vendas.

## Tecnologias Utilizadas

- **Flutter** - Framework para desenvolvimento multiplataforma.
- **Dart** - Linguagem de programação utilizada pelo Flutter.
- **Provider** - Gerenciamento de estado e injeção de dependência. ([Instruções](https://pub.dev/packages/provider))
- **go_router** - Gerenciamento de rotas dinâmicas e aninhadas. ([Instruções](https://pub.dev/packages/go_router))

## Estrutura do Projeto

O projeto está organizado em módulos dentro da pasta `lib/modules`, seguindo a estrutura:

```
lib/
│── modules/
│   ├── customer/
│       ├── components/
│       ├── models/
│       ├── providers/
│       ├── repositories/
│       ├── screens/
│── routes/ (Rotas da aplicação)
│── themes/ (Configuração de temas, cores e estilos de texto)
│── utils/ (Funções auxiliares)
│── app/ (Configurações globais, services e componentes globais)
```

## Funcionalidades

- Cadastro e gerenciamento de clientes.
- Cadastro e gerenciamento de produtos e unidades de medida.
- Registro e controle de vendas.
- Módulo financeiro para monitoramento de vendas.

## Fluxo de Uso

1. **Login** - O usuário realiza a autenticação no sistema.
2. **Cadastrar um Cliente** - O usuário cadastra um cliente para associar às vendas.
3. **Cadastrar um Produto** - Registra os produtos que serão comercializados.
4. **Cadastrar uma Unidade para o Produto** - Define unidades de medida para os produtos.
5. **Cadastrar uma Venda** - Registra uma nova venda associando clientes e produtos.
6. **Visualizar a Venda no Financeiro** - O usuário pode acessar o módulo financeiro para visualizar as vendas registradas.

## Roadmap

- [ ] Implementar módulo de vendas
- [ ] Implementar módulo financeiro
- [ ] Exportação de vendas e relatório financeiro em PDF
- [ ] Implementar autenticação de usuário
- [ ] Light mode

## Requisitos

- Flutter instalado ([Instruções](https://flutter.dev/docs/get-started/install))
- Visual Studio Code (VS Code) ou Android Studio
- Emulador ou dispositivo físico configurado

## Como Rodar o Projeto no VS Code

Siga os passos abaixo para rodar o projeto no Visual Studio Code:

1. **Instale o Flutter e o Dart:**

   - Baixe e instale o [Flutter SDK](https://docs.flutter.dev/get-started/install).
   - Configure o Flutter no PATH do sistema.
   - Execute `flutter doctor` para verificar se a instalação está correta.

2. **Clone este repositório:**

   ```sh
   git clone https://github.com/vinihellmann/geapp
   cd geapp
   ```

3. **Instale as dependências do projeto:**

   ```sh
   flutter pub get
   ```

4. **Abra o projeto no VS Code:**

   - No terminal, rode:
     ```sh
     code .
     ```
   - Ou abra manualmente pelo VS Code.

5. **Selecione um dispositivo para execução:**

   - Conecte um dispositivo físico via USB e habilite a depuração USB.
   - Ou abra um emulador no Android Studio antes de rodar o app.

6. **Inicie o projeto:**

   ```sh
   flutter run
   ```

   - Caso queira rodar em um dispositivo específico, liste os dispositivos disponíveis com:
     ```sh
     flutter devices
     ```
   - E depois rode o app informando o ID do dispositivo:
     ```sh
     flutter run -d <device-id>
     ```

7. **Para rodar no modo debug dentro do VS Code:**
   - Pressione `F5` ou clique no botão "Run and Debug" no VS Code.

Agora o aplicativo estará rodando e pronto para uso!

## Contribuição

Se deseja contribuir, faça um fork do repositório, crie uma branch, faça suas modificações e envie um pull request.

## Licença

Este projeto está licenciado sob a MIT License.
