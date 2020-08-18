Essa CLI está em estágio alfa, use com cuidado.

```dart
// para instalar:
pub global activate get_cli 


// Para iniciar um projeto com a estrutura escolhida:
get init 

// para criar uma página: Páginas possuem controller, view, e binding
get create page:home //get create page:login 

// para criar um novo controller em uma pasta expecífica:
get create controller:dialogcontroller on home
// Obs: você não precisa apontar o caminho, Getx procurará automaticamente a pasta home e irá inserir seu controller lá.

// para criar uma nova view em uma pasta expecífica:
get create view:dialogview on home
// Obs: você não precisa apontar o caminho, Getx procurará automaticamente a pasta home e irá inserir seu controller lá.

// para criar o arquivo de rotas:
get create route 

```

TODO: 
- Ao criar um controller, inserir ele automaticamente no Binding 
- Ao criar uma page, inserir ela automaticamente em Routes 
- Inserir as opções de upgrade, install, remove na cli 
- Suporte a customModels
- Testes unitários