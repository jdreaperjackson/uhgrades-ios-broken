//
//  UHGradesApp.swift
//  Shared
//
//  Created by John D. Jackson on 9/19/21.
//

import SwiftUI

@main
struct Music_SearchApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: GradeListViewModel())
        }
    }
}
