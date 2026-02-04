package lang;

import flixel.text.FlxText;

/**
 * Extended FlxText that automatically updates when language changes
 */
class LangText extends FlxText {
    private var translationKey:String;
    private var translationVars:Array<Dynamic>;

    /**
     * Create a new LangText
     * @param x X position
     * @param y Y position
     * @param fieldWidth Width of the text field
     * @param key Translation key
     * @param vars Optional variables for translation
     * @param size Font size
     */
    public function new(x:Float = 0, y:Float = 0, fieldWidth:Float = 0, key:String = "", ?vars:Array<Dynamic>, size:Int = 8) {
        super(x, y, fieldWidth, "", size);
        setTranslation(key, vars);
    }

    /**
     * Set or update the translation key
     * @param key Translation key
     * @param vars Optional variables for translation
     */
    public function setTranslation(key:String, ?vars:Array<Dynamic>):Void {
        translationKey = key;
        translationVars = vars;
        updateText();
    }

    /**
     * Update variables without changing the key
     * @param vars New variables for translation
     */
    public function updateVars(vars:Array<Dynamic>):Void {
        translationVars = vars;
        updateText();
    }

    /**
     * Refresh the translation (useful after language change)
     */
    public function refresh():Void {
        updateText();
    }

    private function updateText():Void {
        if (translationKey != null && translationKey.length > 0) {
            text = Lang.get(translationKey, translationVars);
        }
    }

    override function update(elapsed:Float):Void {
        super.update(elapsed);
    }
}
