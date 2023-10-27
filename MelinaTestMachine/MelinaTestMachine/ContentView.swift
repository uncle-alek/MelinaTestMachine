//
//  ContentView.swift
//  MelinaTestMachine
//
//  Created by Aleksey Yakimenko on 27/10/23.
//

import SwiftUI

struct ContentView: View {

    @State private var inputText1 = ""
    @State private var inputText2 = ""
    @State private var inputText3 = ""
    @State private var inputText4 = ""
    @State private var inputText5 = ""

    @State private var isVisible = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("SwiftUI Complex Screen")
                        .font(.title2)
                        .padding()
                    if isVisible {
                        TapGestureView(title: "Tappable view")
                            .accessibilityElement()
                            .accessibilityLabel("Hello world")
                            .accessibilityIdentifier("Tappable view")
                    }
                    Divider()

                    VStack {
                        TextField("Input Field 1", text: $inputText1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .accessibilityIdentifier("TextField 1")
                        TextField("Input Field 2", text: $inputText2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Input Field 3", text: $inputText3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Input Field 4", text: $inputText4)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Input Field 5", text: $inputText5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    Divider()

                    ForEach(0..<150) { item in
                        HStack {
                            Text("Dynamic VStack \(item)")
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .padding()
                    }

                    VStack {
                        Button(action: {
                            print("Button 1 tapped with text: \(inputText1)")
                        }) {
                            Text("Button 1")
                        }
                        .accessibilityIdentifier("Button X")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                            print("Button 2 tapped with text: \(inputText2)")
                        }) {
                            Text("Button 2")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                            print("Button 3 tapped with text: \(inputText3)")
                        }) {
                            Text("Button 3")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                            print("Button 4 tapped with text: \(inputText4)")
                        }) {
                            Text("Button 4")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {
                            print("Button 5 tapped with text: \(inputText5)")
                        }) {
                            Text("Button 5")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    Divider()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(1...6, id: \.self) { index in
                                Button(action: {
                                    print("Button \(index) pressed")
                                }) {
                                    Text("Button \(index) horizontal")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                    }

                    NavigationLink(destination: SecondView()) {
                        Text("Navigate to Second View")
                    }
                }
                .padding()
            }
            .accessibilityIdentifier("Scroll view")
            .navigationBarTitle("Complex SwiftUI Screen")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        self.isVisible = true
                    }
                }
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is a second view!")
            .navigationBarTitle("Second View")
    }
}

struct TapGestureView: View {
    let title: String
    @State private var showingPopup = false

    var body: some View {
        Text(title)
            .font(.title)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .onTapGesture {
                self.showingPopup = true
            }
            .sheet(isPresented: $showingPopup) {
                PopupView()
                    .accessibilityElement()
                    .accessibilityIdentifier("Popup")
            }
    }
}

struct PopupView: View {

    var body: some View {
        VStack {
            Text("This is a popup")
                .frame(width: 200, height: 200)
                .background(Color.orange)
                .cornerRadius(10)
        }
    }
}
