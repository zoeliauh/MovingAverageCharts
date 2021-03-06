//
//  JSONparseHelper.swift
//
//  Created by woanjwu liauh on 2022/5/21.
//

import Foundation

class JSONParseHelper {

    func parseJson<T: Decodable>(form fileName: String) -> T {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { fatalError() }

        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            let data = try JSONDecoder().decode(T.self, from: jsonData)
            return data
        } catch {
            fatalError()
        }
    }
}
