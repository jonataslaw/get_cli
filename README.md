The official CLI from Getx Framework of Flutter

This CLI is in `Beta` stage, use with caution.

```dart
// to install:
pub global activate get_cli 

// To create a flutter project with the chosen structure from begin:
get create project 

// To create the chosen structure on project:
get init 

// to create a page: Pages have controller, view, and binding
get create page:home // or other name, ex: get create page:login 

// to create a new controller in a specific folder:
get create controller:dialogcontroller on home
// Note: you don't need to point the way, Getx will automatically search for the home folder and insert your controller there.

// to create a new view in a specific folder:
get create view:dialogview on home
// Note: you don't need to point the way, Getx will automatically search for the home folder and insert your controller there.

// to create the route file:
get create route 

// to install package on your project
get install camera

// to remove package on your project
get remove http

// to update CLI 
get update

// to shows the installed version 
get --version 

```

TODO: 
- When creating a controller, automatically insert it into the Binding
- When creating a page, insert it automatically in Routes
- Support for customModels
- Unit tests
- Improve structure
- Added backup
- suggest update whenever the package is updated in pub.dev

## Adding new functions:
- Add the folder where the new files will be created in core / structure (Don't forget to add to replaceAsExpected and toMap)

- Create a sample and insert it in the samples / impl folder (you need to create a class, extend Sample)

- Create the function for creating the class or folders and insert in functions. If the command is for creation, in the create folder, if it is for startup (as a new structure) in init

- Open the create / create.dart file, add your command to the switch, and point to its function.


Ready!