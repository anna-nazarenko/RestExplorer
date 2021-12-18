//
//  ImageView.swift
//  RestExplorer
//
//  Created by Anna on 16.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    init(with url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(with: "https://fastly.4sqi.net/img/general/800x600/72662939_s6vkd5D3NrprMH9JkZRgRX-zDGetx9cm0PB6BEKLjBg.jpg")
    }
}
