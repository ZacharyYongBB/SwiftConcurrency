//
//  SwiftConcurrencyApp.swift
//  SwiftConcurrency
//
//  Created by Zachary on 12/2/23.
//

import SwiftUI

@main
struct SwiftConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            AsyncDownloadImage()
        }
    }
}
