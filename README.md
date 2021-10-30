# imagine apps

Imagine Apps

You can follow me on instagram [@andresadd](https://www.instagram.com/andresadd)

<img src='https://imagenpng.com/wp-content/uploads/2018/03/logoinstagram3.png' width="250">

## Getting Started
To build and run this project:

1. Get Flutter [here](https://flutter.dev) if you don't already have it
2. Clone this repository.
3. `cd` into the repo folder.
4. run `flutter run-android` or `flutter run-ios` to build the app.

(Unicamente funcional en `ANDROID`)

Este proyecto esta construido con flutter >= 2.12.0 implementando `NULLSAFETY`

Este proyecto utiliza los siguientes paquetes:

1. `Provider` para el manejo de estado dentro de la aplicación.
2. `Firebase` para el manejo de la base de datos y el backend.

Como arquitectura el proyecto implementa `Clean Architecture`.

Caracteristicas principales:

1. El `BottomNavigationBar` y el `AppBar` se muestra y oculta acorde al movimiento del scroll del usuario, para faciliar la visualización al momento de deslizar el contenido de la aplicación.

2. Los `POST` se almacen en la base de datos `FIRESTORE` de `FIREBASE` 

3. Se puede realizar publicaciones (`POST`).

4. Se habilita la edición y la eliminación de los `POST` realizados por el usuario.

5. Al momento de editar un `POST` estado del mismo cambia a Edit para informar a los usuarios que el `POST` ha sido editado.