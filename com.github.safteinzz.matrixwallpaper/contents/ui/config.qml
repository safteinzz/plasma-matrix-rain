import QtQuick 2.0
import QtQuick.Controls 2.5 as QQC2
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page

    signal configurationChanged()

    property int    cfg_fontSize:     16
    property int    cfg_speed:        30
    property int    cfg_fadeSpeed:    5
    property int    cfg_colorMode:    0
    property string cfg_singleColor:  "#00FF41"
    property int    cfg_paletteIndex: 0
    property int    cfg_jitter:       0
    property int    cfg_glitchChance: 1

    QQC2.SpinBox {
        from: 8; to: 48
        value: cfg_fontSize
        onValueChanged: { cfg_fontSize = value; configurationChanged() }
        Kirigami.FormData.label: "Font Size (px):"
    }
    QQC2.SpinBox {
        from: 1; to: 100
        value: cfg_speed
        onValueChanged: { cfg_speed = value; configurationChanged() }
        Kirigami.FormData.label: "Fall Speed:"
    }
    QQC2.SpinBox {
        from: 1; to: 20
        value: cfg_fadeSpeed
        onValueChanged: { cfg_fadeSpeed = value; configurationChanged() }
        Kirigami.FormData.label: "Trail Fade (1=long, 20=short):"
    }
    QQC2.ComboBox {
        id: colorMode
        model: ["Single Color", "Multi Color"]
        currentIndex: cfg_colorMode
        onCurrentIndexChanged: { cfg_colorMode = currentIndex; configurationChanged() }
        Kirigami.FormData.label: "Color Mode:"
    }
    QQC2.TextField {
        visible: colorMode.currentIndex === 0
        text: cfg_singleColor
        onTextChanged: { cfg_singleColor = text; configurationChanged() }
        Kirigami.FormData.label: "Color (hex):"
    }
    QQC2.ComboBox {
        visible: colorMode.currentIndex === 1
        model: ["Matrix Green", "Cyberpunk", "Synthwave"]
        currentIndex: cfg_paletteIndex
        onCurrentIndexChanged: { cfg_paletteIndex = currentIndex; configurationChanged() }
        Kirigami.FormData.label: "Palette:"
    }
    QQC2.SpinBox {
        from: 0; to: 100
        value: cfg_jitter
        onValueChanged: { cfg_jitter = value; configurationChanged() }
        Kirigami.FormData.label: "Jitter (%):"
    }
    QQC2.SpinBox {
        from: 0; to: 100
        value: cfg_glitchChance
        onValueChanged: { cfg_glitchChance = value; configurationChanged() }
        Kirigami.FormData.label: "Glitch Chance (%):"
    }
}
