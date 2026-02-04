# Example Usage

This folder contains examples of how to use the Lang library in your HaxeFlixel game.

## Basic Example

```haxe
import flixel.FlxState;
import lang.Lang;
import lang.LangText;

class MenuState extends FlxState {
    override function create():Void {
        super.create();
        
        // Initialize language system
        Lang.init("en");
        
        // Create auto-translated text
        var titleText = new LangText(0, 50, FlxG.width, "menu.title", null, 32);
        titleText.alignment = CENTER;
        add(titleText);
        
        var playButton = new LangText(0, 200, FlxG.width, "menu.play", null, 24);
        playButton.alignment = CENTER;
        add(playButton);
        
        // Use direct translation
        trace(Lang.get("menu.options"));
    }
}
```

## With Variables

```haxe
import lang.Lang;

class GameState extends FlxState {
    var scoreText:LangText;
    var score:Int = 0;
    
    override function create():Void {
        super.create();
        
        // Create text with variable placeholder
        scoreText = new LangText(10, 10, 0, "gameplay.score", [score]);
        add(scoreText);
    }
    
    function updateScore(newScore:Int):Void {
        score = newScore;
        // Update the variable in the translation
        scoreText.updateVars([score]);
    }
}
```

## Language Selector

```haxe
import lang.Lang;

class OptionsState extends FlxState {
    var languageText:LangText;
    
    override function create():Void {
        super.create();
        
        languageText = new LangText(10, 10, 0, "options.language");
        add(languageText);
        
        // Get available languages
        var languages = Lang.getAvailableLanguages();
        
        var yPos:Float = 50;
        for (lang in languages) {
            var langButton = new FlxText(10, yPos, 0, lang);
            langButton.setFormat(null, 16, FlxColor.WHITE);
            add(langButton);
            yPos += 30;
        }
    }
    
    function changeLang(newLang:String):Void {
        Lang.setLanguage(newLang);
        
        // Refresh all LangText objects
        languageText.refresh();
        
        // Or reload entire state
        FlxG.resetState();
    }
}
```

## Saving Language Preference

```haxe
import flixel.util.FlxSave;
import lang.Lang;

class Main extends FlxGame {
    public function new() {
        // Load saved language preference
        var save = new FlxSave();
        save.bind("myGame");
        
        var savedLang:String = save.data.language != null ? save.data.language : "en";
        
        // Initialize language system
        Lang.init(savedLang);
        
        super(1280, 720, MenuState);
    }
    
    static public function saveLanguage(lang:String):Void {
        var save = new FlxSave();
        save.bind("myGame");
        save.data.language = lang;
        save.flush();
    }
}
```

## File Structure

Your project should have this structure:

```
MyGame/
  assets/
    lang/
      en.json
      es.json
      fr.json
  source/
    Main.hx
    states/
      MenuState.hx
      GameState.hx
      OptionsState.hx
```

## Example Translation Files

### assets/lang/en.json
```json
{
    "menu": {
        "title": "My Awesome Game",
        "play": "Play",
        "options": "Options",
        "credits": "Credits",
        "exit": "Exit"
    },
    "gameplay": {
        "score": "Score: {0}",
        "combo": "{0}x Combo!"
    }
}
```

### assets/lang/es.json
```json
{
    "menu": {
        "title": "Mi Juego Genial",
        "play": "Jugar",
        "options": "Opciones",
        "credits": "Créditos",
        "exit": "Salir"
    },
    "gameplay": {
        "score": "Puntuación: {0}",
        "combo": "¡Combo {0}x!"
    }
}
```
