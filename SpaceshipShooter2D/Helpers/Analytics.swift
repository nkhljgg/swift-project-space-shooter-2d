//
//  AnalyticsManager.swift
//  SpaceshipShooter2D
//
//  Created by Nikhil Jaggi on 02/10/21.
//

import UIKit
import Foundation

class Analytics: NSObject{

    static let sharedInstance = Analytics()

    override init() {
        super.init()
        // Configure 3rd party SDKs here
    }
}

extension Analytics {
    
    func trackScene(_ name: String) {
        // TODO: Implement tracking
    }
    
}
