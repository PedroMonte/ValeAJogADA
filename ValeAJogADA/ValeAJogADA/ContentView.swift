//
//  ContentView.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 13/05/24.
//

import SwiftUI

var jogos1 = ["1", "2", "3"]
var jogos2 = ["1", "2", "3", "4"]



struct ContentView: View {
    @State var popupOn = false
    @State var selectedGame1 = "Castles of Burgundy"
    @State var selectedGame5 = "4"
    var body: some View {
        ZStack(alignment: .top) {
            Color.branco
            VStack (alignment: .center, spacing: 16) {
                
                ZStack {
                    
                    Color(.azulescuro)
                        .cornerRadius(40)
                        .ignoresSafeArea()
                        .frame(height: 100)
                    
                    Text("Vale a JogADA?")
                    
                        .font(.display)
                    
                        .foregroundStyle(.amarelo)
                }
                
                HStack {
                    Text("Escolha 4 jogos que você adora!")
                        .font(.header1)
                    
                    Image("dado")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                HStack {
                    ZStack {
                        Image("cartaA")
                        Picker ("", selection: $selectedGame1){
                            ForEach (jogos1, id: \.self) { jogo in
                                Text(jogo).tag(jogo)
                                    .font(.header2)
                            }
                        }
                    }
                    ZStack {
                        Image("carta2")
                        Picker ("", selection: $selectedGame1){
                            ForEach (jogos1, id: \.self) { jogo in
                                Text(jogo).tag(jogo)
                                    .font(.header2)
                            }
                        }
                    }
                }
                HStack {
                    ZStack {
                        Image("carta3")
                        Picker ("", selection: $selectedGame1){
                            ForEach (jogos1, id: \.self) { jogo in
                                Text(jogo).tag(jogo)
                                    .font(.header2)
                            }
                        }
                    }
                    ZStack {
                        Image("carta4")
                        Picker ("", selection: $selectedGame1){
                            ForEach (jogos1, id: \.self) { jogo in
                                Text(jogo).tag(jogo)
                                    .font(.header2)
                            }
                        }
                    }
                }
                
                
                
                VStack {
                    Text("Escolha um jogo para descobrir")
                        .font(.header1)
                    Text("se vale a jogADA!")
                        .font(.header1)
                }
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack (spacing: 16) {
                        ForEach (jogos2, id: \.self) { jogo in
                            
                            Button(action: {
                                selectedGame5 = jogo
                            }) {
                                ZStack {
                                    if selectedGame5 == jogo {
                                        Color.azulescuro
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(20)
                                    } else {
                                        Color.azulclaro
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(20)
                                    }
                                    Text(jogo)
                                        .font(.header2)
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                }.padding(.leading, 24)
                    .padding(.trailing, 24)
                
                Spacer()
                
                ZStack {
                    Color(.azulescuro)
                        .cornerRadius(40)
                        .ignoresSafeArea()
                        .frame(height: 100)
                    Button(action: {popupOn = true}) {
                        ZStack {
                            ZStack {
                                Color (.vermelho)
                                    .frame(width: 165, height: 50)
                                    .cornerRadius(20)
                                
                                Text("CALCULAR")
                                    .font(.header2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        
                    }
                    
                }
                
            }
            if (popupOn) {
                ZStack {
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.popupOn.toggle()
                        }
                    PopUp(on: $popupOn)
                    
                }
                
                
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
