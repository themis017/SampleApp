//
//  JSONStorage.swift
//
//
//  Created by Themis Makedas on 27/2/24.
//

import Foundation

@propertyWrapper
public struct JSONStorage<T: Codable> {
    private let fileName: String
    private let defaultValue: T
    
    private var currentValue: T?

    init(fileName: String, defaultValue: T) {
        self.fileName = fileName
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        mutating get {
            if let value = currentValue {
                return value
            }
            
            if let data = readDataFromFile() {
                do {
                    let decodedValue = try JSONDecoder().decode(T.self, from: data)
                    currentValue = decodedValue
                    return decodedValue
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            
            return defaultValue
        }
        set {
            do {
                currentValue = newValue
                
                let encodedValue = try JSONEncoder().encode(newValue)
                writeDataToFile(data: encodedValue)
            } catch {
                print("Error encoding data: \(error)")
            }
        }
    }

    private func readDataFromFile() -> Data? {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(fileName).json")

            return try Data(contentsOf: fileURL)
        } catch {
            print("Error reading data from file: \(error)")
            return nil
        }
    }

    private func writeDataToFile(data: Data) {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(fileName).json")

            try data.write(to: fileURL)
        } catch {
            print("Error writing data to file: \(error)")
        }
    }
}
