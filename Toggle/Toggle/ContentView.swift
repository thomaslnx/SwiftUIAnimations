//
//  ContentView.swift
//  Toggle
//
//  Created by Marcos Moura on 06/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var toggled = false
    @State private var animating = false
    @State private var scale: CGFloat = 1
    
    @State private var waveSize: CGFloat = 0
    @State private var opacity: Double = 0
    @State private var circleColor: Color = .white
    
    var body: some View {
        ZStack {
            offWhite.edgesIgnoringSafeArea(.all)
            
            Circle()
                .stroke(lineWidth: 15)
                .fill(offWhite)
                .frame(width: self.waveSize, height: self.waveSize)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -2.5, y: -2.5)
                .blur(radius: 5)
                .opacity(self.opacity)
                .offset(x: toggled ? toggleSize / 4 : -(toggleSize / 4))
            
            Capsule()
                .frame(width: toggleSize, height: toggleSize / 2)
                .foregroundColor(offWhite)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5 , y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -2.5, y: -2.5)
            
            ZStack{
                Capsule()
                    .stroke(offWhite, lineWidth: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.7), radius: 2, x: -2.5, y: -2.5)
                    .clipShape(Capsule())
                    .frame(width: toggleSize, height: toggleSize / 2)
            }
            
            ZStack {
                Circle()
                    .foregroundColor(offWhite)
                    .frame(width: (toggleSize / 2) - (toggleSize * 0.1), height: (toggleSize / 2) - (toggleSize * 0.1))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.7), radius: 5, x: -2.5, y: -2.5)
                
                ZStack{
                    Circle()
                        .stroke(circleColor, lineWidth: 5)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                        .clipShape(
                            Circle()
                        )
                        .shadow(color: Color.white.opacity(0.7), radius: 2, x: -2.5, y: -2.5)
                        .clipShape(
                            Circle()
                        )
                }
                .frame(width: toggleSize / 5, height: toggleSize / 5)
            }
            .scaleEffect(scale)
            .offset(x: toggled ? toggleSize / 4 : -(toggleSize / 4))
            .onTapGesture {
                if !animating {
                    animating = true
                    withAnimation(Animation.easeOut(duration: toggleTime)) {
                        toggled.toggle()
                    }
                    withAnimation(Animation.easeIn(duration: (toggleTime / 2) + (toggleTime / 4))) {
                        scale = 2
                        if toggled {
                            circleColor = .green
                        } else {
                            circleColor = .gray
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + (toggleTime / 2 ) + (toggleTime / 4)) {
                        withAnimation(Animation.easeOut(duration: toggleTime / 4)) {
                            scale = 1
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + toggleTime) {
                        opacity = 1
                        withAnimation(Animation.easeOut(duration: toggleTime)) {
                            waveSize += 300
                            opacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + toggleTime) {
                            waveSize = (toggleSize / 2) - (toggleSize * 0.075)
                            animating = false
                        }
                    }
                }
            }
            .onAppear {
                waveSize = (toggleSize / 2) - (toggleSize * 0.075)
                circleColor = .gray
            }
        }
    }
    
    let toggleSize: CGFloat = 150
    let offWhite = Color(red: 255 / 255, green: 255 / 255, blue: 235 / 255)
    let toggleTime: Double = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
