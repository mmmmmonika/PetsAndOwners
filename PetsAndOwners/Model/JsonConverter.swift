//
//  JsonConverter.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 08/11/2022.
//

import Foundation

class JsonConverter {
    class func convertedArrayToJson(array:[Pet]?) -> String? {
        guard let _array = array else {
            return nil
        }

        let encoder = JSONEncoder()
        do {
            let result  = try encoder.encode(_array)
            let stringResult = String(data: result, encoding: .utf8)!
            return stringResult
        } catch let error {
            print("Encoding error: \(error)")
            return nil
        }
    }
    
    class func convertedJsonToArray(jsonText:String?) -> [Pet]? {
        guard let _json = jsonText else {
            return nil
        }
        let responseData = Data(_json.utf8)
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([Pet].self, from: responseData)
            return result
        } catch let error {
            print("Decoding error: \(error)")
            return nil
        }
    }
}
