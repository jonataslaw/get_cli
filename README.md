Official CLI for the GetX™ framework.

This CLI is in `Beta` stage, use with caution.

```dart
// To install:
pub global activate get_cli 

// To create a flutter project in the current directory:
// Note: By default it will take the folder's name as project name
// You can name the project with `get create project:my_project`
// If the name has spaces use `get create project:"my cool project"`
get create project 

// To generate the chosen structure on an existing project:
get init 

// To create a page: 
// (Pages have controller, view, and binding)
// Note: you can use any name, ex: `get create page:login` 
get create page:home 

// To create a new controller in a specific folder:
// Note: you don't need to reference the folder, 
// Getx will search automatically for the home folder
// and add your controller there.
get create controller:dialogcontroller on home

// To create a new view in a specific folder:
// Note: you don't need to reference the folder,
// Getx will automatically search for the home folder
// and insert your controller there.
get create view:dialogview on home

// To create the route file:
get create route 

// To generate a localization file:
// Note: 'assets/locales' directory with your translation files in json format
get generate locales assets/locales

// To install a package in your project (dependencies):
get install camera

// To install a dev package in your project (dependencies_dev): 
get install flutter_launcher_icons --dev

// To remove a package from your project:
get remove http

// To remove several packages from your project:
get remove http path

// To update CLI: 
get update
// or `get upgrade`

// Shows the current CLI version: 
get -v 
// or `get -version`
```

## Examples
### Generate Locates example

create the json language files in the assets/locales folder.<br/>

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

Run : 
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

now just add the line in GetMaterialApp
```dart

    GetMaterialApp(
      ...
      translationsKeys: AppTranslation.translations,
      ...
    )
```

TODO: 
- When creating a controller, automatically insert it into the Binding
- When creating a page, insert it automatically in Routes
- Support for customModels
- Include unit tests
- Improve generated structure
- Add a backup system
- Suggest updates when the package is updated in pub.dev
- Add help in CLI

## Adding new functions:
- Add the folder where the new files will be created in core/structure. Map's key is the command, the value is the path.

- Create a sample and insert it in the samples/impl folder (you need to create a class that extends Sample)

- Create the function for generating the class (or folders) and insert in `functions`. 
If the command is meant for *code generation*, use the `created` folder, 
if the command is for *startup* (new structure), use the `init` folder.

- Open the file `create/create.dart`, add your command to the switch and validation, then point to its function.

Ready!
