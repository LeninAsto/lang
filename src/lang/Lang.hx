package lang;

import haxe.Json;
import haxe.ds.StringMap;

#if sys
import sys.FileSystem;
import sys.io.File;
#else
import openfl.Assets;
#end

/**
 * Main language/translation system
 */
class Lang {
    private static var currentLanguage:String = "en";
    private static var defaultLanguage:String = "en";
    private static var translations:StringMap<Dynamic> = new StringMap<Dynamic>();
    private static var languagePath:String = "assets/lang/";
    private static var initialized:Bool = false;

    /**
     * Initialize the language system
     * @param defLang Default language code
     * @param path Path to language files (optional)
     */
    public static function init(defLang:String = "en", ?path:String):Void {
        defaultLanguage = defLang;
        currentLanguage = defLang;
        
        if (path != null) {
            languagePath = path;
            if (!languagePath.endsWith("/")) {
                languagePath += "/";
            }
        }
        
        loadLanguage(defaultLanguage);
        initialized = true;
    }

    /**
     * Set/change current language
     * @param lang Language code to switch to
     * @return True if successful, false if language not found
     */
    public static function setLanguage(lang:String):Bool {
        if (lang == currentLanguage) {
            return true;
        }
        
        if (loadLanguage(lang)) {
            currentLanguage = lang;
            return true;
        }
        
        return false;
    }

    /**
     * Get a translated string
     * @param key Translation key (supports dot notation: "category.subcategory.key")
     * @param vars Optional variables for interpolation
     * @return Translated string or key if not found
     */
    public static function get(key:String, ?vars:Array<Dynamic>):String {
        if (!initialized) {
            trace("Lang system not initialized! Call Lang.init() first.");
            return key;
        }

        var result:String = getFromPath(key);
        
        // Variable interpolation
        if (vars != null && vars.length > 0) {
            for (i in 0...vars.length) {
                result = StringTools.replace(result, '{$i}', Std.string(vars[i]));
            }
        }
        
        return result;
    }

    /**
     * Check if a translation key exists
     * @param key Translation key to check
     * @return True if exists
     */
    public static function exists(key:String):Bool {
        var parts:Array<String> = key.split(".");
        var current:Dynamic = translations.get(currentLanguage);
        
        if (current == null) {
            return false;
        }
        
        for (part in parts) {
            if (Reflect.hasField(current, part)) {
                current = Reflect.field(current, part);
            } else {
                return false;
            }
        }
        
        return true;
    }

    /**
     * Get current language code
     * @return Current language code
     */
    public static function getCurrentLanguage():String {
        return currentLanguage;
    }

    /**
     * Get default language code
     * @return Default language code
     */
    public static function getDefaultLanguage():String {
        return defaultLanguage;
    }

    /**
     * Get list of available languages
     * @return Array of language codes
     */
    public static function getAvailableLanguages():Array<String> {
        var languages:Array<String> = [];
        
        #if sys
        if (FileSystem.exists(languagePath) && FileSystem.isDirectory(languagePath)) {
            for (file in FileSystem.readDirectory(languagePath)) {
                if (file.endsWith(".json")) {
                    languages.push(file.substring(0, file.length - 5));
                }
            }
        }
        #else
        // For web/non-sys targets, return manually defined languages
        // You need to add your available languages here
        languages = ["en"]; // Add your languages: ["en", "es", "fr", "pt"]
        #end
        
        return languages;
    }

    /**
     * Reload all language files (useful for development)
     */
    public static function reload():Void {
        translations.clear();
        loadLanguage(currentLanguage);
    }

    // Private methods

    private static function loadLanguage(lang:String):Bool {
        var filePath:String = languagePath + lang + ".json";
        
        try {
            var content:String = null;
            
            #if sys
            if (FileSystem.exists(filePath)) {
                content = File.getContent(filePath);
            }
            #else
            if (Assets.exists(filePath)) {
                content = Assets.getText(filePath);
            }
            #end
            
            if (content != null) {
                var data:Dynamic = Json.parse(content);
                translations.set(lang, data);
                return true;
            }
        } catch (e:Dynamic) {
            trace('Error loading language file: $filePath - $e');
        }
        
        return false;
    }

    private static function getFromPath(key:String):String {
        var parts:Array<String> = key.split(".");
        var current:Dynamic = translations.get(currentLanguage);
        
        // Try current language
        if (current != null) {
            for (part in parts) {
                if (Reflect.hasField(current, part)) {
                    current = Reflect.field(current, part);
                } else {
                    current = null;
                    break;
                }
            }
            
            if (current != null && Std.isOfType(current, String)) {
                return cast current;
            }
        }
        
        // Fallback to default language
        if (currentLanguage != defaultLanguage) {
            current = translations.get(defaultLanguage);
            
            if (current != null) {
                for (part in parts) {
                    if (Reflect.hasField(current, part)) {
                        current = Reflect.field(current, part);
                    } else {
                        current = null;
                        break;
                    }
                }
                
                if (current != null && Std.isOfType(current, String)) {
                    return cast current;
                }
            }
        }
        
        // Return key if not found
        trace('Translation not found: $key');
        return key;
    }
}
