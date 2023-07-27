import UIKit

final class CustomCell: UITableViewCell {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Size.labelWidth, height: Size.cellHeight))
        label.text = "11"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .white
        label.font = UIFont(name: "", size: 40)
        return label
    }()
    lazy var outerImageLabel: UIView = {
        let outerImageLabel = UIView(frame: CGRect(x: Size.labelWidth, y: 0, width: Size.outerImageLabelWidth, height: Size.cellHeight))
        outerImageLabel.layer.cornerRadius =  10
        outerImageLabel.backgroundColor =  UIColor(named: "OuterCellColor")
        return outerImageLabel
    }()
    
    lazy var innerImageLabel: UIImageView = {
        let innerImageLabel = UIImageView(frame: CGRect(x: Size.padding, y: Size.padding, width: Size.innerImageLabelWidth, height: Size.innerImageLabelHeight))
        innerImageLabel.backgroundColor = UIColor(named: "InnerCellColor")
        outerImageLabel.addSubview(innerImageLabel)
        outerImageLabel.contentMode = .center
        return innerImageLabel
    }()
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: Size.innerImageLabelWidth / 2 - Size.imageViewWidth / 2, y: Size.innerImageLabelHeight / 2 - Size.imageViewHeight / 2, width: Size.imageViewWidth, height: Size.imageViewHeight))
        let image = UIImage(systemName: "")
        imageView.image = image
        imageView.tintColor = UIColor(named: "CellImageColor")
        innerImageLabel.addSubview(imageView)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setFrame()
        setCell()
    }
    
    func setFrame() {
        
    }
    
    func setCell() {
        contentView.addSubview(label)
        contentView.addSubview(outerImageLabel)
    }
}

extension CustomCell {
    func bind(index: Int, image: String) { // index -> tableView row
        label.text = String(index+1)
        imgView.image = UIImage(systemName: image)
    }
    
    enum Size {
        static let padding: CGFloat = 10
        static let cellWidth = ConstantSize.sideViewWidth
        static let cellHeight = ConstantSize.totalHeight / 10
        
        static let labelWidth = cellWidth / 4
        static let outerImageLabelWidth = cellWidth / 4 * 3
        
        static let innerImageLabelWidth = outerImageLabelWidth - 2*padding
        static let innerImageLabelHeight = cellHeight - 2*padding
        
        static let imageViewWidth = innerImageLabelWidth - 6*padding
        static let imageViewHeight = innerImageLabelHeight - 4*padding
    }
}
