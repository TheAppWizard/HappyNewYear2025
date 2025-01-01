//
//  ContentView.swift
//  HNY2025
//
//  Created by Shreyas Vilaschandra Bhike on 31/12/24.
//

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            FireworksView()
            Titles()
                .offset(y:-200)
        }
    }
}

#Preview {
    ContentView()
}












struct Titles: View {
    var body: some View {
        VStack{
            Text("Happy New Year")
                .foregroundStyle(.white).opacity(0.3)
                .font(.system(size: 38))
            
            Text("2025")
                .foregroundStyle(.white)
                .font(.system(size: 72))
        }
    }
}


struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGPoint
    var color: Color
    var opacity: Double = 1.0
    var scale: CGFloat = 2.0
}

struct FireworksView: View {
    @State private var particles: [Particle] = []
    @State private var timer: Timer?
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: 4, height: 4)
                        .scaleEffect(particle.scale)
                        .opacity(particle.opacity)
                        .position(particle.position)
                }
            }
            .onAppear {
                startFireworks(in: geometry.size)
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    
    func startFireworks(in size: CGSize) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.013, repeats: true) { _ in
            if Int.random(in: 0...30) < 2 {
                createFirework(in: size)
            }
            updateParticles()
        }
    }
    
    func createFirework(in size: CGSize) {
        let origin = CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: CGFloat.random(in: size.height/2...size.height)
        )
        
        for _ in 0..<50 {
            let angle = Double.random(in: 0...(2 * .pi))
            let speed = CGFloat.random(in: 2...5)
            let particle = Particle(
                position: origin,
                velocity: CGPoint(
                    x: cos(angle) * speed,
                    y: sin(angle) * speed
                ),
                color: colors.randomElement() ?? .white
            )
            particles.append(particle)
        }
    }
    
    func updateParticles() {
        particles = particles.compactMap { particle in
            var newParticle = particle
            newParticle.position.x += particle.velocity.x
            newParticle.position.y += particle.velocity.y
            newParticle.velocity.y += 0.1 // gravity
            newParticle.opacity -= 0.02
            newParticle.scale -= 0.01
            
            return newParticle.opacity > 0 ? newParticle : nil
        }
    }
}
