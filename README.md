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


## Adicionando novas funções:
1- Adicione a pasta em core/structure (Não esqueça de adicionar ao replaceAsExpected e ao toMap)
2- Crie um sample e insira na pasta samples/impl (é necessário criar uma classe, estender Sample)
3- Crie a função de criação da classe ou das pastas e insira em functions. Se o comando for de criação, na pasta create, se for de inicialização (como uma estrutura nova) em init 
4- Abra o arquivo create/create.dart, adicione seu comando no switch, e aponte para sua função. 

Pronto!