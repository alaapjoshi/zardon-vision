//
//  HomeView.swift
//  Zardon Vision
//
//  Created by Alaap Joshi on 5/13/23.
//

import SwiftUI
import AVFoundation
import Intents


struct HomeView: View {
    let gradient = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
    
    let message = "Welcome to Zardon Vision, "
    var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    @State private var showDropdown = false
    let synthesizer = AVSpeechSynthesizer()

    
    let panicMessage = "CLICK AGAIN TO CANCEL" //ADD MESSAGE FOR WHEN APP OPENS
    let panicMessage2 = "ALERTING FAMILY MEMBERS AND CALLING HOSPITAL" //ADD MESSAGE FOR WHEN APP OPENS

    func speak(_ message: String) {
        let utterance = AVSpeechUtterance(string: message)
        synthesizer.speak(utterance)
    }
    @State private var isDropdownVisible = false
    @State private var showWelcomeView = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                    HStack{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading], 20)

                            .overlay(
                                Text("Morning!")
                                    .position(x: 120, y: 27) // adjust position here
                                    .foregroundStyle(.gray)
                            )
                            .overlay(
                                Text("Daniel Brown")
                                    .position(x: 140, y: 55) // adjust position here
                                    .foregroundStyle(.black)
                                    .font(.system(size: 20))
                            )
                        
                            .overlay (
                                Image(systemName: "bell")
                                    .font(.system(size: 30.0))
                                    .position(x: 330, y: 42)
                                    .foregroundStyle(.gray)
                                
                            )
                    }

                    VStack {
                        ScrollView {
                            Text("Help Like You've Never Experienced Before")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                            ZStack {
                                Button(action: {
                                    speak(panicMessage)
                                    let seconds = 5.0
                                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                        speak(panicMessage2)
                                    }
                                }) {
                                    Text("PANIC")
                                        .font(.largeTitle)
                                        .padding(20)
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())
                                }
                                
                                Rectangle()
                                    .opacity(0.01)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                            }
                            HStack {
                                
                            }
                            .padding(10)
                            
                            ZStack {
                                NavigationLink(destination: TextView()) {
                                    Text("Text Recognition")
                                        .font(.largeTitle)
                                        .padding(20)
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())

                                }
                                
                                Rectangle()
                                    .opacity(0.01)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                            }
                            HStack {
                                
                            }
                            .padding(10)
                            
                            ZStack {
                                NavigationLink(destination: DescribeView()) {
                                    Text("Object Recognition")
                                        .font(.largeTitle)
                                        .padding(20)
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())
                                }

                                
                                Rectangle()
                                    .opacity(0.01)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                            }
                            HStack {
                                
                            }
                            .padding(7)
                            
                            
                            ZStack {
                                NavigationLink(destination: FacetimeView()) {
                                    Text("Human Help Center")
                                        .font(.largeTitle)
                                        .padding(20)
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .contentShape(Rectangle())
                                }
                                
                                Rectangle()
                                    .opacity(0.01)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                            }
                            HStack {
                                
                            }
                            .padding(10)
                            
                            
                            VStack {
                                Button(action: {
                                    isDropdownVisible.toggle()
                                    speak("QUICK APPS")
                                }) {
                                    Text("QUICK APPS")
                                        .font(.largeTitle)
                                        .padding(50)
                                        .frame(maxWidth: .infinity, maxHeight: 60)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                if isDropdownVisible {
                                    VStack {
                                        HStack {
                                            Button("Uber") {
                                                speak("Opening Uber")
                                                if let url = URL(string: "uber://") {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
                                            }
                                            .font(.headline)
                                            .padding()
                                            .background(Color.black)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            
                                            Button("Dominoes") {
                                                speak("Opening Dominoes")

                                                if let url = URL(string: "Domino's Pizza USA://") {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
                                            }
                                            .font(.headline)
                                            .padding()
                                            .background(Color.red)
                                            .foregroundColor(.blue)
                                            .cornerRadius(10)
                                            
                                            .padding()
                                        }
                                        HStack {
                                            Button("Uber Eats") {
                                                speak("Uber Eats")
                                                if let url = URL(string: "Uber Eats: Food Delivery://") {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
                                            }
                                            .font(.headline)
                                            .padding()
                                            .background(Color.black)
                                            .foregroundColor(.green)
                                            .cornerRadius(10)
                                            
                                            Button("Customize \(Image(systemName: "star"))") {
                                                if let url = URL(string: "Google://") {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
                                            }
                                            .font(.headline)
                                            .padding()
                                            .background(Color.yellow)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            
                                            .padding()
                                        }
                                        
                                        HStack {
                                            Button("Customize \(Image(systemName: "star"))") {
                                                if let url = URL(string: "Google://") {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
                                            }
                                            .font(.headline)
                                            .padding()
                                            .background(Color.yellow)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            
                                            
                                        }
                                        
                                    }
                                }
                            }

                            .navigationBarTitle("Zardon Vision")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                            
                            
                        }
                        
                    }
                }
                
            HStack {
                Spacer()
            }
            }
        .onAppear {
            speak(message)
        }



    }

}
        
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
