//
//  ------------------------------------------------------------
//  ---------------            Helpers            --------------
//  ---------------                               --------------
//  ------------------------------------------------------------

import Foundation
import OSLog
import Extensions


public var exampleImageData: Data {
    let bundle = Bundle.module
    let imageURL = bundle.url(forResource: "large", withExtension: "png")
    return try! Data(contentsOf: imageURL!)
}

public func imageData(filename: String = "1556181D-AF21-468E-9B17-72FA7469D469") -> Data {
    let bundle = Bundle.module
    guard let imageURL = bundle.url(forResource: filename, withExtension: "png") 
            else { 
        print("image not found: \(filename)")
        return Data() }
    return try! Data(contentsOf: imageURL)
}

public func allImageData() -> [Data] {
    let bundle = Bundle.module
    guard let allImagesURL = bundle.urls(forResourcesWithExtension: "png", subdirectory: nil) else { return [] }
    return allImagesURL.map { imageURL in
        let filenameWithoutExtension = imageURL.deletingPathExtension().lastPathComponent
        return imageData(filename: filenameWithoutExtension)
    }
}


extension Logger {
    public static let subsystem = "\(Bundle.module.bundleIdentifier!)"
    public static let source = Logger(subsystem: subsystem, category: "PDF_Reporting (main)")
}
