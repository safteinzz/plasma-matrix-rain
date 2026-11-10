# Matrix Rain — KDE Plasma 6 Wallpaper Plugin

A matrix rain wallpaper plugin for KDE Plasma 6, working on **Wayland and X11**. Supports both desktop wallpaper and lock screen.

![Matrix Rain](https://img.shields.io/badge/KDE-Plasma%206-blue) ![License](https://img.shields.io/badge/license-GPL--3.0-green)

## Features

- Falling katakana, latin, half-width katakana and symbol characters
- Staggered columns with slight x-offset for a natural look
- Per-column random fall speed
- Variable character size (±2px per character)
- Configurable trail fade length
- Glitch chance (random white flash)
- Jitter (randomness in fall speed)
- Single color or multi-color palette modes
- Works as desktop wallpaper and lock screen

## Requirements

- KDE Plasma 6
- Wayland or X11

No compilation needed. Pure QML, no dependencies.

## Install

```bash
git clone https://github.com/safteinzz/plasma-matrix-rain.git
cd plasma-matrix-wallpaper
mkdir -p ~/.local/share/plasma/wallpapers/
cp -r com.github.safteinzz.matrixwallpaper ~/.local/share/plasma/wallpapers/
```

Then restart plasmashell:

```bash
systemctl --user restart plasma-plasmashell.service
```

## Set as Desktop Wallpaper

1. Right-click the desktop → **Desktop and Wallpaper**
2. Change **Wallpaper Type** to **Matrix Rain**
3. Configure as desired → **Apply**

## Set as Lock Screen

```bash
kwriteconfig6 --file kscreenlockerrc --group Greeter --key WallpaperPlugin com.github.safteinzz.matrixwallpaper
```

Or via UI:

1. **System Settings** → **Screen Locking** → **Configure Appearance...**
2. Change **Wallpaper Type** to **Matrix Rain**
3. Configure as desired → **Apply**

## Configuration

| Setting | Description | Default |
|---|---|---|
| Font Size | Character size in px | 16 |
| Fall Speed | 1 (slow) to 100 (fast) | 30 |
| Trail Fade | 1 (long trail) to 20 (short trail) | 5 |
| Color Mode | Single color or multi-color palette | Single |
| Color | Hex color for single color mode | #00FF41 |
| Palette | Color palette for multi-color mode | Matrix Green |
| Jitter | Randomness in fall speed (0=uniform) | 0 |
| Glitch Chance | % chance of white character flash | 1 |

## Uninstall

```bash
rm -rf ~/.local/share/plasma/wallpapers/com.github.safteinzz.matrixwallpaper
systemctl --user restart plasma-plasmashell.service
```

If you had it set as lock screen, reset it:

```bash
kwriteconfig6 --file kscreenlockerrc --group Greeter --key WallpaperPlugin org.kde.image
```

## File Structure

```
com.github.safteinzz.matrixwallpaper/
├── metadata.json
└── contents/
    ├── config/
    │   └── main.xml
    └── ui/
        ├── main.qml
        └── config.qml
```

## License

GPL-3.0
