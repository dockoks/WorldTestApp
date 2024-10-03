import UIKit

final class WorldTableViewCell: UITableViewCell {
    static let reuseIdentifier = "WorldTableViewCellIdentifier"
    
    private let wrapperView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let iconLabel = UILabel()
    private let iconBackgroundView = UIView()
    private let iconBackgroundLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = nil) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with state: CellState) {
        switch state {
        case .alive:
            titleLabel.text = Constants.Title.aliveText
            subtitleLabel.text = Constants.Subtitle.aliveSubtitle
            iconLabel.text = Constants.Icon.aliveText
            applyGradient(with: Constants.IconBackgroundColors.aliveColors)
            
        case .dead:
            titleLabel.text = Constants.Title.deadText
            subtitleLabel.text = Constants.Subtitle.deadSubtitle
            iconLabel.text = Constants.Icon.deadText
            applyGradient(with: Constants.IconBackgroundColors.deadColors)
            
        case .lifeBorn:
            titleLabel.text = Constants.Title.lifeBornText
            subtitleLabel.text = Constants.Subtitle.lifeBornSubtitle
            iconLabel.text = Constants.Icon.lifeBornText
            applyGradient(with: Constants.IconBackgroundColors.lifeBornColors)
            
        case .lifeDied:
            titleLabel.text = Constants.Title.lifeDiedText
            subtitleLabel.text = Constants.Subtitle.lifeDiedSubtitle
            iconLabel.text = Constants.Icon.lifeDiedText
            applyGradient(with: Constants.IconBackgroundColors.lifeDiedColors)
        }
        
        wrapperView.backgroundColor = ColorPalette.Background.layerTwo
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        iconLabel.text = nil
        iconBackgroundLayer.removeFromSuperlayer()
    }
    
    private func applyGradient(with colors: [CGColor]) {
        iconBackgroundLayer.colors = colors
        iconBackgroundLayer.cornerRadius = Constants.Icon.size / 2
        iconBackgroundLayer.frame = CGRect(x: 0, y: 0, width: Constants.Icon.size, height: Constants.Icon.size)
        
        if iconBackgroundLayer.superlayer == nil {
            iconBackgroundView.layer.insertSublayer(iconBackgroundLayer, at: 0)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(iconBackgroundView)
        wrapperView.addSubview(iconLabel)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(subtitleLabel)
        
        wrapperView.layer.cornerRadius = Constants.Cell.WrappedCornerRadius
        wrapperView.layer.cornerCurve = .continuous
        wrapperView.clipsToBounds = true
        
        titleLabel.font = WorldFont.Styles.body
        titleLabel.textColor = ColorPalette.Text.primary
        subtitleLabel.font = WorldFont.Styles.footnote
        subtitleLabel.textColor = ColorPalette.Text.primary
        
        iconLabel.font = WorldFont.Styles.body
        iconLabel.textAlignment = .center
        iconLabel.clipsToBounds = true
        
        iconBackgroundView.layer.cornerRadius = Constants.Icon.size / 2
        iconBackgroundView.clipsToBounds = true
        
        backgroundColor = .clear
        
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Cell.verticalWrappedPadding),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Cell.horizontalWrappedPadding),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Cell.horizontalWrappedPadding),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Cell.verticalWrappedPadding),
            wrapperView.heightAnchor.constraint(equalToConstant: Constants.Cell.cellHeight),
            
            iconBackgroundView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: Constants.Cell.iconLeading),
            iconBackgroundView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: Constants.Icon.size),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: Constants.Icon.size),
       
            iconLabel.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalTo: iconBackgroundView.widthAnchor),
            iconLabel.heightAnchor.constraint(equalTo: iconBackgroundView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: Constants.Cell.textLeading),
            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: Constants.Cell.top),
            titleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Constants.Cell.trailing),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: Constants.Cell.textLeading),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Cell.subtitleTop),
            subtitleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -Constants.Cell.trailing),
            subtitleLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -Constants.Cell.bottom),
        ])
    }
}

// MARK: - Constants
private extension WorldTableViewCell {
    enum Constants {
        enum Title {
            static let aliveText = "Живая"
            static let deadText = "Мертвая"
            static let lifeBornText = "Жизнь"
            static let lifeDiedText = "Смерть"
        }
        
        enum Subtitle {
            static let aliveSubtitle = "И шевелится!"
            static let deadSubtitle = "Или прикидывается"
            static let lifeBornSubtitle = "Ку-ку!"
            static let lifeDiedSubtitle = "Жизнь умерла"
        }
        
        enum Icon {
            static let aliveText = "💥"
            static let deadText = "💀"
            static let lifeBornText = "🐣"
            static let lifeDiedText = "⚰️"
            static let size: CGFloat = 40.0
        }
        
        enum IconBackgroundColors {
            static let aliveColors = [ColorPalette.Main.aliveColorDark.cgColor, ColorPalette.Main.aliveColorLight.cgColor]
            static let deadColors = [ColorPalette.Main.deadColorDark.cgColor, ColorPalette.Main.deadColorLight.cgColor]
            static let lifeBornColors = [ColorPalette.Main.lifeBornColorDark.cgColor, ColorPalette.Main.lifeBornColorLight.cgColor]
            static let lifeDiedColors = [ColorPalette.Main.lifeDiedColorDark.cgColor, ColorPalette.Main.lifeDiedColorLight.cgColor]
        }
        
        enum Cell {
            static let verticalWrappedPadding: CGFloat = 2.0
            static let horizontalWrappedPadding: CGFloat = 16.0
            static let WrappedCornerRadius: CGFloat = 8.0
            static let iconLeading: CGFloat = 16.0
            static let textLeading: CGFloat = 12.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = 10.0
            static let subtitleTop: CGFloat = 4.0
            static let trailing: CGFloat = 16.0
            static let cellHeight: CGFloat = 72
        }
    }
}
