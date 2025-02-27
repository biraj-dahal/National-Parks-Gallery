//
//  ContentView.swift
//  National Park Galleries
//
//  Created by Biraj Dahal on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var parks: [Park] = []
    
    var body: some View {
        ScrollView {
                LazyVStack {
                    ForEach(parks) { park in
                        Rectangle()
                            .aspectRatio(4/3, contentMode: .fit)
                        
                                .overlay(alignment: .bottomLeading) {
                                    Text(park.name)
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding()
                                }
                                .cornerRadius(16)
                                .padding(.horizontal)
                    }
                }
            }
        .padding()
        .onAppear(perform: {
            
            Task {
                await fetchParks()
            }
        })
    }
    
    
    private func fetchParks() async {
        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=ca&api_key=B8N92518ub5MkqNeyMkciHlqSaSEZwuGgos95sA9")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let jsonObjParks = try JSONDecoder().decode(ParksResponse.self, from: data)
            
            let parksData = jsonObjParks.data
            
            self.parks = parksData
            
            
        } catch{
            print(error.localizedDescription)
        }
        
    }}
                  
        
            
            
#Preview {
    ContentView()
}
