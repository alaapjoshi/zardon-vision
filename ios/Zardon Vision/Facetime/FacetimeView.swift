//
//  FacetimeView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import SwiftUI
import AVFoundation
import AVFAudio

struct Contact: Identifiable {
        var id = UUID()
        var name: String
        var image: String
        var phoneNumber: String
        var availability: String
        var timezone: String
        var Bio: String
        var Hobbies: String
        var SocialMedihandles: String
}

let contacts = [ Contact (name: "John Doe", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "yes", timezone: "Eastern", Bio: "I like Baseball and long walks on the beach", Hobbies: "Mechanical Keyboards and cooking", SocialMedihandles: "@JohnDoe"),
Contact(name: "Jane Smith", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "no" ,timezone: "Eastern", Bio: "I like Baseball and long walks on the beach", Hobbies: "Mechanical Keyboards and cooking", SocialMedihandles: "@JaneSmith"),
Contact(name: "Bob Johnson", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "yes",timezone: "Western", Bio: "I like to play Valorant and make websites!", Hobbies: "Web development and PC Building", SocialMedihandles: "@BobJohnson"),
Contact(name: "Mark Davis", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "yes", timezone: "Pacific", Bio: "I'm a dog lover and enjoy hiking in my free time.", Hobbies: "Photography and reading", SocialMedihandles: "@EmilyDavis"),
Contact(name: "Mike Chen", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "no", timezone: "Eastern", Bio: "I'm a foodie and love exploring new restaurants in the city.", Hobbies: "Playing guitar and traveling", SocialMedihandles: "@MikeChen"),
Contact(name: "Samantha Lee", image: "person.crop.circle.fill", phoneNumber: "5555550100", availability: "yes", timezone: "Central", Bio: "I'm a coffee addict and enjoy trying different roasts.", Hobbies: "Yoga and painting", SocialMedihandles: "@SamanthaLee")
]

struct FacetimeView: View {
    let synthesizer = AVSpeechSynthesizer()
    let speechUtterance = AVSpeechUtterance(string: "Human Help Center")
    
    
    var body: some View {
                NavigationView {
                    List(contacts) { contact in
                        NavigationLink(destination: ContactDetailView(contact: contact)) {
                            ContactRowView(contact: contact)
                            
                        }
                    }
                    .navigationTitle("Human Help Center")
                    
                }
                .onAppear {
                                synthesizer.speak(speechUtterance)
                            }
    }
}

struct ContactRowView: View {
    let speechSynthesizer = AVSpeechSynthesizer()

    var contact: Contact
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: contact.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Text(contact.name)
                Spacer()
                if contact.availability == "yes" {
                    Button(action: {
                        facetime(phoneNumber: contact.phoneNumber)
                    }) {
                        Image(systemName: "video.fill")
                            .foregroundColor(.blue)
                    }
                } else {
                    Text("Not available")
                        .foregroundColor(.red)
                }
            }
        }

            }

}

struct ContactDetailView: View {
    var contact: Contact
    var body: some View {
        ScrollView {
            Image(systemName: contact.image)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text(contact.name)
                .font(.largeTitle)
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)

        
            
            
            Text(contact.phoneNumber)
                .font(.title2)
                .padding(10)
                .foregroundColor(.black)


            if contact.availability == "yes" {
                Text("Available")
                    .foregroundColor(.green)
                    .font(.title)
            } else {
                Text("Not Available")
                    .foregroundColor(.red)
                    .font(.title)
                    .foregroundColor(.black)


            }

            Text("Timezone: \(contact.timezone)")
                .font(.title2)
                .padding(10)
                .foregroundColor(.black)

            Text("Bio: \(contact.Bio)")
                .font(.title2)
                .padding(10)
                .foregroundColor(.black)


            Text("Hobbies: \(contact.Hobbies)")
                .font(.title2)
                .padding(10)
                .foregroundColor(.black)


            Text("Social Media Handles: \(contact.SocialMedihandles)")
                .font(.title2)
                .padding(10)
                .foregroundColor(.blue)
            
            Button(action: {
                            facetime(phoneNumber: contact.phoneNumber)
                        }) {
                            Text("Call")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
        }
        .background(Color.white) // set the background color to white
        //        .navigationTitle("Contacts")
        .navigationBarTitle("", displayMode: .inline)

    }
}
    
    struct FacetimeView_Previews: PreviewProvider {
        static var previews: some View {
            FacetimeView()
        }
    }
    private func facetime(phoneNumber:String) {
        if let facetimeURL:NSURL = NSURL(string: "facetime://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(facetimeURL as URL)) {
                application.open(facetimeURL as URL);
            }
        }
    }
