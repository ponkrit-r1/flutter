# Pettagu

An App for Pet Owner

## Getting Started
Use fvm for Flutter version please check the installation guide [here](https://fvm.app/documentation/getting-started/installation)

## Development Setup

1. **Clone the repository** and navigate to the project directory.

2. **Environment Variables**  
   Copy `.env.example` to `.env` and update the values as needed for your local setup:
   ```
   cp .env.example .env
   ```
   - `.env.example` contains the required environment variables for development.
   - Update `BASE_API_URL` in your `.env` file to match your backend API endpoint.

3. **Install dependencies**  
   ```
   flutter pub get
   ```

4. **Run the app**  
   ```
   flutter run
   ```

## State Management
We use [GetX](https://github.com/jonataslaw/getx) as a core library for state management, dependency injection, and route management. 
Although GetX has sparked some controversy within the developer community, using it correctly and avoiding the singleton method should result in a smooth experience.

### Additional Note 
Use [Get.back()](https://pub.dev/packages/get) carefully use it on nested navigation might result in bugs and confusion.

## Project Structure
We kinda adopt project structure from [getx_pattern](https://github.com/kauemurakami/getx_pattern).

```
- /app  
# This is where all the application's directories will be contained  
    - /modules
    # Each module consists of a page, its respective GetXController and its dependencies or Bindings.
    # We treat each screen as an independent module, as it has its only controller, and can also contain its dependencies.
    # If you use reusable widgets in this, and only in this module, you can choose to add a folder for them.
        - /my_module
            - page.dart
            - controller.dart
            - binding.dart
            - /local_widgets
    # The Binding class is a class that decouples dependency injection, while "binding" routes to the state manager and the dependency manager.
    # This lets you know which screen is being displayed when a specific controller is used and knows where and how to dispose of it.
    # In addition, the Binding class allows you to have SmartManager configuration control.
    # You can configure how dependencies are to be organized and remove a route from the stack, or when the widget used for disposition, or none of them.
    - /routes
    # In this repository we will deposit our routes and pages.  
    # We chose to separate into two files, and two classes, one being routes.dart, containing its constant routes and the other for routing.  
        - app_routes.dart
        # class Routes {
        # This file will contain your constants ex:  
        # class Routes { const HOME = '/ home'; }  
        - app_pages.dart
        # This file will contain your array routing ex :  
        # class AppPages { static final pages = [  
        #  GetPage(name: Routes.HOME, page:()=> HomePage()) 
        # ]};  
    - /core
        - /data
            - /api
            #Represent api calls
            - /repository
            #Represent data layer can use to combine network and local calls
        - /global_widgets 
        # Widgets that can be reused by multiple **modules**.
        - /domain
        # Contain model of the entity in the app 
        - /network
        # All of the things need to make API calls 
        - /theme
        #Here we can create themes for our widgets, texts and colors
            - app_text_theme.dart  
            # inside ex: final textTitle = TextStyle(fontSize: 30)  
            - app_color.dart  
            # inside ex: final colorCard = Color(0xffEDEDEE)  
            - app_theme.dart  
            # inside ex: final textTheme = TextTheme(headline1: TextStyle(color: colorCard))  
        - /utils
        #Here you can insert utilities for your application, such as masks, form keys or widgets
- main.dart
```