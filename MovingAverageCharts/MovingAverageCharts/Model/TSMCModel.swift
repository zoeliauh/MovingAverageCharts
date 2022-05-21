//
//  TSMCModel.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/21.
//

import Foundation

public enum JSONFileName: String {
    case TSMCMovingAverage = "TSMCMovingAverage"
}

struct TSMCModel: Codable {
    let data: [ResultItem]
}

struct ResultItem: Codable {
    let stockNumber: String
    let stockName: String
    let peRatio: [String]
    let pbRation: [String]
    let movingAverageData: [MovingAverageData]
    let currentPE: String
    let currentPB: String
    let medianPE: String
    let medianPB: String
    let evalutePE: String
    let evalutePB: String
    let averagePE: String
    let averagePB: String
    let pegRatio: String
    
    enum CodingKeys: String, CodingKey {
        case stockNumber = "股票代號"
        case stockName = "股票名稱"
        case peRatio = "本益比基準"
        case pbRation = "本淨比基準"
        case movingAverageData = "河流圖資料"
        case currentPE = "目前本益比"
        case currentPB = "目前本淨比"
        case medianPE = "同業本益比中位數"
        case medianPB = "同業本淨比中位數"
        case evalutePE = "本益比股價評估"
        case evalutePB = "本淨比股價評估"
        case averagePE = "平均本益比"
        case averagePB = "平均本淨比"
        case pegRatio = "本益成長比"
    }
}

struct MovingAverageData: Codable {
    let date: String
    let monthAveragePrice: String
    let eps: String
    let peRatio: String
    let peRatioBase: [String]
    let currentEps: String
    let currentPbRation: String
    let pbRatioBase: [String]
    let averagePe: String?
    let averagePb: String?
    let growth: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "年月"
        case monthAveragePrice = "月平均收盤價"
        case eps = "近四季EPS"
        case peRatio = "月近四季本益比"
        case peRatioBase = "本益比股價基準"
        case currentEps = "近一季BPS"
        case currentPbRation = "月近一季本淨比"
        case pbRatioBase = "本淨比股價基準"
        case averagePe = "平均本益比"
        case averagePb = "平均本淨比"
        case growth = "近3年年複合成長"
    }
}
