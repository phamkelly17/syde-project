//
//  FriendRowView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-14.
//

import SwiftUI
import Kingfisher

struct FriendRowView: View {
    let user: User
    
    var body: some View {
        

        HStack{
            
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(15)

                
            VStack(alignment: .leading) {
                Text(user.fullname)
                    .foregroundColor(.black)
                    .font(.headline)
                Text(user.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(user.header)
                    .font(.caption)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
            }
            
            Spacer()

        }
        .padding(.horizontal)
    }
}
