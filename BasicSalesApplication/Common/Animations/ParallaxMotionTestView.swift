//
//  ParallaxMotionTestView.swift
//  BasicSalesApplication
//
//  Created by Carlos Diaz on 30/08/22.
//

import SwiftUI

struct ParallaxMotionTestView: View {

    @ObservedObject var manager = MotionManager()
    
    var body: some View {
        Color.red
            .frame(width: 100, height: 100, alignment: .center)
            .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
    }
}
