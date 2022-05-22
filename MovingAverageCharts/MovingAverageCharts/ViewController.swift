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
    var chartdata = LineChartData()
    
    var yearMonthArray: [String] = []
    var stockPriceArray: [String] = []
    var epsArray: [String] = []
    
    var peRationPriceArray1: [String] = []
    var peRationPriceArray2: [String] = []
    var peRationPriceArray3: [String] = []
    var peRationPriceArray4: [String] = []
    var peRationPriceArray5: [String] = []
    var peRationPriceArray6: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movingAverageChartView.delegate = self
        
        self.dataView.configureView(title: "2022/05")
        self.stockPriceView.configureView(color: .red, labelTitle: "股價530")
        self.peRatioPriceView1.configureView(color: .orange, labelTitle: "31.83倍810.04")
        self.peRatioPriceView2.configureView(color: .yellow, labelTitle: "28.23倍718.45")
        self.peRatioPriceView3.configureView(color: .green, labelTitle: "24.63倍626.83")
        self.peRatioPriceView4.configureView(color: .blue, labelTitle: "21.03倍535.21")
        self.peRatioPriceView5.configureView(color: .purple, labelTitle: "17.43倍443.59")
        self.peRatioPriceView6.configureView(color: .black, labelTitle: "13.83倍251.97")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupXAxis()
        setupYAxis()
        setupLineChart(monthCount: 12, xAxis: yearMonthArray, values: stockPriceArray)
        getEpsData(monthCount: 12)
    }
    
    deinit {
        print("=======================")
        print(self, #function, "released")
        print("=======================")
    }
    
    private func setupLineChart(monthCount:Int, xAxis: [String], values: [String]) {
        let stockPriceDic: [String: String] = [:]
        let peRationBaseDic: [String: String] = [:]
        var color: UIColor?
        movingAverageChartView.noDataText = "wait loading..."
        movingAverageChartView.setScaleEnabled(false)
        
        for dataIndex in 0...5 {
            DataGetHelper.shared.getPointData(monthCount: monthCount, pointDataDic: peRationBaseDic, dataIndex: dataIndex) { [weak self] (result) in
                var entries: [ChartDataEntry]?
                guard let result = result else { return }
                let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
                
                switch dataIndex {
                    
                case 0 :
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray1.append(value)
                    }
                    entries = self?.peRationPriceArray1.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .orange
                    
                case 1:
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray2.append(value)
                    }
                    entries = self?.peRationPriceArray2.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .yellow
                    
                case 2 :
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray3.append(value)
                    }
                    entries = self?.peRationPriceArray3.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .green
                    
                case 3:
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray4.append(value)
                    }
                    entries = self?.peRationPriceArray4.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .blue
                    
                case 4 :
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray5.append(value)
                    }
                    entries = self?.peRationPriceArray5.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .purple
                case 5:
                    for (key, value) in sortedKeysAndValue {
                        self?.yearMonthArray.append(key)
                        self?.peRationPriceArray6.append(value)
                    }
                    entries = self?.peRationPriceArray6.enumerated().map {
                        return ChartDataEntry.init(x: Double($0), y: Double($1)!)
                    }
                    color = .black
                    
                default:
                    return
                }
                
                let set = LineChartDataSet.init(entries: entries)
                self?.configureSet(set: set, lineWidth: 0.5, color: color!, isfilled: true)
                self?.chartdata.addDataSet(set)
            }
        }
        
        DataGetHelper.shared.getData(monthCount: monthCount, stockPriceDic: stockPriceDic, epsDic: nil) { [weak self] (result) in
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
            
            let set = LineChartDataSet.init(entries: entries)
            self?.configureSet(set: set, lineWidth: 2.0, color: .red, isfilled: false)
            self?.chartdata.addDataSet(set)
        }
        movingAverageChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: yearMonthArray)
        movingAverageChartView.data = chartdata
    }
    
    private func getEpsData(monthCount: Int) {
        let epsDic: [String: String] = [:]
        DataGetHelper.shared.getData(monthCount: monthCount, stockPriceDic: nil, epsDic: epsDic) { [weak self]
            (result) in
            guard let result = result else { return }
            let sortedKeysAndValue = result.sorted { $0.0 < $1.0 }
            for (key, value) in sortedKeysAndValue {
                self?.yearMonthArray.append(key)
                self?.epsArray.append(value)
            }
        }
    }
    
    private func setupXAxis() {
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
    
    private func configureSet(set: LineChartDataSet, lineWidth: Double, color: UIColor, isfilled: Bool) {
        let endColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0)
        let gradColors = [color.cgColor, endColor.cgColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradColors as CFArray, locations: colorLocations) else { return }
        set.fill = Fill.fillWithLinearGradient(gradient, angle: -90)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        set.drawFilledEnabled = isfilled
        set.lineWidth = lineWidth
        set.setColor(color)
        set.fillAlpha = 1
        set.drawHorizontalHighlightIndicatorEnabled = false
    }
}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let x = Int(highlight.x)
        let eps1 = String(format: "%.2f", Double(peRationPriceArray1[x])!/Double(epsArray[x])!)
        let eps2 = String(format: "%.2f", Double(peRationPriceArray2[x])!/Double(epsArray[x])!)
        let eps3 = String(format: "%.2f", Double(peRationPriceArray3[x])!/Double(epsArray[x])!)
        let eps4 = String(format: "%.2f", Double(peRationPriceArray4[x])!/Double(epsArray[x])!)
        let eps5 = String(format: "%.2f", Double(peRationPriceArray5[x])!/Double(epsArray[x])!)
        let eps6 = String(format: "%.2f", Double(peRationPriceArray6[x])!/Double(epsArray[x])!)
        
        dataView.configureView(title: "\(yearMonthArray[x])")
        stockPriceView.configureView(color: .red, labelTitle: "股價\(stockPriceArray[x])")
        peRatioPriceView1.configureView(color: .orange, labelTitle: "\(eps1)倍\(peRationPriceArray1[x])")
        peRatioPriceView2.configureView(color: .yellow, labelTitle: "\(eps2)倍\(peRationPriceArray2[x])")
        peRatioPriceView3.configureView(color: .green, labelTitle: "\(eps3)倍\(peRationPriceArray3[x])")
        peRatioPriceView4.configureView(color: .blue, labelTitle: "\(eps4)倍\(peRationPriceArray4[x])")
        peRatioPriceView5.configureView(color: .purple, labelTitle: "\(eps5)倍\(peRationPriceArray5[x])")
        peRatioPriceView6.configureView(color: .black, labelTitle: "\(eps6)倍\(peRationPriceArray6[x])")
    }
}
