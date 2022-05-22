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
//    var tsmcModel: TSMCModel?
//    var allMovingAverageData: [MovingAverageData]?
//    var someMovingAverageData: [MovingAverageData] = []
    var yearMonthArray: [String] = []
    var stockPriceArray: [String] = []
//    var stockPriceDic: [String: String] = [:]
    var peRationBaseDic: [String: String] = [:]
    
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
//        tsmcModel = jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
//        getStockPrice(monthCount: 12)
//        DataGetHelper.shared.getStockPrice(monthCount: 12, stockPriceDic: stockPriceDic)
//        DataGetHelper.shared.getPointData(monthCount: 12, pointDataDic: peRationBaseDic, dataIndex: 0)
//        getPeRationBase(monthCount: 12)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // setup chart
        setupXAxis()
        setupYAxis()
//        setupData(xAxis: yearMonthArray, values: stockPriceArray)
        setupStockPriceLineChart(monthCount: 12, xAxis: yearMonthArray, values: stockPriceArray)
        
    }
    
//    private func getStockPrice(monthCount: Int) {
//        guard let tsmcModel = tsmcModel else { return }
//        var index = 0
//        for i in tsmcModel.data {
//            allMovingAverageData = i.movingAverageData
//            guard let allMovingAverageData = allMovingAverageData else { return }
//
//            for j in allMovingAverageData {
//                if index < monthCount {
//                    var date = j.date
//                    someMovingAverageData.append(allMovingAverageData[index])
//                    date.insert("/", at: date.index(date.startIndex, offsetBy: 4))
//                    yearMonthArray.append(date)
//                    stockPriceDic.updateValue(j.monthAveragePrice, forKey: "\(date)")
//                    index += 1
//                } else {
////                    print(yearMonth)
//                    print(stockPriceDic)
//                    return
//                }
//            }
//        }
//    }
    
//    private func getPeRationBase(monthCount: Int) {
//        guard let tsmcModel = tsmcModel else { return }
//        var index = 0
//        for i in tsmcModel.data {
//            allMovingAverageData = i.movingAverageData
//            guard let allMovingAverageData = allMovingAverageData else { return }
//
//            for j in allMovingAverageData {
//                if index < monthCount {
//                    var date = j.date
//                    someMovingAverageData.append(allMovingAverageData[index])
//                    date.insert("/", at: date.index(date.startIndex, offsetBy: 4))
//                    yearMonth.append(date)
//                    peRationBaseDic.updateValue(j.peRatioBase[0], forKey: "\(date)")
//                    index += 1
//                } else {
////                    print(yearMonth)
//                    print(peRationBaseDic)
//                    return
//                }
//            }
//        }
//    }
    
    private func setupStockPriceLineChart(monthCount:Int, xAxis: [String], values: [String]) {
        let stockPriceDic: [String: String] = [:]
        movingAverageChartView.noDataText = "wait loading..."
        movingAverageChartView.setScaleEnabled(false)
        DataGetHelper.shared.getStockPrice(monthCount: monthCount, stockPriceDic: stockPriceDic, completion: { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
//            print("result is \(String(describing: result))")
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                //            print("\(key) -> \(value)")
                self?.yearMonthArray.append(key)
                self?.stockPriceArray.append(value)
            }
            
            entries = self?.stockPriceArray.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            set.drawCirclesEnabled = false
            set.drawValuesEnabled = false
            set.lineWidth = 2.0
            set.setColor(.red)
            set.drawHorizontalHighlightIndicatorEnabled = false
            
            let data = LineChartData(dataSets: [set])
            self?.movingAverageChartView.data = data
        })
    }
    
    private func setupXAxis() {
        movingAverageChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: yearMonthArray.reversed())
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
