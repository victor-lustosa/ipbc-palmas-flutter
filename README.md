
# Igreja Presbiteriana Central de Palmas

## Aplicativo

Projeto de aplicativo Android e iOS, e Website Open Source para a Igreja Presbiteriana Central de Palmas totalmente voluntário, sem fins lucrativos, para fornecer aos membros funcionalidades como: letras das músicas utilizadas nos cultos, histórico de cultos com liturgias, e outras funcionalidades, sendo futuramente um projeto para criar aplicativos para qualquer igreja em várias línguas diferentes.

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/IPB-banner.png)

## Design do Aplicativo feito no Figma

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/ipbc-mobile-design.png)

## Website no ar

[Link para o site](https://www.ipcpalmas.org.br)

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/ipbc-web.png)

## Design do Website feito no Figma

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/ipbc-web-design.png)

### Google Drive

- [Documentação (Até o Momento) - Google Drive](https://drive.google.com/drive/folders/14hMQTKQDkKlj2iBuQUMvcYcF_1K0i79o?usp=sharing)

### Prototipação

Design desenvolvido totalmente pela [Product Designer Mayumi Adati](https://www.mayumiadati.work)
- [Prototipação do Projeto - Figma](https://www.figma.com/file/ynwf4IxDmaymB1RfynJdow/IPB-app-0.0.4?t=fiow2g3IIoUpaiY1-0)

### Arquitetura

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/arquitetura-frontend-ipb.png)

## Links do Aplicativo nas Lojas

- [Playstore](https://play.google.com/store/apps/details?id=com.ipbc.ipbc_palmas)
- [Applestore]

## Documentação do Projeto

### Descrições técnicas e pacotes usados no projeto

- Abordagens De Engenharia de Softwares Aplicadas ao Projeto: Clean Architecture, Design Patterns, SOLID, Clean Code;
- Gerências de Estado: Bloc Pattern, ChangeNotifier/ValueNotifier e SetState;
- Gerenciamento das rotas: Modular e Rotas nativas para Nested Navigation;
- Injeção de Dependência: Modular (Anteriormente Provider);
- Autenticação: Supabase Authentication (Anteriormente Firebase Authentication);
- Databases NoSQL e SQL: Isar e Supabase Database, e Supabase Storage(Anteriormente Hive e Firebase Firestore, e Storage);
- Análise de Dados: firebase Crashlytics;
- Testes Unitários: Mocktail;
- DevOps: Kanban (Notion), github Actions, Git/Gitflow;
- Monorepo: Melos;

### Execução
---

> **Atenção**
> Verifique a versão do Flutter e do Dart, Flutter ^ 3.24.x e Dart ^ 3.5.x, porque algumas classes possuem dependências de novas versões.

```bash
$ flutter pub get
$ flutter run lib/main.dart
```
> Para gerar os models do Isar, rode o comando a baixo.

```bash
$ dart run build_runner build  
```
> Quando tiver que tirar um arquivo do git do projeto, utilize o comando a baixo

```bash
$ git rm --cached nome_do_arquivo
```


