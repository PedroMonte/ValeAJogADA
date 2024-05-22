//
//  ContentView.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 13/05/24.
//

import SwiftUI

var games = addGames()

struct ContentView: View {
    @State var popupOn = false
    @State var popupSelect = false
    @State var selectedGame1: Game? = games[0]
    @State var selectedGame2: Game? = games[0]
    @State var selectedGame3: Game? = games[0]
    @State var selectedGame4: Game? = games[0]
    @State var selectedGame5: Game? = games[0]
    var selectedGames: [Game] {
        [
            selectedGame1,
            selectedGame2,
            selectedGame3,
            selectedGame4,
        ].compactMap { $0 }
    }
    
    var selectedGames2: [Game] {
        [
            selectedGame1,
            selectedGame2,
            selectedGame3,
            selectedGame4,
            selectedGame5
        ].compactMap { $0 }
    }
    @State var games2 = addGames()
    
    
    @State var result: Double = 0
    @State var styles: [Double] = [0,0,0,0]
    
    
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
                            ForEach(games.filter({$0 == selectedGame1 || !selectedGames.contains($0) || selectedGame1 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }.padding()
                    }
                    ZStack {
                        Image("carta2")
                        Picker ("", selection: $selectedGame2){
                            ForEach(games.filter({$0 == selectedGame2 || !selectedGames.contains($0) || selectedGame1 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }
                    }
                }
                HStack {
                    ZStack {
                        Image("carta3")
                        Picker ("", selection: $selectedGame3){
                            ForEach(games.filter({$0 == selectedGame3 || !selectedGames.contains($0) || selectedGame1 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }
                    }
                    ZStack {
                        Image("carta4")
                        Picker ("", selection: $selectedGame4){
                            ForEach(games.filter({$0 == selectedGame4 || !selectedGames.contains($0) || selectedGame1 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
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
                        ForEach (games.filter({!selectedGames.contains($0) && $0 != games[0]})) { jogo in
                            
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
                                    Text(jogo.name)
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
                    Button(action: {
                        var b = false
                        for game in selectedGames {
                            if game.name == "Selecionar" {
                                b = true
                                break
                            }
                        }
                        if (!b) {
                            popupOn = true
                            styles = calculateStyles(games: selectedGames2)
                            result = calculate(games: selectedGames2)
                        } else {
                            popupSelect = true
                        }
                        
                        
                        
                        
                    }) {
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
                    PopUp(on: $popupOn, styles: $styles, result: $result, game5: $selectedGame5)
                    
                }
                
                
                
            }
        }.alert("Selecione os jogos!", isPresented: $popupSelect) {
            Button("OK", role: .cancel, action: {})
        }
        
        
    }
    
}

#Preview {
    ContentView()
}
