//
//  DateView.swift
//
//  Created by woanjwu liauh on 2022/5/21.
//

import UIKit

@IBDesignable
final class DateView: UIView {

    @IBOutlet private weak var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        guard let view = self.loadViewFromXib(nibName: NibName.DateView.rawValue) else { return }
        view.frame = frame
        self.addSubview(view)
    }

    func configureView(title:String) {
        self.dateLabel.text = title
    }
}
