//
//  MainView.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - View Properties -
    @StateObject var appModel: AppViewModel = .init()
    
    // MARK: - Animation properties -
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $appModel.currentTab) {
            Home(animation: animation).environmentObject(appModel)
                .tag(Tab.home)
                .setUpTab()
            
            Text("Cart")
                .tag(Tab.cart)
                .setUpTab()
            
            Text("Favourite")
                .tag(Tab.favourites)
                .setUpTab()
            
            Text("Profile")
                .tag(Tab.account)
                .setUpTab()
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $appModel.currentTab, animation: animation)
                .offset(y: appModel.showDetailView ? 150 : 0)
        }
        .overlay {
            if let furniture = appModel.currentActiveItem, appModel.showDetailView {
                DetailView(furniture: furniture, animation: animation)
                    .environmentObject(appModel)
            }
        }
    }
}


extension View {
    @ViewBuilder
    func setUpTab() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG").ignoresSafeArea())
    }
}

// MARK: - Previews -
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
