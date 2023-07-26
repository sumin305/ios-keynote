import UIKit

final class CustomCell: UITableViewCell {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Size.labelWidth    , height: Size.cellHeight))
        label.text = "11"
        label.textColor = .black
        label.textAlignment = .right
        label.backgroundColor = .white
        label.font = UIFont(name: "", size: 20)
        return label
    }()
    lazy var outerImageLabel: UIImageView = {
        let outerImageLabel = UIImageView(frame: CGRect(x: Size.labelWidth, y: 0, width: Size.outerImageLabelWidth, height: Size.cellHeight))
        outerImageLabel.layer.cornerRadius = 5
        outerImageLabel.backgroundColor =  UIColor(named: "OuterCellColor")
        
        let innerImageLabel = UIImageView(frame: CGRect(x: Size.padding, y: Size.padding, width: Size.innerImageLabelWidth, height: Size.innerImageLabelHeight))
        innerImageLabel.backgroundColor = UIColor(named: "InnerCellColor")
    
        let imageView = UIImage(systemName: "")
        outerImageLabel.addSubview(innerImageLabel)
        outerImageLabel.image = imageView
        outerImageLabel.contentMode = .center
        return outerImageLabel
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
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: Size.cellHeight)
        backgroundColor = .systemPink
    }
    
    func setCell() {
        addSubview(label)
        addSubview(outerImageLabel)
    }
}

extension CustomCell {
    func bind(index: Int, image: String) {
        label.text = String(index+1)
        outerImageLabel.image = UIImage(systemName: image)
        print(index, image)
    }
    enum Size {
        static let padding: CGFloat = 5
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
