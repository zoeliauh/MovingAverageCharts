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
    let movieAverageGraph = LineChartData()
    var chartdata = LineChartData()
    
    var yearMonthArray: [String] = []
    var stockPriceArray: [String] = []
        
    var peRationPriceArray1: [String] = []
    var peRationPriceArray2: [String] = []
    var peRationPriceArray3: [String] = []
    var peRationPriceArray4: [String] = []
    var peRationPriceArray5: [String] = []
    var peRationPriceArray6: [String] = []
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupXAxis()
        setupYAxis()
        setupLineChart(monthCount: 12, xAxis: yearMonthArray, values: stockPriceArray)
    }
    
    private func drawChart(dataSets: [LineChartDataSet]) {
        movingAverageChartView.data = chartdata
    }
    
    private func setupLineChart(monthCount:Int, xAxis: [String], values: [String]) {
        let stockPriceDic: [String: String] = [:]
        let peRationBaseDic: [String: String] = [:]
        movingAverageChartView.noDataText = "wait loading..."
        movingAverageChartView.setScaleEnabled(false)
        
        DataGetHelper.shared.getStockPrice(monthCount: monthCount, stockPriceDic: stockPriceDic) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.stockPriceArray.append(value)
            }
            entries = self?.stockPriceArray.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries, label: "stockPrice")
            self?.configureSet(set: set, lineWidth: 2.0, color: .red)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 0) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray1.append(value)
            }
            
            entries = self?.peRationPriceArray1.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .black)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 1) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray2.append(value)
            }
            
            entries = self?.peRationPriceArray2.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .purple)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 2) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray3.append(value)
            }
            
            entries = self?.peRationPriceArray3.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .blue)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 3) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray4.append(value)
            }
            
            entries = self?.peRationPriceArray4.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .green)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 4) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray5.append(value)
            }
            
            entries = self?.peRationPriceArray5.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .yellow)
            self?.chartdata.addDataSet(set)
        }
        
        DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: 5) { [weak self] (result) in
            var entries: [ChartDataEntry]?
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.peRationPriceArray6.append(value)
            }
            
            entries = self?.peRationPriceArray6.enumerated().map {
                return ChartDataEntry.init(x: Double($0), y: Double($1)!)
            }
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 0.5, color: .orange)
            self?.chartdata.addDataSet(set)
        }
        movingAverageChartView.data = chartdata
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
    
    private func configureSet(set: LineChartDataSet, lineWidth: Double, color: UIColor) {
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.lineWidth = lineWidth
        set.setColor(color)
        set.drawHorizontalHighlightIndicatorEnabled = false
    }
}
