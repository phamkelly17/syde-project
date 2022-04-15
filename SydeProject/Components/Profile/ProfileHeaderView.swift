//
//  ProfileHeaderView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-15.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let fullname: String
    let header: String
    let profileImage:String
    var body: some View {
        HStack (alignment: .top, spacing: 20){
            KFImage(URL(string: profileImage))
                .resizable()
                .scaledToFill()
                .frame(width:75, height:75)
                .cornerRadius(15)
            
            VStack (alignment: .leading) {
                Text(fullname)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(header)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
    }
}
