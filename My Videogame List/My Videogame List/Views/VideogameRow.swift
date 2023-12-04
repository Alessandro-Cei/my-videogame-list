//
//  VideogameRow.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

struct VideogameRow: View {
    
    var urlString: String
    var title: String
    
    var body: some View {
        GeometryReader { geo in
            HStack (spacing: 10){
                AsyncImage(url: URL(string: urlString))
                .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25)
                .cornerRadius(20)
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    VideogameRow(urlString: "https://fastly.picsum.photos/id/776/200/200.jpg?hmac=Rq9krBqm0Qss3AbgE4BjL1Iu891xLPTkf1xNf0ezp38", title: "Ciao")
}
