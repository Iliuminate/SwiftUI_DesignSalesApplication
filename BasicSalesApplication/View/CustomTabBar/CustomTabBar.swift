//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

enum Tab: String, CaseIterable  {
    case home = "house.fill"
    case cart = "cart.fill"
    case favourites = "star.fill"
    case account = "person.fill"
    
    var name: String {
        switch self {
        case .home: return "Home"
        case .cart: return "Cart"
        case .favourites: return "Favourites"
        case .account: return "Profile"
        }
    }
}

struct CustomTabBar: View {
    
    @Binding var currentTab: Tab
    @State var currrentXValue: CGFloat = 0
    var animation: Namespace.ID
    
    var body: some View {
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                        .overlay {
                            Text(tab.name)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Color.black)
                                .offset(y: currentTab == tab ? 12 : 100)
                        }
                }
            }
            .padding(.top)
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : 10)
            .background(
                Color.white
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    .clipShape(BottomCurve(currentXValue: currrentXValue))
                    .ignoresSafeArea(.container, edges: .bottom)
            )
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        
        GeometryReader { proxy in
            Button {
                withAnimation(.easeInOut) {
                    currentTab = tab
                    currrentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.8))
                    .padding(currentTab == tab ? 15 : 0 )
                    .background(
                        ZStack {
                            if currentTab == tab {
                                Circle()
                                    .fill(Color.orange)
                                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 5, y: -5)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            .onAppear {
                if tab == Tab.allCases.first && currrentXValue == 0 {
                    currrentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero}
        return safeArea
    }
}
