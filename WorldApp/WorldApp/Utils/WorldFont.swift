import UIKit

struct WorldFont {
    static let shared = WorldFont()
    
    // MARK: - Styles
    enum Styles {
        static let header = WorldFont.shared.font(size: 24, weight: .medium)
        static let body = WorldFont.shared.font(size: 20, weight: .medium)
        static let button = WorldFont.shared.font(size: 16, weight: .medium)
        static let footnote = WorldFont.shared.font(size: 14, weight: .regular)
    }
    
    // MARK: - Font Names
    private let mediumTodoFontName = "Roboto-Medium"
    private let regularTodoFontName = "Roboto-Regular"

    // MARK: - Public Methods
    func font(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let fontName = self.fontName(weight: weight)
        guard let customFont = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
        return customFont
    }

    // MARK: - Private Helper Methods
    private func fontName(weight: UIFont.Weight) -> String {
        return switch weight {
        case .medium: mediumTodoFontName
        case .regular: regularTodoFontName
        default: regularTodoFontName
        }
    }
}
