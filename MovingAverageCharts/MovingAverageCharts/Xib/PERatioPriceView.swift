//
//  PERatioPriceView.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/20.
//

import UIKit

@IBDesignable
final class PERatioPriceView: UIView {
    
    @IBOutlet private weak var colorBoxView: UIView!
    @IBOutlet private weak var ratioPriceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        guard let view = self.loadViewFromXib(nibName: NibName.PERatioPriceView.rawValue) else { return }
        view.frame = frame
        self.addSubview(view)
    }

    func configureView(color: UIColor, labelTitle: String) {
        self.colorBoxView.backgroundColor = color
        self.ratioPriceLabel.text = labelTitle
    }
}
