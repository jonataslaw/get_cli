// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': Locales.en,
    'pt_BR': Locales.pt_BR,
  };
}

abstract class LocaleKeys {
  static const ask_existing_page = 'ask_existing_page';
  static const ask_name_to_project = 'ask_name_to_project';
  static const ask_company_domain = 'ask_company_domain';
  static const ask_model_name = 'ask_model_name';
  static const ask_package_already_installed = 'ask_package_already_installed';
  static const ask_lib_not_empty = 'ask_lib_not_empty';
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
  static const error_package_not_found = 'error_package_not_found';
  static const error_cli_version_not_found = 'error_cli_version_not_found';
  static const error_update_cli = 'error_update_cli';
  static const error_folder_not_found = 'error_folder_not_found';
  static const error_file_not_found = 'error_file_not_found';
  static const error_access_denied = 'error_access_denied';
  static const error_unexpected = 'error_unexpected';
  static const example = 'example';
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
  static const info_unnecessary_flag = 'info_unnecessary_flag';
  static const info_unnecessary_flag_prural = 'info_unnecessary_flag_prural';
  static const info_package_not_installed = 'info_package_not_installed';
  static const info_cli_last_version_already_installed =
      'info_cli_last_version_already_installed';
  static const info_no_file_overwritten = 'info_no_file_overwritten';
  static const info_update_available = 'info_update_available';
  static const info_update_available2 = 'info_update_available2';
  static const options_yes = 'options_yes';
  static const options_no = 'options_no';
  static const optional_parameters = 'optional_parameters';
  static const sucess_page_create = 'sucess_page_create';
  static const sucess_locale_generate = 'sucess_locale_generate';
  static const sucess_getx_pattern_generated = 'sucess_getx_pattern_generated';
  static const sucess_clean_Pattern_generated =
      'sucess_clean_Pattern_generated';
  static const sucess_file_formatted = 'sucess_file_formatted';
  static const sucess_package_removed = 'sucess_package_removed';
  static const sucess_package_installed = 'sucess_package_installed';
  static const sucess_update_cli = 'sucess_update_cli';
  static const sucess_add_controller_in_bindings =
      'sucess_add_controller_in_bindings';
  static const sucess_navigation_added = 'sucess_navigation_added';
  static const sucess_file_created = 'sucess_file_created';
  static const sucess_route_created = 'sucess_route_created';
}

