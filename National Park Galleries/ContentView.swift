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
        NavigationStack{
            ScrollView {
                LazyVStack {
                    ForEach(parks) { park in
                        NavigationLink(value: park){
                            ParkRow(park: park)
                        }
                        
                        
                    }
                }
            }
            .navigationDestination(for: Park.self){ park in
                ParkDetailView(park: park)
            }
            .navigationTitle("National Parks")
            .padding()
            
        }
        
        .onAppear(perform: {
            
            Task {
                await fetchParks()
            }
        })
    }
    
    
    
    private func fetchParks() async {
        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key=B8N92518ub5MkqNeyMkciHlqSaSEZwuGgos95sA9")!
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let jsonObjParks = try JSONDecoder().decode(ParksResponse.self, from: data)
            
            let parksData = jsonObjParks.data
            
            self.parks = parksData
            
            
        } catch{
            print(error.localizedDescription)
        }
        
    }}
                  

struct ParkRow: View {
    var park: Park
    var body: some View {
        Rectangle()
            .aspectRatio(4/3, contentMode: .fit)
            .overlay{
                let image = park.images.first
                let imageUrlString = image?.url
                let imageUrl = imageUrlString.flatMap { string in URL(string: string)
                }
                
                AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color(.systemGray4)
                    }
            }
        
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
            
            
#Preview {
    ContentView()
}
