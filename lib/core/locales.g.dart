// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': Locales.en,
    'pt_BR': Locales.pt_BR,
  };
}

abstract class LocaleKeys {
  static const error_failed_to_connect = 'error_failed_to_connect';
  static const error_no_valid_file_or_url = 'error_no_valid_file_or_url';
  static const error_unnecessary_parameter = 'error_unnecessary_parameter';
  static const error_unnecessary_parameter_plural =
      'error_unnecessary_parameter_plural';
  static const error_nonexistent_directory = 'error_nonexistent_directory';
  static const error_empty_directory = 'error_empty_directory';
  static const error_invalid_json = 'error_invalid_json';
  static const error_special_characters_in_key =
      'error_special_characters_in_key';
  static const error_required_path = 'error_required_path';
  static const error_invalid_dart = 'error_invalid_dart';
  static const error_invalid_file_or_directory =
      'error_invalid_file_or_directory';
  static const ask_existing_page = 'ask_existing_page';
  static const ask_name_to_project = 'ask_name_to_project';
  static const ask_company_domain = 'ask_company_domain';
  static const ask_model_name = 'ask_model_name';
  static const info_unnecessary_flag = 'info_unnecessary_flag';
  static const info_unnecessary_flag_prural = 'info_unnecessary_flag_prural';
  static const options_yes = 'options_yes';
  static const options_no = 'options_no';
  static const sucess_page_create = 'sucess_page_create';
  static const sucess_locale_generate = 'sucess_locale_generate';
  static const sucess_getx_pattern_generated = 'sucess_getx_pattern_generated';
  static const sucess_CLEAN_Pattern_generated =
      'sucess_CLEAN_Pattern_generated';
  static const sucess_file_formatted = 'sucess_file_formatted';
  static const hint_create_controller = 'hint_create_controller';
  static const hint_create_page = 'hint_create_page';
  static const hint_create_project = 'hint_create_project';
  static const hint_create_provider = 'hint_create_provider';
  static const hint_create_screen = 'hint_create_screen';
  static const hint_create_view = 'hint_create_view';
  static const hint_generate_locales = 'hint_generate_locales';
  static const hint_generate_model = 'hint_generate_model';
  static const hint_help = 'hint_help';
  static const hint_init = 'hint_init';
  static const hint_install = 'hint_install';
  static const hint_remove = 'hint_remove';
  static const hint_sort = 'hint_sort';
  static const hint_update = 'hint_update';
  static const hint_version = 'hint_version';
  static const optional_parameters = 'optional_parameters';
  static const example = 'example';
}

abstract class Locales {
  static const en = {
    'error_failed_to_connect': 'Failed to connect with %s',
    'error_no_valid_file_or_url': '%s is not a file or valid url',
    'error_unnecessary_parameter': 'the %s parameter is not necessary',
    'error_unnecessary_parameter_plural': 'the %s parameters are not necessary',
    'error_nonexistent_directory': '%s directory does not exist.',
    'error_empty_directory': '%s is empty',
    'error_invalid_json': '%s is not a valid json file',
    'error_special_characters_in_key':
        'Special characters are not allowed in key. \n key: %s',
    'error_required_path': 'Needed to pass the file or directory path',
    'error_invalid_dart': 'The %s is not a valid dart file',
    'error_invalid_file_or_directory':
        'The %s is not a valid file or directory',
    'ask_existing_page':
        'The page [%s] already exists, do you want to overwrite it?',
    'ask_name_to_project': 'what is the name of the project?',
    'ask_company_domain': 'What is your company\'s domain?',
    'ask_model_name':
        'Could not set the model name automatically, which name do you want to use?',
    'info_unnecessary_flag': 'The %s is not necessary',
    'info_unnecessary_flag_prural': 'The %s are not necessary',
    'options_yes': 'Yes!',
    'options_no': 'No',
    'sucess_page_create': '%s page created successfully.',
    'sucess_locale_generate': 'locale files generated successfully.',
    'sucess_getx_pattern_generated':
        'GetX Pattern structure successfully generated.',
    'sucess_CLEAN_Pattern_generated':
        'CLEAN Pattern structure successfully generated.',
    'sucess_file_formatted': ' \'%s\' was successfully formatted',
    'hint_create_controller': 'Generate controller',
    'hint_create_page': 'Use to generate pages',
    'hint_create_project': 'Use to generate new project',
    'hint_create_provider': 'Create a new Provider',
    'hint_create_screen': 'Generate new screen',
    'hint_create_view': 'Generate view',
    'hint_generate_locales': 'Generate translation file from json files',
    'hint_generate_model': 'generate Class model from json',
    'hint_help': 'Show this help',
    'hint_init': 'generate the chosen structure on an existing project:',
    'hint_install': 'Use to install a package in your project (dependencies):',
    'hint_remove': 'Use to remove a package in your project (dependencies):',
    'hint_sort': 'Sort imports and format dart files',
    'hint_update': 'To update GET_CLI',
    'hint_version': 'Shows the current CLI version\'',
    'optional_parameters': 'Optional parameters: %s',
    'example': 'Example:',
  };
  static const pt_BR = {
    'error_failed_to_connect': 'Falha ao conectar com %s',
    'error_no_valid_file_or_url': '\'%s\' não é um arquivo ou url válido',
    'error_unnecessary_parameter': 'O parâmetro %s não é necessário',
    'error_unnecessary_parameter_plural':
        'Os parâmetros %s não são necessários',
    'error_nonexistent_directory': 'O diretório %s não existe.',
    'error_empty_directory': 'o diretório %s está vazio',
    'error_invalid_json': '%s não é um arquivo json válido',
    'error_special_characters_in_key':
        'Caracteres especiais não são permitidos na key. \n key: %s',
    'error_required_path':
        'Necessário para passar o path do arquivo ou diretório',
    'error_invalid_dart': 'O %s não é um arquivo dart válido',
    'error_invalid_file_or_directory':
        'O %s não é um arquivo ou diretório válido',
    'ask_existing_page': 'A página [%s] já existe, deseja sobrescrevê-la?',
    'options_yes': 'Sim!',
    'options_no': 'Não',
  };
}
