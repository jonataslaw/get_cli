###### Documentation languages
| [pt_BR](https://github.com/jonataslaw/get_cli/blob/master/README-pt_BR.md) | en_EN - this file |
| -------------------------------------------------------------------------- | ----------------- |

Official CLI for the GetX™ framework.

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
// and insert your view there.
get create view:dialogview on home

// To create a new provider in a specific folder:
get create provider:user on home

// To generate a localization file:
// Note: 'assets/locales' directory with your translation files in json format
get generate locales assets/locales

// To generate a class model:
// Note: 'assets/models/user.json' path of your template file in json format
// Note: on  == folder output file
// Getx will automatically search for the home folder
// and insert your view there.
get generate model on home with assets/models/user.json

//to generate the model without the provider
get generate model on home with assets/models/user.json --skipProvider

//Note: the URL must return a json format
get generate model on home from https://api.github.com/users/CpdnCristiano

// To install a package in your project (dependencies):
get install camera

// To install several packages from your project:
get install http path camera 

// To install a package with specific version:
get install path:1.6.4

// You can also specify several packages with version numbers

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

// For help
get help
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
### Generate model example

Create the json model file in the assets/models/user.json<br/>

input: <br/>
```json
{
  "name": "",
  "age": 0,
  "friends": ["", ""]
}
 ```
Run : 
```dart 
get generate model on home with assets/models/user.json
```

output: 
```dart
class User {
  String name;
  int age;
  List<String> friends;

  User({this.name, this.age, this.friends});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    friends = json['friends'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['friends'] = this.friends;
    return data;
  }
}

```


TODO: 
- Support for customModels
- Include unit tests
- Improve generated structure
- Add a backup system

