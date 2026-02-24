import QtQuick 2.15
import org.kde.plasma.plasmoid

WallpaperItem {
    id: root

    property int    fontSize:    root.configuration.fontSize    || 16
    property int    speed:       root.configuration.speed       || 30
    property int    colorMode:   root.configuration.colorMode   || 0
    property string color:       root.configuration.singleColor || "#00FF41"
    property int    paletteIndex:root.configuration.paletteIndex|| 0
    property int    jitter:      root.configuration.jitter      || 0
    property int    glitchChance:root.configuration.glitchChance|| 1
    property int    fadeSpeed:   root.configuration.fadeSpeed   || 5

    property var palettes: [
        ["#00FF41","#00cc33","#00ff88","#00ffcc","#33ff00","#00ee55"],
        ["#ff00ff","#00ffff","#ff0066","#ffcc00","#6600ff","#00ccff"],
        ["#ff00ff","#00ffcc","#cc00ff","#ffcc33","#33ccff","#ccff00"]
    ]

    Canvas {
        id: canvas
        anchors.fill: parent
        renderStrategy: Canvas.Threaded
        renderTarget: Canvas.FramebufferObject

        property var drops: []
        property string chars: "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝ!@#$%^&*()"

        function initDrops() {
            if (!available || width <= 0 || height <= 0) return
            drops = []
            var baseCols = Math.floor(width / root.fontSize)
            for (var i = 0; i < baseCols; i++) {
                drops.push({
                    x:     i * root.fontSize + (Math.random() * root.fontSize * 0.4 - root.fontSize * 0.2),
                    y:     Math.random() * height / root.fontSize,
                    speed: 0.4 + Math.random() * 0.8
                })
                if (Math.random() < 0.6) {
                    drops.push({
                        x:     i * root.fontSize + root.fontSize * 0.5 + (Math.random() * root.fontSize * 0.3 - root.fontSize * 0.15),
                        y:     Math.random() * height / root.fontSize,
                        speed: 0.4 + Math.random() * 0.8
                    })
                }
            }
        }

        onAvailableChanged: if (available) initDrops()
        onWidthChanged:     if (available) initDrops()
        onHeightChanged:    if (available) initDrops()

        onPaint: {
            if (!available) return
            var ctx = getContext("2d")
            if (!ctx) return

            var fs  = root.fontSize
            var h   = height
            var w   = width
            var pal = root.palettes[root.paletteIndex]

            // fadeSpeed 1-20 maps to alpha 0.01-0.20
            ctx.fillStyle = "rgba(0,0,0," + (root.fadeSpeed / 100) + ")"
            ctx.fillRect(0, 0, w, h)

            for (var i = 0; i < drops.length; i++) {
                var drop = drops[i]
                var y = drop.y * fs
                var charSize = fs + Math.floor(Math.random() * 5) - 2
                ctx.font = charSize + "px monospace"

                if (Math.random() < root.glitchChance / 100) {
                    ctx.fillStyle = "#ffffff"
                } else if (root.colorMode === 0) {
                    ctx.fillStyle = root.color
                } else {
                    ctx.fillStyle = pal[i % pal.length]
                }

                ctx.fillText(chars[Math.floor(Math.random() * chars.length)], drop.x, y)
                drop.y = (drop.y + drop.speed + (Math.random() * root.jitter / 100)) % (h / fs)
            }
        }
    }

    Timer {
        interval: Math.max(20, 2000 / root.speed)
        running: true
        repeat: true
        onTriggered: canvas.requestPaint()
    }

    onFontSizeChanged: canvas.initDrops()
}
