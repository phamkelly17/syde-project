//
//  SecondInfoView.swift
//  SydeProject_4.0
//
//  Created by Kelly Pham on 2022-02-25.
//

import SwiftUI

struct SecondInfoView: View {
    //Image
    @State private var showImagePicker = false
    @State private var selectedImage = UIImage(systemName: "person.crop.circle.fill")
    @State private var profileImage = Image(systemName: "person.crop.circle.fill")
    
    @State private var fullname = ""
    @State private var headerText = ""
    @State private var about = ""
    @State var skillsList:[String] = []
    @State var interestsList:[String] = []
    @State private var school = ""
    @State private var city = ""
    @State private var linkedin = ""
    @State private var instagram = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image("friends-icon")
                    .resizable()
                    .frame(width:50, height:50)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(10)
                    Text("Now let's enter some info for friends looking at your profile.")
                
                Spacer()
            }
            
            ScrollView {
                LazyVStack {
                    
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        VStack {
                            profileImage
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)

                            Text("Add profile photo")
                                .foregroundColor(.black)
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    .padding(.vertical,45)
                    
                    CustomInputField(imageName: "person",
                                     placeholderText: "Full Name",
                                    text: $fullname)
                                    .foregroundColor(.black)
                                    .padding(.vertical)
                    
                    TextArea("A short header about you",text: $headerText,"person.text.rectangle")
                        .frame(height: 75)
                        .padding(.vertical)
                    
                    TextArea("Decription about you",text: $about,"person")
                        .frame(height: 100)
                        .padding(.vertical)
                    
                    AddSkillsView(placeholder:"Add your skills", skillsList:$skillsList)
                        .padding(.vertical)
                    
                    AddInterestsView(placeholder:"Add your interests", interestsList:$interestsList)
                    
                    AdditionalInfoView(school:$school, city:$city, linkedin:$linkedin, instagram:$instagram)
                    
                    
                    if let selectedImage = selectedImage {
                        Button {
                            viewModel.updateUserData(fullname, headerText, about, skillsList, interestsList, school, city, linkedin, instagram, viewModel.tempUserSession, true)
                            viewModel.uploadImage(selectedImage, viewModel.tempUserSession, true)
                        } label: {
                            Text("Continue")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 340, height: 50)
                                .background(Color(.purple))
                                .clipShape(Capsule())
                                .padding()
                        }
                    }
               

                }
            }
            

        }
        .padding()
        .navigationBarTitle("title")
        .navigationBarHidden(true)

    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

