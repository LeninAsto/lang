# Lang - HaxeFlixel Localization Library

A simple and efficient localization library for HaxeFlixel games.

## Features

- Easy-to-use translation system
- Support for multiple languages
- JSON-based translation files
- Automatic fallback to default language
- Variable interpolation in translations
- Hot-reload support for development

## Installation

```bash
haxelib install lang
```

Or install from git:
```bash
haxelib git lang https://github.com/yourusername/lang
```

Add to your `Project.xml`:
```xml
<haxelib name="lang" />
```

## Quick Start

### 1. Initialize the language system

```haxe
import lang.Lang;

class Main extends FlxState {
    override function create() {
        super.create();
        
        // Initialize with default language
        Lang.init("en");
        
        // Or set a specific language
        Lang.setLanguage("es");
    }
}
```

### 2. Create translation files

Create JSON files in your assets folder following this structure:
```
assets/
  lang/
    en.json
    es.json
    fr.json
```

### 3. Add translations

Example `en.json`:
```json
{
    "menu": {
        "play": "Play",
        "options": "Options",
        "exit": "Exit"
    },
    "game": {
        "score": "Score: {0}",
        "level": "Level {0}"
    }
}
```

Example `es.json`:
```json
{
    "menu": {
        "play": "Jugar",
        "options": "Opciones",
        "exit": "Salir"
    },
    "game": {
        "score": "Puntuación: {0}",
        "level": "Nivel {0}"
    }
}
```

### 4. Use translations in your code

```haxe
// Simple translation
var playText = Lang.get("menu.play"); // "Play" or "Jugar"

// Translation with variables
var scoreText = Lang.get("game.score", [1000]); // "Score: 1000"

// Check available languages
var languages = Lang.getAvailableLanguages();

// Get current language
var current = Lang.getCurrentLanguage();
```

## API Reference

### Lang.init(defaultLang:String, ?langPath:String)
Initialize the language system with a default language.
- `defaultLang`: Default language code (e.g., "en")
- `langPath`: Optional custom path to language files (default: "assets/lang/")

### Lang.setLanguage(lang:String):Bool
Change the current language.
- Returns `true` if successful, `false` if language not found

### Lang.get(key:String, ?vars:Array<Dynamic>):String
Get a translated string.
- `key`: Translation key using dot notation (e.g., "menu.play")
- `vars`: Optional array of variables to interpolate

### Lang.exists(key:String):Bool
Check if a translation key exists.

### Lang.getCurrentLanguage():String
Get the current language code.

### Lang.getAvailableLanguages():Array<String>
Get list of all available language codes.

### Lang.reload()
Reload all language files (useful for development).

## Translation File Format

Translation files use JSON format with nested objects:

```json
{
    "category1": {
        "key1": "value1",
        "key2": "value2"
    },
    "category2": {
        "subcategory": {
            "key3": "value3"
        }
    }
}
```

### Variable Interpolation

Use `{0}`, `{1}`, `{2}`, etc. for variable placeholders:

```json
{
    "welcome": "Welcome, {0}!",
    "stats": "Level {0} - Score: {1}"
}
```

```haxe
Lang.get("welcome", ["Player"]); // "Welcome, Player!"
Lang.get("stats", [5, 1000]); // "Level 5 - Score: 1000"
```

## Best Practices

1. **Organize keys by context**: Group related translations together
2. **Use descriptive keys**: `menu.play` instead of `btn1`
3. **Keep fallback**: Always have English (or your default) as fallback
4. **Test with longest translations**: Some languages need more space
5. **Use variables for dynamic content**: Don't concatenate strings

## Advanced Usage

### Custom Language Path

```haxe
Lang.init("en", "assets/translations/");
```

### Language Detection

```haxe
// Detect system language (requires additional setup)
var systemLang = Sys.systemName(); // Implement your detection logic
Lang.setLanguage(systemLang);
```

### Saving Language Preference

```haxe
// Save to FlxSave
var save = new FlxSave();
save.bind("myGame");
save.data.language = Lang.getCurrentLanguage();
save.flush();

// Load preference
if (save.data.language != null) {
    Lang.setLanguage(save.data.language);
}
```

## Example Project Structure

```
MyGame/
  assets/
    lang/
      en.json
      es.json
      fr.json
      pt.json
  source/
    Main.hx
    states/
      MenuState.hx
```

## Contributing

Contributions are welcome! Please feel free to submit pull requests.

## License

Apache 2.0

## Credits

Created for FNF Plus Engine and HaxeFlixel community.
