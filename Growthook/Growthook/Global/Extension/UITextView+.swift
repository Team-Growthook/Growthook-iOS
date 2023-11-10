//
//  UITextView+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

extension UITextView {
    
    func numberOfLines() -> Int {
        let layoutManager = layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        self.textContainerInset.left = amount
    }
}
