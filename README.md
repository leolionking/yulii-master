# Yulii

Yulii est une application [Flutter](https://flutter.dev/) ; elle est déployée sur sous [Android](https://flutter.dev/docs/deployment/android) et [iOS](https://flutter.dev/docs/deployment/ios).

### Architecture

#### Mobile

La structure de Yulii correspond à celle d'un projet Flutter. Les dossiers prinsipaux utilisés sont :
- lib
    - abstracts
    - app : dossier par défaut
    - common : contient les fonctions communes spécifiques à l'application
    - constants : contient les constantes de l'application
    - exceptions : permet la gestion des exceptions de l'application
    - extensions : contient des extensiosn des classes de base
    - models : modèles utilisés dans l'application
    - routing : contient tous les fichiers de gestion de code de navigationde l'application
    - screens : les différents écrans disponibles dans l'application
    - themes : gestion des couleurs, et formes des éléments de l'application
    - utils : contient les helpers, services, UI utils, mixins utilisés dans l'application
    - widgets : widgets utilisés dans les écrans de l'application
- assets : contient les fonts, images et icones de l'application


#### Base de Données

Yulii est supportée par une base de données [Firestore](https://firebase.google.com/products/firestore). 

##### Fonctions

Les opérations de l'application sont réalisées grâce à des [fonctions](https://firebase.google.com/docs/functions) stockées sur Firestore. (voir [yulii_firestore](https://gitlab.com/acl-devs/yulli_firebase))

##### Données

La base de données Firestore stocke les données au format json. Les documents suivants permettent le fonctionnement de l'application :
- chatMessages : messages envoyés par les utilisateurs dans une conversation  
exemple :  
```
{
  "<id>" : {
    "chatId": <string>,
    "content": <string>,
    "createdAt": <timestamp>,
    "deletedAt": <timestamp>|null,
    "file": null|{
        "downloadUrl": <string>,
        "filePath": <string>,
        "fileType": <string>
    },
    "participantsIds": <array[string]>,
    "read": <boolean>,
    "receiverId": <string>,
    "remoteId": <string>|null,
    "senderId": <string>,
    "type": <string>
  }
}
```
- chats : conversations entre les utilisateurs  
exemple :  
```
{
  "<id>" : {
    "createdAt": <timestamp>,
    "lastMessage": null|{
        "chatId": <string>,
        "content": <string>,
        "fileType": <string>,
        "createdAt": <timestamp>,
        "deletedAt": <timestamp>|null,
        "file": null|{
            "downloadUrl": <string>,
            "filePath": <string>,
            "fileType": <string>
        },
        "participantsIds": <array[string]>,
        "read": <boolean>,
        "receiverId": <string>,
        "remoteId": <string>|null,
        "senderId": <string>,
        "type": <string>
    },
    "participantsIds": <array[string]>,
    "remoteId": <string>|null,
    "updatedAt": <timestamp>|null
  }
}
```
- claims : demandes des recompenses faites par les utisateurs  
exemple :  
```
{
  "<id>" : {
    "authorId": <string>,
    "createdAt": <timestamp>,
    "goalId": <string>,
    "goalType": <string>,
    "points": <string>|null,
    "remoteId": <string>|null
  }
}
```
- creditTransactions : opérations de crédit/débit lorsqu'une récompense est validée.  
exemple :  
```
{
  "<id>" : {
    "createdAt": <timestamp>,
    "current": <integer>,
    "ownerId": <string>,
    "previous": <integer>,
    "transactionType": "decrease"|"increase",
    "transactionValue": <integer>
  }
}
```
- goals : correspond aux récompenses
exemple :  
```
{
  "<id>" : {
    "assignees": <array[string]>,
    "assigneesUsers": <array[string]>|null,
    "authorId": <string>,
    "createdAt": <timestamp>,
    "description": <string>|null,
    "duedate": <timestamp>|null,
    "files": null| <array[fileProperties]>,
    "goalType": "pro"|"classic",
    "hasBeenClaimAtLeastOnce": <string>,
    "isMystery": <boolean>,
    "name": <string>,
    "points": <integer>|null,
    "referer": <array[string]>,
    "refererUsers": <array[string]>|null,
    "status": ""|"",
    "remoteId": <string>|null,
    "tasksIds": <array[string]>|null,
    "updatedAt": <timestamp>|null
  }
}
```
- invitations : invitations d'amis
exemple :  
```
{
  "<id>" : {
    "createdAt": <timestamp>,
    "receiver": <string>,
    "sender": <timestamp>|null,
    "status": ""|"",
    "updatedAt": <timestamp>|null
  }
}
```
- notifications : permet la gestion des notifications de l'application  
exemple :  
```
{
  "<id>" : {
    "createdAt": <timestamp>,
    "data": {
        "itemId": <string>,
        "itemName": <string>,
        "itemStatus": ""|"",
        "sender": <string>,
        "senderName": <string>,
    },
    "read": <boolean>,
    "receiver": <string>,
    "remoteId": <string>|null,
    "status": ""|"",
    "type": ""|"",
    "updatedAt": <timestamp>|null
  }
}
```
- tasks : corresponds aux tâches  
exemple :  
```
{
  "<id>" : {
    "assignees": <array[string]>,
    "assigneesUsers": <array[string]>|null,
    "authorId": <string>,
    "createdAt": <timestamp>,
    "description": <string>|null,
    "duedate": <timestamp>|null,
    "files": null| <array[fileProperties]>,
    "goal": <string>|null,
    "goalId": <string>|null,
    "name": <string>,
    "points": <integer>|null,
    "remoteId": <string>|null,
    "status": ""|"",
    "updatedAt": <timestamp>|null
  }
}
```
- users : utilisateurs de l'application  
exemple :  
```
{
  "<id>" : {
    "clients": {
      "<id>" : {
        "appBuildNumber": <integer>,
        "appInstanceId": <string>,
        "appVersion": <string>,
        "model": <string>,
        "platform": <string>,
        "platformVersion": <string>,
        "token": <string>,
        "updatedAt": <datetime>
      },
      ...
    },
    "avatarUrl": <string>|null,
    "email": <string>,
    "finishedTasks":  <integer>|null,
    "firstname": <string>|null,
    "friends": null| <array[fileProperties]>,
    "isEmailVerified": <boolean>,
    "lastCredits": <integer>|null,
    "lastname": <string>,
    "remoteId": <string>|null,
    "totalTasks": <integer>|null
  }
}
```

##### Images

Les images envoyées par les utilisateurs de l'application sont hébergées sur le [Cloud Storage](https://firebase.google.com/docs/storage/web/upload-files).

### Applications tierces

camera  
https://pub.dev/packages/camera  
A Flutter plugin for iOS and Android allowing access to the device cameras.  
  
cloud_firestore / cloud_firestore_web  
https://pub.dev/packages/cloud_firestore  
A Flutter plugin to use the Cloud Firestore API.  
  
connectivity / connectivity_for_web / connectivity_macos  
https://pub.dev/packages/device_info  
This plugin allows Flutter apps to discover network connectivity and configure themselves accordingly. It can distinguish between cellular vs WiFi connection. This plugin works for iOS and Android.  
  
device_info  
https://pub.dev/packages/device_info  
Get current device information from within the Flutter application.  
  
devicelocale  
https://pub.dev/packages/devicelocale  
Gets the device locale data, independent of the app locale settings.  
  
file_picker  
https://pub.dev/packages/file_picker  
A package that allows you to use the native file explorer to pick single or multiple files, with extensions filtering support.  
  
firebase_auth / firebase_auth_web  
https://pub.dev/packages/firebase_auth  
A Flutter plugin to use the Firebase Authentication API.  
  
firebase_core / firebase_core_web  
https://pub.dev/packages/firebase_core  
A Flutter plugin to use the Firebase Core API, which enables connecting to multiple Firebase apps.  
  
firebase_messaging / firebase_messaging_web  
https://pub.dev/packages/firebase_messaging  
A Flutter plugin to use the Firebase Cloud Messaging API.  
  
firebase_storage / firebase_storage_web  
https://pub.dev/packages/firebase_storage  
A Flutter plugin to use the Firebase Cloud Storage API.  
  
flutter_keyboard_visibility / flutter_keyboard_visibility_web  
https://pub.dev/packages/flutter_keyboard_visibility  
React to keyboard visibility changes.  
  
flutter_local_notifications  
https://pub.dev/packages/flutter_local_notifications  
A cross platform plugin for displaying local notifications.  
  
flutter_plugin_android_lifecycle  
https://pub.dev/packages/flutter_plugin_android_lifecycle  
A Flutter plugin for Android to allow other Flutter plugins to access Android Lifecycle objects in the plugin's binding.  
  
fluttertoast  
https://pub.dev/packages/fluttertoast  
Now this toast library supports two kinds of toast messages one which requires BuildContext other with No BuildContext  
  
image_cropper  
https://pub.dev/packages/image_cropper  
A Flutter plugin for Android and iOS supports cropping images. This plugin is based on two different native libraries so it comes with different UI between these platforms.  
  
image_picker / image_picker_for_web  
https://pub.dev/packages/image_picker  
A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.  
  
package_info  
https://pub.dev/packages/package_info  
This Flutter plugin provides an API for querying information about an application package.  
  
path_provider / path_provider_linux / path_provider_macos / path_provider_windows  
https://pub.dev/packages/path_provider  
A Flutter plugin for finding commonly used locations on the filesystem. Supports iOS, Android, Linux and MacOS. Not all methods are supported on all platforms.  
  
permission_handler  
https://pub.dev/packages/permission_handler  
This plugin provides a cross-platform (iOS, Android) API to request permissions and check their status. You can also open the device's app settings so users can grant a permission.  
  
photo_manager  
https://pub.dev/packages/photo_manager  
A flutter api for photo, you can get image/video from ios or android.  
  
shared_preferences / shared_preferences_linux / shared_preferences_macos / shared_preferences_web, shared_preferences_windows  
https://pub.dev/packages/shared_preferences  
Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.). Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.  
  
sqflite  
https://pub.dev/packages/sqflite  
SQLite plugin for Flutter. Supports iOS, Android and MacOS.  
  
url_launcher / url_launcher_linux / url_launcher_macos / url_launcher_web / url_launcher_windows  
https://pub.dev/packages/url_launcher  
A Flutter plugin for launching a URL. Supports iOS, Android, web, Windows, macOS, and Linux.  
  
video_player / video_player_web  
https://pub.dev/packages/video_player  
A Flutter plugin for iOS, Android and Web for playing back video on a Widget surface.  
  
wakelock / wakelock_macos / wakelock_web  
https://pub.dev/packages/wakelock  
Plugin that allows you to keep the device screen awake, i.e. prevent the screen from sleeping  
  
webview_flutter  
https://pub.dev/packages/webview_flutter  
A Flutter plugin that provides a WebView widget.  
On iOS the WebView widget is backed by a WKWebView; On Android the WebView widget is backed by a WebView.  


### Plus d'informations
Si vous avez des questions concernant le développement de l'application, vous pouvez contacter le développeur à <hello@acreativelab.com>.
