# Translation Templates

This folder contains template files for creating new language translations.

## How to Use

1. Copy a template file (e.g., `en.json`)
2. Rename it to your language code (e.g., `es.json` for Spanish, `fr.json` for French)
3. Fill in all the empty strings with translations
4. Place it in your game's `assets/lang/` folder

## Language Codes

Use standard ISO 639-1 language codes:

- `en` - English
- `es` - Spanish / Español
- `fr` - French / Français
- `de` - German / Deutsch
- `pt` - Portuguese / Português
- `ru` - Russian / Русский
- `ja` - Japanese / 日本語
- `ko` - Korean / 한국어
- `zh` - Chinese / 中文
- `it` - Italian / Italiano
- `nl` - Dutch / Nederlands
- `pl` - Polish / Polski
- `tr` - Turkish / Türkçe
- `ar` - Arabic / العربية

## Template Structure

The template is organized into categories:

- **menu**: Main menu items
- **options**: Settings/options related text
- **gameplay**: In-game text and HUD elements
- **results**: End-of-game results screen
- **messages**: System messages and notifications
- **common**: Common UI elements used everywhere

## Adding Custom Categories

You can add your own categories as needed:

```json
{
    "menu": { ... },
    "mycategory": {
        "mykey1": "My value 1",
        "mykey2": "My value 2"
    }
}
```

## Variable Placeholders

Use `{0}`, `{1}`, `{2}`, etc. for dynamic values:

```json
{
    "gameplay": {
        "score": "Score: {0}",
        "combo": "Combo: {0}x"
    }
}
```

## Tips

1. Keep the same structure as the template
2. Don't remove keys, even if empty
3. Test with longest translations to ensure UI fits
4. Use consistent terminology across all strings
5. Consider cultural differences in icons and symbols
