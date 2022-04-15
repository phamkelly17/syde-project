//
//  AboutView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-15.
//

import SwiftUI

struct AboutView: View {
    let aboutText: String
    let skillsList: [String]
    let interestsList: [String]
    let school: String
    let city: String
    let email: String
    let linkedin: String
    let instagram: String

    //var additionalArray:[[String]]
    //@State var skillsList = ["HTML","CSS","Swift","UI/UX","Python","JavaScript","SQLite","React.js"]
    //@State var  interestsList = ["Web Development", "UI/UX", "Mobile Apps", "Game Development", "Chrome Extensions", "Frontend", "Backend"]
    var body: some View {
        VStack(alignment: .leading){
            about
            skills
            interests
            additional
        }
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(aboutText:"", skillsList: [], interestsList: [],school: "", city: "",email: "",linkedin: "",instagram: "")
    }
}

extension AboutView {

    var about: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.title2)
                .fontWeight(.bold)
            Text(aboutText)
                .font(.caption)
                .padding(.vertical,1)
        }
    }
    var skills: some View {
        
        VStack(alignment: .leading) {
            Text("Skills")
                .font(.title2)
            .fontWeight(.bold)
            ConstantWrappedTags(tags: skillsList)
        }
        .padding(.vertical)
    }
    
    var interests: some View {
        
        VStack(alignment: .leading) {
            Text("Interests")
                .font(.title2)
            .fontWeight(.bold)
            ConstantWrappedTags(tags: interestsList)
        }
        .padding(.vertical)
    }
    
    var additional: some View {
        VStack(alignment: .leading){
            HStack{
                Text("School")
                    .font(.headline)
                Text(school)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }

            HStack{
                Text("City:")
                    .font(.headline)
                Text(city)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            
            HStack{
                Text("Email")
                    .font(.headline)
                Text(email)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }
            

            HStack {
                Text("Linkedin")
                    .font(.headline)
                Text(linkedin)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }

            HStack{
                Text("Instagram")
                    .font(.headline)
                Text(instagram)
                    .padding(5)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(5)
            }

             
        }
        
    }
}
