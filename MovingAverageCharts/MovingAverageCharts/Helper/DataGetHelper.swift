//
//  DataGetHelper.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/22.
//

import Foundation

class DataGetHelper {
    
    static let shared = DataGetHelper()
    let jsonParseHelper = JSONParseHelper()
    var tsmcModel: TSMCModel?
    var allMovingAverageData: [MovingAverageData]?
    var someMovingAverageData: [MovingAverageData] = []
    var yearMonth: [String] = []
    
    // read data for areaspline chart
    func getPointData(monthCount: Int, pointDataDic: [String: String], dataIndex: Int, completion: @escaping ([String: String]?) -> Void) {
        tsmcModel = jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
        guard let tsmcModel = tsmcModel else { return }
        var pointDataDic = pointDataDic
        var index = 0
        for i in tsmcModel.data {
            allMovingAverageData = i.movingAverageData
            guard let allMovingAverageData = allMovingAverageData else { return }
            
            for j in allMovingAverageData {
                if index < monthCount {
                    var date = j.date
                    someMovingAverageData.append(allMovingAverageData[index])
                    date.insert("/", at: date.index(date.startIndex, offsetBy: 4))
                    yearMonth.append(date)
                    pointDataDic.updateValue(j.peRatioBase.reversed()[dataIndex], forKey: "\(date)")
                    index += 1
                } 
            }
            completion(pointDataDic)
        }
    }
    
    // read data for stock price
    func getStockPrice(monthCount: Int, stockPriceDic: [String: String], completion: @escaping ([String: String]?) -> Void) {
        tsmcModel = jsonParseHelper.parseJson(form: JSONFileName.TSMCMovingAverage.rawValue)
        guard let tsmcModel = tsmcModel else { return }
        var stockPriceDic = stockPriceDic
        var index = 0
        for i in tsmcModel.data {
            allMovingAverageData = i.movingAverageData
            guard let allMovingAverageData = allMovingAverageData else { return }
            
            for j in allMovingAverageData {
                if index < monthCount {
                    var date = j.date
                    someMovingAverageData.append(allMovingAverageData[index])
                    date.insert("/", at: date.index(date.startIndex, offsetBy: 4))
                    yearMonth.append(date)
                    stockPriceDic.updateValue(j.monthAveragePrice, forKey: "\(date)")
                    index += 1
                }
            }
            completion(stockPriceDic)
        }
    }
}
