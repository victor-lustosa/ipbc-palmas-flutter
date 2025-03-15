
# IPBC Palmas
![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/IPB-banner.png)

Projeto de aplicativo Android e iOS Open Source para a Igreja Presbiteriana Central de Palmas totalmente voluntário, sem fins lucrativos, para fornecer aos membros funcionalidades como: letras das músicas utilizadas nos cultos, histórico de cultos com liturgias, e outras funcionalidades, sendo futuramente um projeto para criar aplicativos para qualquer igreja em várias línguas diferentes.

## Links do Projeto nas Lojas

- [Playstore](https://play.google.com/store/apps/details?id=com.ipbc.ipbc_palmas)
- [Applestore]

## Documentação do Projeto
### Pacotes e plugins usados no projeto

- Gerências de Estado: Bloc Pattern e ChangeNotifier
- Gerenciamento das rotas: Modular
- Injeção de Dependência: Modular
- Databases NoSQL: Hive e Firestore (Brevemente Supabase)
- Análise de Dados: firebase Crashlytics


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

### Google Drive

- [Documentação (Até o Momento) - Google Drive](https://drive.google.com/drive/folders/14hMQTKQDkKlj2iBuQUMvcYcF_1K0i79o?usp=sharing)

### Prototipação

 Design desenvolvido totalmente pela [Product Designer Mayumi Adati](https://www.mayumiadati.work)
- [Prototipação do Projeto - Figma](https://www.figma.com/file/ynwf4IxDmaymB1RfynJdow/IPB-app-0.0.4?t=fiow2g3IIoUpaiY1-0)

### Arquitetura

![alt text](https://github.com/victor-lustosa/ipbc-palmas-flutter/blob/main/docs/arquitetura-frontend-ipb.png)

