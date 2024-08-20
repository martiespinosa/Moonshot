//
//  ContentView.swift
//  Moonshot
//
//  Created by Martí Espinosa Farran on 16/6/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: CrewView.CrewMember.self) { crewMember in
                AstronautView(astronaut: crewMember.astronaut)
            }
            .navigationTitle("Moonshot")
            .background(Color.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Grid/List", systemImage: showingGrid ? "rectangle.grid.1x2" : "square.grid.2x2") {
                        withAnimation {
                            showingGrid.toggle()
                        }
                    }
                    .tint(.white)
                }
            }
        }
    }
}

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color.lightBackground)
                        }
                        //.background(LinearGradient(colors: [.lightBackground, .darkBackground], startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.lightBackground, lineWidth: 3)
                        )
                        .padding(4)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(mission.displayName)
                                            .font(.title3.bold())
                                            .foregroundStyle(.white)
                                        
                                        Text(mission.formattedLaunchDate)
                                            .font(.subheadline)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.forward")
                                        .font(.title3)
                                        .tint(.white)
                                }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .background(Color.lightBackground)
                        }
                        //.background(LinearGradient(colors: [.lightBackground, .darkBackground], startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.lightBackground, lineWidth: 3)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
            }
        }
        .background(Color.darkBackground)
    }
}

#Preview {
    ContentView()
}
