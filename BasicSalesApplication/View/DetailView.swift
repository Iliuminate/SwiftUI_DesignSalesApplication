//
//  DetailView.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 29/08/22.
//

import SwiftUI

struct DetailView: View {
    
    var furniture: Furniture
    var animation: Namespace.ID
    
    @EnvironmentObject var appModel: AppViewModel
    
    @State var showDetailContent: Bool = false
    @State var activeColor: String = "color1"
    @State var cartCount: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            VStack {
                // MARK: Custom Nav Bar
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            showDetailContent = false
                        }
                        withAnimation(.easeInOut.delay(0.05)) {
                            appModel.showDetailView = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.red)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            }
                    }
                }
                .padding()
                .opacity(showDetailContent ? 1 : 0)
                
                // MARK: Furniture image
                Image(furniture.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: furniture.id + "IMAGE", in: animation)
                    .frame(height: size.height / 3.0)
                
                
                // MARK: Body
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(furniture.title)
                                .font(.title.bold())
                                .foregroundColor(.black)
                                //.fixedSize()
                                .matchedGeometryEffect(id: furniture.id + "TITLE", in: animation)
                            
                            Text("by Ilmint")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.top, -5)
                                //.fixedSize()
                                .matchedGeometryEffect(id: furniture.id + "AUTHOR", in: animation)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // MARK: Rating
                        Label {
                            Text("3.1")
                                .font(.callout)
                                .fontWeight(.bold)
                        } icon: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .strokeBorder(.black.opacity(0.2), lineWidth: 1)
                        }
                        .scaleEffect(0.8)
                    }
                    
                    Text("Antes de nada deberás reunir los materiales necesarios para realizar la transferencia. Además de la imagen impresa en un papel de buena calidad necesitarás un carboncillo, un pincel suave, un bolígrafo, pintura, cinta adhesiva y barniz. Antes de nada deberás reunir los materiales necesarios para realizar la transferencia. Además de la imagen impresa en un papel de buena calidad necesitarás un carboncillo, un pincel suave, un bolígrafo, pintura, cinta adhesiva y barniz.")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                    
                    // MARK: Color selection
                    HStack(spacing: 10) {
                        Text("Color")
                            .font(.callout.bold())
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                        
                        
                        ForEach(["color1", "color2", "color3", "color4"], id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 20, height: 20)
                                .background {
                                    Circle()
                                        .strokeBorder(.black)
                                        .padding(-4)
                                        .opacity(activeColor == color ? 1 : 0)
                                }
                                .onTapGesture {
                                    activeColor = color
                                }
                        }
                        
                        Spacer()
                        
                        // MARK: Custom stepper
                        HStack(spacing: 10) {
                            Image(systemName: "minus").onTapGesture {
                                if cartCount > 0 { cartCount -= 1 }
                            }
                            
                            Text("\(cartCount)")
                            
                            Image(systemName: "plus").onTapGesture { cartCount += 1 }
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background {
                            Capsule()
                                .fill(.black.opacity(0.1))
                        }
                        .scaleEffect(0.8)
                    }
                    
                    // MARK: Summary
                    Spacer(minLength: 5)
                    
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .frame(height: 1)
                    
                    HStack {
                        Text(furniture.prize)
                            .font(.largeTitle.bold())
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Buy Now")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 30)
                                .background {
                                    Capsule().fill(.orange)
                                }
                            
                        }
                    }
                    .padding(.bottom, 5)
                }
                .padding(.top, 35)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .opacity(showDetailContent ? 1 : 0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background() {
            Color("BG")
                .ignoresSafeArea()
                .opacity(showDetailContent ? 1 : 0)
        }
        .onAppear() {
            withAnimation(.easeInOut) {
                showDetailContent = true
            }
        }
    }
}

// MARK: - Previews -
struct DetailView_Previews: PreviewProvider {
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
