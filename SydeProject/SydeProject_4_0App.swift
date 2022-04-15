//
//  SydeProject_4_0App.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-22.
//
import Firebase
import SwiftUI

@main
struct SydeProject_4_0App: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
