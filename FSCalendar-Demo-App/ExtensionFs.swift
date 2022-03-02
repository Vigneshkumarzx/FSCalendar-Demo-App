//
//  ExtensionFs.swift
//  FSCalendar-Demo-App
//
//  Created by vignesh kumar c on 28/02/22.
//

import Foundation
import FSCalendar

extension FSCalendar {
    func customizeCalenderAppearance() {
        self.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        
        self.appearance.headerTitleFont      = UIFont.init(name: "SourceSansPro-Bold", size: 18)
        self.appearance.weekdayFont          = UIFont.init(name:"SourceSansPro-Bold", size: 20)
        self.appearance.titleFont            = UIFont.init(name: "SourceSansPro-Regular", size: 18)
        
//        self.appearance.headerTitleColor     = .green
//        self.appearance.weekdayTextColor     = .green
        self.appearance.eventDefaultColor    = .black
        self.appearance.selectionColor       = .green
        self.appearance.titleSelectionColor  = .black
        self.appearance.todayColor           = .red
        self.appearance.todaySelectionColor  = .systemGray
        
        self.appearance.headerMinimumDissolvedAlpha = 0.0 // Hide Left Right Month Name
    }
}
