This CLI is in alpha stage, use with caution.

```dart
// to install:
pub global activate get_cli 


// To start a project with the chosen structure:
get init 

// to create a page: Pages have controller, view, and binding
get create page:home //get create page:login 

// to create a new controller in a specific folder:
get create controller:dialogcontroller on home
// Note: you don't need to point the way, Getx will automatically search for the home folder and insert your controller there.

// to create a new view in a specific folder:
get create view:dialogview on home
// Note: you don't need to point the way, Getx will automatically search for the home folder and insert your controller there.

// to create the route file:
get create route 

```

TODO: 
- When creating a controller, automatically insert it into the Binding
- When creating a page, insert it automatically in Routes
- Insert the `upgrade`, `install`, `remove` options in the cli
- Support for customModels
- Unit tests


## Adding new functions:
- Add the folder where the new files will be created in core / structure (Don't forget to add to replaceAsExpected and toMap)

- Create a sample and insert it in the samples / impl folder (you need to create a class, extend Sample)

- Create the function for creating the class or folders and insert in functions. If the command is for creation, in the create folder, if it is for startup (as a new structure) in init

- Open the create / create.dart file, add your command to the switch, and point to its function.


Ready!