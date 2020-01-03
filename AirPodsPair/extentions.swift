//
//  extentions.swift
//  AirPodsPair
//
//  Created by Joe Manto on 1/3/20.
//  Copyright © 2020 Joe Manto. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
