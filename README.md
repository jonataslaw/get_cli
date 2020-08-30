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
