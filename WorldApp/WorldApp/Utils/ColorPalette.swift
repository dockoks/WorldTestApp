import UIKit

struct ColorPalette {
    enum Background {
        static let layerOneTop = UIColor(lightHex: 0x310050, darkHex: 0x310050)
        static let layerOneBottom = UIColor(lightHex: 0x000000, darkHex: 0x000000)
        static let layerTwo = UIColor(lightHex: 0xFFFFFF, darkHex: 0xFFFFFF)
    }
    
    enum Text {
        static let primary = UIColor(lightHex: 0x000000, darkHex: 0x000000, alpha: 1)
        static let onPrimary = UIColor(lightHex: 0xFFFFFF, darkHex: 0xFFFFFF, alpha: 1)
    }
    
    enum Main {
        static let primaryColor = UIColor(lightHex: 0x5A3472, darkHex: 0x5A3472, alpha: 1)
        
        static let aliveColorDark = UIColor(lightHex: 0xFFB800, darkHex: 0xFFB800, alpha: 1)
        static let aliveColorLight = UIColor(lightHex: 0xFFF7B0, darkHex: 0xFFF7B0, alpha: 1)
        static let deadColorDark = UIColor(lightHex: 0x0D658A, darkHex: 0x0D658A, alpha: 1)
        static let deadColorLight = UIColor(lightHex: 0xB0FFB4, darkHex: 0xB0FFB4, alpha: 1)
        static let lifeBornColorDark = UIColor(lightHex: 0xAD00FF, darkHex: 0xAD00FF, alpha: 1)
        static let lifeBornColorLight = UIColor(lightHex: 0xFFB0E9, darkHex: 0xFFB0E9, alpha: 1)
        static let lifeDiedColorDark = UIColor(lightHex: 0x000000, darkHex: 0x000000, alpha: 1)
        static let lifeDiedColorLight = UIColor(lightHex: 0x3B3B3B, darkHex: 0x3B3B3B, alpha: 1)
    }
}
