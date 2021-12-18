//
//  DetailView.swift
//  RestExplorer
//
//  Created by Anna on 16.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var photoManager = PhotoManager()
    
    var restaurant: Restaurant?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(restaurant?.name ?? "")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    Text("\(restaurant?.location.address ?? ""), \(restaurant?.location.locality ?? "")")
                    ForEach(photoManager.photos, id: \.self) { photo in
                        ImageView(with: "\(photo.prefix)800x600\(photo.suffix)")
                            .padding(.leading)
                            .padding(.trailing)
                    }
                }
                .padding(.top, 20)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }
        .onAppear {
            if let safeID = self.restaurant?.fsq_id {
                self.photoManager.fetchPhoto(id: safeID)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