abstract class Locales {
  static const en = {
    'ask_existing_page':
        'The page [%s] already exists, do you want to overwrite it?',
    'ask_name_to_project': 'what is the name of the project?',
    'ask_company_domain': 'What is your company\'s domain?',
    'ask_model_name':
        'Could not set the model name automatically, which name do you want to use?',
    'ask_package_already_installed':
        'package: %s already installed, do you want to update?',
    'ask_lib_not_empty':
        'Your lib folder is not empty. Are you sure you want to overwrite your application? \n WARNING: This action is irreversible',
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
    'error_package_not_found': 'Package: %s not found in pub.dev',
    'error_cli_version_not_found':
        'failed to find the version you have installed.',
    'error_update_cli': 'There was an error upgrading get_cli',
    'error_folder_not_found': 'Folder %s not found',
    'error_file_not_found': 'File not found in %s',
    'error_access_denied': 'Access denied to %s',
    'error_unexpected': 'Unexpected error occurred:',
    'example': 'Example:',
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
    'info_unnecessary_flag': 'The %s is not necessary',
    'info_unnecessary_flag_prural': 'The %s are not necessary',
    'info_package_not_installed':
        'Package: %s is not installed in this application',
    'info_cli_last_version_already_installed':
        'Latest version of get_cli already installed',
    'info_no_file_overwritten': 'No files were overwritten',
    'info_update_available':
        'There\'s an update available! Current installed version: %s',
    'info_update_available2': 'New version available: %s Please, run:',
    'options_yes': 'Yes!',
    'options_no': 'No',
    'optional_parameters': 'Optional parameters: %s',
    'sucess_page_create': '%s page created successfully.',
    'sucess_locale_generate': 'locale files generated successfully.',
    'sucess_getx_pattern_generated':
        'GetX Pattern structure successfully generated.',
    'sucess_clean_pattern_generated':
        'CLEAN Pattern structure successfully generated.',
    'sucess_file_formatted': ' \'%s\' was successfully formatted',
    'sucess_package_removed': 'Package: %s removed!',
    'sucess_package_installed': '\'Package: %s installed!',
    'sucess_update_cli': 'Upgrade complete',
    'sucess_add_controller_in_bindings':
        'The %s has been added to binging at path: %s\'',
    'sucess_navigation_added': '%s navigation added successfully.',
    'sucess_file_created': 'File: %s created successfully at path: %s',
    'sucess_route_created': '%s route created successfully.',
  };
  static const pt_BR = {
    'ask_existing_page': 'A página [%s] já existe, deseja sobrescrevê-la?',
    'ask_name_to_project': 'Qual é o nome do projeto?',
    'ask_company_domain': 'Qual é o domínio da sua empresa?',
    'ask_model_name':
        'Não foi possível definir o nome do modelo automaticamente, qual nome você deseja usar?',
    'ask_package_already_installed':
        'pacote: %s já instalado, deseja atualizar?',
    'ask_lib_not_empty':
        'Sua pasta lib não está vazia. Tem certeza de que deseja sobrescrever seu aplicativo? \n AVISO: esta ação é irreversível',
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
    'error_package_not_found': 'Pacote: %s não encontrado em pub.dev',
    'error_cli_version_not_found':
        'Não foi possível encontrar a versão instalada da CLI',
    'error_update_cli': 'Ocorreu um erro ao atualizar get_cli',
    'error_folder_not_found': 'Pasta %s não encontrada',
    'error_file_not_found': 'Arquivo não encontrado em %s',
    'error_access_denied': 'Acesso negado a %s',
    'error_unexpected': 'Ocorreu um erro inesperado:',
    'example': 'Exemplo:',
    'hint_create_controller': 'Gerar um novo controller',
    'hint_create_page':
        'Gerar um novo modulo, (controller, view e bindigns) (Use essa opcão se esta usando getx_pattern)',
    'hint_create_project':
        'Crie um novo projeto, escolha flutter ou get server',
    'hint_create_provider': 'Cria uma classe Provider',
    'hint_create_screen':
        'Gera uma nova Screen, [controller, view e bindigns] (Use essa opcão se for está usando clean)',
    'hint_create_view': 'Cria uma nova view',
    'hint_generate_locales':
        'Gera um arquivo de traduçao comativel com getx usando json files',
    'hint_generate_model': 'Crie sua classe model apartir de um json',
    'hint_help': 'mostra a tela de help',
    'hint_init': 'Gere a estrutura escolhida em um projeto existente:',
    'hint_install':
        'Use para instalar um pacote em seu projeto (dependencies):',
    'hint_remove': 'Use para remover um pacote em seu projeto (dependencies):',
    'hint_sort': 'Classificar os imports e formatar arquivos dart',
    'hint_update': 'Para atualizar GET_CLI',
    'hint_version': 'Mostra a versão atual do get_cli',
    'info_unnecessary_flag': 'A flag: %s não é necessária',
    'info_unnecessary_flag_prural': 'As flags: %s não são necessárias',
    'info_package_not_installed':
        'Pacote: %s não está instalado neste aplicativo',
    'info_cli_last_version_already_installed':
        'Versão mais recente de get_cli já instalada',
    'info_no_file_overwritten': 'Nenhum arquivo foi sobrescrito',
    'info_update_available':
        'Há uma atualização disponível! Versão atual instalada: %s',
    'info_update_available2': 'Nova versão disponível: %s Por favor, execute:',
    'options_yes': 'Sim!',
    'options_no': 'Não',
    'optional_parameters': 'Parâmetros opcionais: %s',
    'sucess_page_create': 'Página %s criada com sucesso.',
    'sucess_locale_generate': 'Arquivo de tradução gerado com sucesso.',
    'sucess_getx_pattern_generated':
        'Estrutura GetX Pattern gerada com sucesso.',
    'sucess_clean_pattern_generated': 'Estrutura CLEAN gerada com sucesso.',
    'sucess_file_formatted': ' \'%s\' foi formatado com sucesso',
    'sucess_package_removed': 'Pacote: %s removido!',
    'sucess_package_installed': '\'Pacote: %s instalado!',
    'sucess_update_cli': 'Upgrade concluído',
    'sucess_add_controller_in_bindings':
        'O %s foi adicionado ao binging no path: %s \'',
    'sucess_navigation_added': '%s navigation adicionada com sucesso.',
    'sucess_file_created': 'Arquivo: %s criado com sucesso no path: %s',
    'sucess_route_created': 'Rota %s criada com sucesso.',
  };
}
