//
//  ViewController.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/20.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    var tsmcModel: TSMCModel?
    let jsonParseHelper = JSONParseHelper()
    var entries: [ChartDataEntry]?
    
    @IBOutlet private weak var dataView: DateView!
    @IBOutlet private weak var stockPriceView: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView1: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView2: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView3: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView4: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView5: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView6: PERatioPriceView!
    @IBOutlet private weak var movingAverageChartView: LineChartView!
    
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
        tsmcModel = jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
        setupChart()
    }
    
    // 建立 ChartDataEntry
    func setupChart() {
        movingAverageChartView.noDataText = "wait loading..."
        movingAverageChartView.xAxis.labelPosition = .bottom
        movingAverageChartView.leftAxis.enabled = false
        movingAverageChartView.xAxis.drawAxisLineEnabled = false
        movingAverageChartView.legend.enabled = false
        movingAverageChartView.rightAxis.forceLabelsEnabled = true
        movingAverageChartView.drawMarkers = true
        let points = [30.65, 44.56, 25.64, 34.66, 25.20, 30.65, 44.56, 25.64, 34.66, 25.20, 54.32, 51.23]
        entries = points.enumerated().map {
            return ChartDataEntry.init(x: Double($0), y: Double($1))
        }
        let set = LineChartDataSet.init(entries: entries)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.lineWidth = 2.0
        set.setColor(.red)
        
        let data = LineChartData(dataSets: [set])
        movingAverageChartView.data = data
    }
    
    func setupXAxis() {
        var xValue: [String] = []
//        for i in 0..<entries?.count {
//            let data = Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date
//            xValue.append("2/11")
//        }
        movingAverageChartView.xAxis.labelPosition = .bottom
        movingAverageChartView.leftAxis.enabled = false
    }
}
