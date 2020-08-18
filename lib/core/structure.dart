import 'dart:io';

/// Global defaultStructure
Structure defaultStructure = Structure();

/// You able to create a your own structure with this class
/// Just create a new instance an pass it to [Generator]
class Structure {
  /// Path of the pages dir for example: 'lib/pages/'
  String pagesPath;

  /// Path of the widgets dir for example: 'lib/widgets/'
  String widgetsPath;

  /// Path of the main dir for example: 'lib/'
  String mainPath;

  /// Path of the routes dir for example: 'lib/routes/'
  String routePath;

  /// Path of the models dir for example: 'lib/models/'
  String modelsPath;

  /// Path of the repositories dir for example: 'lib/repositories/'
  String repositoriesPath;

  /// Path of the controllers dir for example: 'lib/controllers/'
  String controllersPath;

  /// Path of the view dir for example: 'lib/view/'
  String viewsPath;

  Structure({
    this.pagesPath = 'lib/pages/',
    this.widgetsPath = 'lib/widgets/',
    this.modelsPath = 'lib/models/',
    this.repositoriesPath = 'lib/repositories/',
    this.mainPath = 'lib/',
    this.routePath = 'lib/routes/',
    this.controllersPath = 'controllers/',
    this.viewsPath = 'views/',
  })  : assert(pagesPath != null),
        assert(widgetsPath != null),
        assert(modelsPath != null),
        assert(repositoriesPath != null),
        assert(controllersPath != null) {
    mainPath = replaceAsExpected(path: mainPath);
    routePath = replaceAsExpected(path: routePath);
    pagesPath = replaceAsExpected(path: pagesPath);
    widgetsPath = replaceAsExpected(path: widgetsPath);
    modelsPath = replaceAsExpected(path: modelsPath);
    repositoriesPath = replaceAsExpected(path: repositoriesPath);
    controllersPath = replaceAsExpected(path: controllersPath);
    viewsPath = replaceAsExpected(path: viewsPath);
  }

  Map<String, String> toMap() => {
        'page': pagesPath,
        'widget': widgetsPath,
        'model': modelsPath,
        'init': mainPath,
        'route': routePath,
        'repository': repositoriesPath,
        'controller': controllersPath,
        'view': viewsPath,
      };

  /// Get file paths with key such as: page, widget, repository, model and more...
  String getPathByKey(String key) {
    return toMap()[key];
  }

  static String replaceAsExpected({String path, String replaceChar}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }

  static String getPathWithName(String firstPath, String secondPath,
      {bool createWithWrappedFolder = false}) {
    String betweenPaths;
    if (Platform.isWindows) {
      betweenPaths = "\\\\";
    } else if (Platform.isMacOS || Platform.isLinux) {
      betweenPaths = "/";
    }
    if (betweenPaths.isNotEmpty) {
      if (createWithWrappedFolder) {
        return firstPath +
            betweenPaths +
            secondPath +
            betweenPaths +
            secondPath;
      } else {
        return firstPath + betweenPaths + secondPath;
      }
    }
    return null;
  }
}
