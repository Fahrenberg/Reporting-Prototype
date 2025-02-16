//
//  ------------------------------------------------------------
//  ---------------       PDF-Reporting+Extension     --------------
//  ---------------                               --------------
//  ------------------------------------------------------------

import Foundation
import OSLog
import Extensions



#if canImport(UIKit)
import UIKit

extension UIImage {
    /// Returns a new image with all transparent pixels replaced by the specified background color.
    /// - Parameter backgroundColor: The color to use for the background (default is white).
    /// - Returns: A new UIImage with a solid background.
    func replacingTransparentPixels(with backgroundColor: UIColor = .white) -> UIImage? {
        let rect = CGRect(origin: .zero, size: self.size)
        
        // Use UIGraphicsImageRenderer to create a new image context.
        let renderer = UIGraphicsImageRenderer(size: self.size)
        return renderer.image { context in
            // Fill the background with the specified color.
            backgroundColor.setFill()
            context.fill(rect)
            
            // Draw the original image over the background.
            self.draw(in: rect)
        }
    }
}
#elseif canImport(AppKit)
import AppKit

extension NSImage {
    /// Returns a new image with all transparent pixels replaced by the specified background color.
    /// - Parameter backgroundColor: The color to use for the background (default is white).
    /// - Returns: A new NSImage with a solid background, or nil if the operation fails.
    func replacingTransparentPixels(with backgroundColor: NSColor = .white) -> NSImage? {
        let newImage = NSImage(size: self.size)
        let rect = NSRect(origin: .zero, size: self.size)
        
        newImage.lockFocus()
        
        // Fill the background with the specified color.
        backgroundColor.setFill()
        NSBezierPath(rect: rect).fill()
        
        // Draw the original image over the background using the source-over compositing operation.
        self.draw(in: rect,
                  from: NSRect(origin: .zero, size: self.size),
                  operation: .sourceOver,
                  fraction: 1.0)
        
        newImage.unlockFocus()
        return newImage
    }
}
#endif
