//
//  ViewController.swift
//
//  Created by woanjwu liauh on 2022/5/20.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet private weak var dataView: DateView!
    @IBOutlet private weak var stockPriceView: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView1: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView2: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView3: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView4: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView5: PERatioPriceView!
    @IBOutlet private weak var peRatioPriceView6: PERatioPriceView!
    @IBOutlet private weak var movingAverageChartView: LineChartView!
    
    let jsonParseHelper = JSONParseHelper()
    var tsmcModel: TSMCModel?
    var allMovingAverageData: [MovingAverageData]?
    var oneYearMovingAverageData: [MovingAverageData] = []
    var yearMonth: [String] = []
    var stockPrice: [String] = []
    var lineChartDic: [String: String] = [:]
    var entries: [ChartDataEntry]?
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
        // get data
        tsmcModel = jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
        getData(monthCount: 12)
        
        // setup chart
        setupXAxis()
        setupYAxis()
        setupData(xAxis: yearMonth, values: stockPrice)
    }
    
    private func getData(monthCount: Int) {
        guard let tsmcModel = tsmcModel else { return }
        var index = 0
        for i in tsmcModel.data {
            allMovingAverageData = i.movingAverageData
            guard let allMovingAverageData = allMovingAverageData else { return }
            
            for j in allMovingAverageData {
                if index < monthCount {
                    var date = j.date
                    oneYearMovingAverageData.append(allMovingAverageData[index])
                    date.insert("/", at: date.index(date.startIndex, offsetBy: 4))
                    yearMonth.append(date)
                    lineChartDic.updateValue(j.monthAveragePrice, forKey: "\(date)")
                    index += 1
                } else {
//                    print(yearMonth)
//                    print(lineChartDic)
                    return
                }
            }
        }
    }
    
    private func setupData(xAxis: [String], values: [String]) {
        movingAverageChartView.noDataText = "wait loading..."
        movingAverageChartView.setScaleEnabled(false)

        let sortedKeysAndValue = lineChartDic.sorted { $0.0 < $1.0 }
        for (key, value) in sortedKeysAndValue {
//            print("\(key) -> \(value)")
            yearMonth.append(key)
            stockPrice.append(value)
        }
        
        entries = stockPrice.enumerated().map {
            return ChartDataEntry.init(x: Double($0), y: Double($1)!)
        }
        
        let set = LineChartDataSet.init(entries: entries)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.lineWidth = 2.0
        set.setColor(.red)
        set.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSets: [set])
        movingAverageChartView.data = data
    }
    
    private func setupXAxis() {
        movingAverageChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: yearMonth.reversed())
        movingAverageChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 5)
        movingAverageChartView.xAxis.labelPosition = .bottom
        movingAverageChartView.xAxis.drawAxisLineEnabled = false
    }
    
    private func setupYAxis() {
        movingAverageChartView.rightAxis.labelFont = UIFont.systemFont(ofSize: 9)
        movingAverageChartView.rightAxis.forceLabelsEnabled = true
        movingAverageChartView.leftAxis.enabled = false
        movingAverageChartView.legend.enabled = false
    }
}
