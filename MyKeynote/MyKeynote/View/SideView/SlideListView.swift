import Foundation
import UIKit

protocol SlideListViewDelegate: AnyObject {
    func addSlide()
}

final class SlideListView: SideView {
    
    var slideAddButton: UIButton!
    var slideListTableView: UITableView!
    
    weak var delegate: SlideListViewDelegate?
    init(slideArray: [any Slidable]) {
        super.init()
        setSlideAddButton()
        setSlideListTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setFrame() {
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
    
    func setSlideAddButton() {
        slideAddButton = UIButton(type: .system)
        slideAddButton.setTitle( "(+)", for: .normal)
        slideAddButton.tintColor = UIColor(named: "SlideAddButtonTextColor")
        slideAddButton.backgroundColor = UIColor(named: "SlideAddButtonColor")
        slideAddButton.layer.cornerRadius = Size.cornerRadius
        slideAddButton.frame = CGRect(x: 0, y: ConstantSize.totalHeight - Size.buttonHeight, width: ConstantSize.sideViewWidth, height: Size.buttonHeight)
        slideAddButton.addTarget(self, action: #selector(slideAddButtonTapped), for: .touchUpInside)
        addSubview(slideAddButton)
    }
    
    func setSlideListTableView() {
        slideListTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight - slideAddButton.frame.height), style: .plain)
        slideListTableView.backgroundColor = UIColor(named: "SubviewColor")
        slideListTableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        addSubview(slideListTableView)
    }
    
    func setSlideListTableViewDataSource(delegatable: UITableViewDataSource) {
        slideListTableView.dataSource = delegatable
    }
    
    func setSlideListTableDelegate(delegatable: UITableViewDelegate) {
        slideListTableView.delegate = delegatable
    }
    
    func updateSlideList(slide: any Slidable) {
//        slideListTableView.insertRows(at: IndexPath[], with: .automatic)
        slideListTableView.reloadData()
    }
}

extension SlideListView {
    
    enum Size {
        static let buttonHeight: CGFloat = ConstantSize.totalHeight / 13
        static let slideListHeight: CGFloat = ConstantSize.totalHeight / 10
        static let cornerRadius: CGFloat = 5
    }
    
    func setSlideAddButtonDelegate(delegatable: SlideListViewDelegate) {
        self.delegate = delegatable
    }
    @objc func slideAddButtonTapped() {
        delegate?.addSlide()
    }
}
