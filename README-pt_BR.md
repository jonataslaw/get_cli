###### Idiomas da documentação
| pt_BR - Esse arquivo| [en_EN](https://github.com/jonataslaw/get_cli/blob/master/README.md) |
|-------|-------|

CLI oficial para a estrutura GetX ™.

Esta CLI está em estágio `Beta`, use com cuidado.


```dart
// Para instalar, rode esse comando no terminal: 
pub global activate get_cli 
// ou 
flutter pub global activate get_cli 

// Para criar um projeto de flutter no diretório atual:
// Nota: Por padrão, o nome da pasta será o nome do projeto
// Você pode nomear o projeto com `get create project: my_project`
// Se o nome tiver espaços, use `get create project:" my cool project "`
get create project 

// Para gerar uma estrutura em um projeto existente:
get init 

// Para criar uma Page:
// (Pages tem controller, view, and binding)
// Nota: você pode usar qualquer nome, ex: `get create page:login` 
// Nota: use essa opcão se a estrutura escolhida for Getx_pattern
get create page:home 

// Para criar uma Screen:
// (Screen tem controller, view, and binding)
// Nota: você pode usar qualquer nome, ex: `get create Screen:login` 
// Nota: use essa opcão se a estrutura escolhida for CLEAN (by Arktekko)
get create screen:home 

// Para criar um novo controller em uma pasta específica:
// Observação: você não precisa fazer referência à pasta,
// Getx irá procurar automaticamente pela pasta pessoal
// e adicione seu controlador lá.
get create controller:dialogcontroller on home

// Para criar uma nova view em uma pasta específica:
// Observação: você não precisa fazer referência à pasta,
// Getx irá procurar automaticamente pela pasta pessoal
// e insira seu controlador lá.
get create view:dialogview on home

// Para gerar um arquivo de localização:
// Nota: diretório 'assets/locales' com seus arquivos de tradução em formato json
get generate locales assets/locales

// Para instalar um pacote em seu projeto (dependencies):
get install camera

// Para instalar um pacote dev em seu projeto (dependencies_dev):
get install flutter_launcher_icons --dev

// Para remover um pacote do seu projeto:
get remove http

// Para remover vários pacotes do seu projeto:
get remove http path

// Para atualizar a CLI:
get update
// ou `get upgrade`

// Mostra a versão CLI atual:
get -v 
// ou `get -version`

// Para obter ajudar
get help 
```

## Exemplos
### Exemplos de geração de idioma.

Crie os arquivos de idioma json na pasta assets/locales. <br/>

input: <br/>

pt_BR.json
```json
{
  "buttons": {
    "login": "Entrar",
    "sign_in": "Cadastrar-se",
    "logout": "Sair",
    "sign_in_fb": "Entrar com o Facebook",
    "sign_in_google": "Entar com o Google",
    "sign_in_apple": "Entar com a  Apple"
  }
}
```
en_EN.json
```json
{
  "buttons": {
    "login": "Login",
    "sign_in": "Sign-in",
    "logout": "Logout",
    "sign_in_fb": "Sign-in with Facebook",
    "sign_in_google": "Sign-in with Google",
    "sign_in_apple": "Sign-in with Apple"
  }
}
```

Rode no terminal : 
```dart 
get generate locales assets/locales
```

output: 
```dart 
abstract class AppTranslation {

  static Map<String, Map<String, String>> translations = {
    'en_EN' : Locales.en_EN,
    'pt_BR' : Locales.pt_BR,
  };

}
abstract class LocaleKeys {
  static const buttons_login = 'buttons_login';
  static const buttons_sign_in = 'buttons_sign_in';
  static const buttons_logout = 'buttons_logout';
  static const buttons_sign_in_fb = 'buttons_sign_in_fb';
  static const buttons_sign_in_google = 'buttons_sign_in_google';
  static const buttons_sign_in_apple = 'buttons_sign_in_apple';
}

abstract class Locales {
  
  static const en_EN = {
   'buttons_login': 'Login',
   'buttons_sign_in': 'Sign-in',
   'buttons_logout': 'Logout',
   'buttons_sign_in_fb': 'Sign-in with Facebook',
   'buttons_sign_in_google': 'Sign-in with Google',
   'buttons_sign_in_apple': 'Sign-in with Apple',
  };
  static const pt_BR = {
   'buttons_login': 'Entrar',
   'buttons_sign_in': 'Cadastrar-se',
   'buttons_logout': 'Sair',
   'buttons_sign_in_fb': 'Entrar com o Facebook',
   'buttons_sign_in_google': 'Entar com o Google',
   'buttons_sign_in_apple': 'Entar com a  Apple',
  };

}

```

Agora basta adicionar a seguinte linha em GetMaterialApp:

```dart
    GetMaterialApp(
      ...
      translationsKeys: AppTranslation.translations,
      ...
    )
```

