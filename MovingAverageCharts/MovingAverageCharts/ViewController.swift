//
//  ViewController.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var dataView: DateView!
    @IBOutlet private weak var stockPriceView: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView1: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView2: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView3: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView4: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView5: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView6: PERatioPriceView!
    
    var tsmcModel: TSMCModel?
//    let jsonParseHelper: JSONParseHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataView.configureView(title: "2021/04")
        self.stockPriceView.configureView(color: .red, labelTitle: "股價xxx")
        self.peRatioPriceView1.configureView(color: .orange, labelTitle: "22倍543.4")
        self.peRatioPriceView2.configureView(color: .yellow, labelTitle: "19.5倍435.2")
        self.peRatioPriceView3.configureView(color: .green, labelTitle: "17.8倍356.7")
        self.peRatioPriceView4.configureView(color: .blue, labelTitle: "14.3倍222.1")
        self.peRatioPriceView5.configureView(color: .purple, labelTitle: "10.4倍145.6")
        self.peRatioPriceView6.configureView(color: .black, labelTitle: "9.7倍43.4")
        parseJson()
//        jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
    }
    
    private func parseJson() {
        guard let path = Bundle.main.path(forResource: JSONFileName.TSMCMovingAverage.rawValue, ofType: "json") else { fatalError() }
        
        let url = URL(fileURLWithPath: path)

        do {
            let jsonData = try Data(contentsOf: url)
            print(jsonData)
            tsmcModel = try JSONDecoder().decode(TSMCModel.self, from: jsonData)
            guard let tsmcModel = tsmcModel else { return }
            print(tsmcModel)
        } catch {
            fatalError()
        }
    }
}
