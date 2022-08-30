//
//  AppViewModel.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

class AppViewModel: ObservableObject {
    
    @Published var currentTab: Tab = .home
    
    @Published var currentMenu: CustomMenuOptions = .all
    
    @Published var showDetailView: Bool = false
    
    @Published var currentActiveItem: Furniture?
}
