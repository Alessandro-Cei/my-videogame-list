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
        HStack (spacing: 10){
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(.systemGray5))
            }
            Text(title)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    VideogameRow(urlString: "https://fastly.picsum.photos/id/776/200/200.jpg?hmac=Rq9krBqm0Qss3AbgE4BjL1Iu891xLPTkf1xNf0ezp38", title: "GTAV")
}
