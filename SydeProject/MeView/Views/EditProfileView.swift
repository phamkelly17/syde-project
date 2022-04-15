//
//  EditProfileView.swift
//  SydeProject
//
//  Created by Kelly Pham on 2022-02-15.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {

    @State private var showImagePicker = false
    @State private var selectedImage = UIImage(systemName: "person.crop.circle.fill")
    @State private var profileImage = Image(systemName: "person.crop.circle.fill")
    @State private var imageChanged = false
    @State private var savedProfile = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showEditProject = false
    @State private var removeInterests = false
    @State var name: String
    @State var header: String
    @State var about: String
    @State private var typeSkill = ""
    @State private var typeInterest = ""
    @State var skillsList: [String]
    @State var interestsList: [String]
    @State var school: String
    @State var city: String
    @State var email: String
    @State var linkedin: String
    @State var instagram: String
    @State var profileImageURL: String

    var body: some View {
        VStack (alignment: .leading){
            
            PageHeaderView(title:"Edit Profile")
                .padding(.vertical)
            ScrollView {
                LazyVStack {
                    editHeader
                    editAbout
                    editSkills
                    editInterests
                    editAdditional
                    saveButton
                    
                }
                .padding(.vertical, 30)
            }
        }

    }
}

extension EditProfileView {
    var editHeader: some View {
        HStack{
            VStack(alignment: .leading){
                if !imageChanged {
                    KFImage(URL(string: profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width:75, height:75)
                        .cornerRadius(15)
                        .padding()
                }
                else {
                    profileImage
                        .resizable()
                        .frame(width:75, height:75)
                        .cornerRadius(15)
                        .padding()
                }

                
                Button{
                    showImagePicker.toggle()
                } label: {
                    Text("Change Image")
                        .font(.caption)
                        .foregroundColor(.purple)
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
            
            VStack {
                CustomInputField(imageName: "person",
                                 placeholderText: "Full Name",
                                 text: $name)
                
                TextArea("Header",text: $header,"person.text.rectangle")
                    .frame(height: 75)
            }
        }
        .padding()
    }
    
    
    var editAbout: some View {
        VStack (alignment: .leading){
            Text("About")
                .font(.title2)
                .fontWeight(.bold)
            
            TextArea("About",text: $about,"person")
        }
        .padding()
    }
    
    var editSkills: some View {
        VStack(alignment: .leading){
            Text("Skills")
                .font(.title2)
                .fontWeight(.bold)
            
            AddSkillsView(placeholder:"", skillsList:$skillsList)
        }
        .padding()

    }
    
    var editInterests: some View {
        VStack(alignment: .leading){
            Text("Interests")
                .font(.title2)
                .fontWeight(.bold)
            AddInterestsView(placeholder:"",interestsList:$interestsList)
        }
        .padding()

    }
    
    var editAdditional: some View {
        AdditionalInfoView(school: $school, city: $city, linkedin: $linkedin, instagram: $instagram)
    }
    
    var saveButton: some View {
        HStack {
            Spacer()
            if let selectedImage = selectedImage {
                Button {
                    if imageChanged {
                        authViewModel.uploadImage(selectedImage, authViewModel.userSession, false)
                    }
                    authViewModel.updateUserData(name, header, about, skillsList, interestsList, school, city, linkedin, instagram, authViewModel.userSession, false)
                    
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save Profile")
                        .padding(8)
                        .font(.headline)
                        .foregroundColor(.black)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(10)
                    
                }
            }

        }
        .padding(.horizontal)
    }
    
    func loadImage() {
        imageChanged = true
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }

}
