//
//  Home.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI


enum CustomMenuOptions: String, CaseIterable {
    case all = "All"
    case chair = "Chair"
    case table = "Table"
    case lamp = "Lamp"
    case flor = "Flor"
}

struct Home: View {
    
    @EnvironmentObject var appModel: AppViewModel
    var animation: Namespace.ID
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Bets Options")
                        .font(.title.bold())
                    
                    Text("Perfect Choice")
                        .font(.callout)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    // MARK: - Search bar
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black.opacity(0.6))
                        
                        TextField("Search", text: .constant(""))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    
                    // MARK: - Config button
                    Button { } label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            )
                    }
                }
                
                // MARK: - Custom menu options
                CustomMenu()
                
                // MARK: - Furnitures view
                ForEach(furnitures) { furniture in
                    CardView(furniture: furniture)
                }
            }
            .padding(.bottom, 100)
        }
        .padding()
    }
    
    @ViewBuilder
    func CardView(furniture: Furniture) -> some View {
        HStack(alignment: .top, spacing: 12) {
            
            Group {
                if appModel.currentActiveItem?.id == furniture.id,
                   appModel.showDetailView {
                    Image(furniture.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(furniture.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: furniture.id + "IMAGE", in: animation)
                }


            }
            .frame(width: 120, height: 120)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color("CardBG"))
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                Group {
                    if appModel.currentActiveItem?.id == furniture.id,
                       appModel.showDetailView {
                        Text(furniture.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .opacity(0)
                        
                        Text("by Ilmint")
                            .font(.caption.bold())
                            .foregroundColor(.gray)
                            .padding(.top, -5)
                            .opacity(0)
                    } else {
                        Text(furniture.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: furniture.id + "TITLE", in: animation)
                        
                        Text("by Ilmint")
                            .font(.caption.bold())
                            .foregroundColor(.gray)
                            .padding(.top, -5)
                            .matchedGeometryEffect(id: furniture.id + "AUTHOR", in: animation)
                    }
                }
                
                
                
                Text(furniture.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.8))
                
                HStack {
                    Text(furniture.prize)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button { }
                    label: {
                        Text("Add")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background {
                                Capsule()
                                    .fill(.orange)
                            }
                            .frame(minWidth: 80)
                    }
                    .scaleEffect(0.9)
                }
                .offset(y: 10)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
        .onTapGesture(perform: {
            withAnimation(.easeInOut) {
                appModel.currentActiveItem = furniture
                appModel.showDetailView = true
            }
        })
        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
    
    
    @ViewBuilder
    func CustomMenu() -> some View {
        HStack(spacing: 6) {
            ForEach(CustomMenuOptions.allCases, id: \.rawValue) { menuItem in
                Text(menuItem.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(appModel.currentMenu != menuItem ? .black : .white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background {
                        if appModel.currentMenu == menuItem {
                            Capsule()
                                .fill(.purple)
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .matchedGeometryEffect(id: "MENU", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) { appModel.currentMenu = menuItem }
                    }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppViewModel.init())
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
        
        MainView()
            .environmentObject(AppViewModel.init())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
