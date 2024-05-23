//
//  ContentView.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 13/05/24.
//

import SwiftUI

var games = addGames()

struct ContentView: View {
    //popup
    @State var popupOn = false
    @State var popupSelect = false
    @State var popupHow = false
    
    //calculo
    @State var selectedGame1: Game? = games[0]
    @State var selectedGame2: Game? = games[0]
    @State var selectedGame3: Game? = games[0]
    @State var selectedGame4: Game? = games[0]
    @State var selectedGames2: [Game?] = []
    var selectedGames: [Game] {
        [
            selectedGame1,
            selectedGame2,
            selectedGame3,
            selectedGame4,
        ].compactMap { $0 }
    }
    @State var games2 = addGames()
    @State var result: [GamePair] = []
    @State var styles: [Double] = [0,0,0,0]
    
    // sliders
    @State var players: Float = 2
    @State var time: Float = 15
    
    
    
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
                
                Button(action: {
                    popupHow = true
                }) {
                    ZStack {
                        Color (.vermelho)
                            .frame(width: 165, height: 20)
                            .cornerRadius(20)
                        
                        Text("Como funciona?")
                            .font(.header3)
                            .foregroundColor(.white)
                    }
                    
                }
                
                HStack {
                    Text("1. Escolha 4 jogos que você adora!")
                        .font(.header1)
                    
                    
                }
                
                HStack {
                    ZStack {
                        Image("cartaA")
                        Picker ("", selection: $selectedGame1){
                            ForEach(games.filter({$0 == selectedGame1 || !selectedGames.contains($0) || $0 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }.padding()
                    }
                    ZStack {
                        Image("carta2")
                        Picker ("", selection: $selectedGame2){
                            ForEach(games.filter({$0 == selectedGame2 || !selectedGames.contains($0) || $0 == games[0]})) { game in
                                
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
                            ForEach(games.filter({$0 == selectedGame3 || !selectedGames.contains($0) || $0 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }
                    }
                    ZStack {
                        Image("carta4")
                        Picker ("", selection: $selectedGame4){
                            ForEach(games.filter({$0 == selectedGame4 || !selectedGames.contains($0) || $0 == games[0]})) { game in
                                
                                Text(game.name)
                                    .tag(game as Game?)
                                    .font(.header2)
                                
                            }
                        }
                    }
                }
                
                Spacer()
                
                
                
                VStack {
                    Text("2. Quantas pessoas jogarão?")
                        .font(.header1)
                    Slider(
                            value: $players,
                            in: 2...12,
                            step: 1,
                        label: {
                            Text(String(players))
                        }, minimumValueLabel: {
                            Text("2")
                        }, maximumValueLabel: {
                            Text("12")
                        }).padding(.leading, 24)
                        .padding(.trailing, 24)
                    
                    Text("\(players, specifier: "%.0f") jogadores")
                }
                
                VStack {
                    Text("3. Quanto tempo disponível?")
                        .font(.header1)
                    
                    Slider(
                            value: $time,
                            in: 15...120,
                            step: 15,
                        label: {
                            
                        }, minimumValueLabel: {
                            Text("15")
                        }, maximumValueLabel: {
                            Text("120")
                        }).padding(.leading, 24)
                        .padding(.trailing, 24)
                    
                    Text("\(time, specifier: "%.0f") minutos")
                }
                

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
                            styles = calculateStyles(games: selectedGames)
                            
                            result = []
                            
                            for game in
                                games.filter({!selectedGames.contains($0)}) {
                                let g: GamePair = GamePair(result: (calculate(games: selectedGames, game5: game)), game: game)
                                result.append(g)
                            }
                            
                            result = result.sorted(by: >)
                            
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
                    PopUp(on: $popupOn, styles: $styles, result: $result, timeLimit: $time, playerLimit: $players)
                    
                }
                
                
            }
            if (popupHow) {
                
                ZStack {
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.popupHow.toggle()
                        }
                    Image("cartafinal")
                    VStack (alignment: .center, spacing: 12){
                        VStack {
                            Text("1. Escolha quatro jogos que")
                                
                                
                            Text("você curte")
                                
                            
                        }
                        
                        Text("Calcularemos seu gosto para jogos!")
                            .font(.header3)
                            
                        VStack {
                            Text("2. Escolha quantas pessoas jogarão")
                                
                        }
                            
                        VStack {
                            Text("3. Escolha quanto tempo de jogo")
                                
                                
                            Text("você tem disponível")
                                
                        }
                        
                        Text("4. Clique em Calcular")
                            
                            
                        Text("Recomendaremos 3 jogos que achamos que Vale a JogADA!")
                        Button (action: {popupHow = false}) {
                            Image("closebutton")
                        }
                            
                            
                    }.frame(width: 343, height: 500)
                            .foregroundStyle(.azulescuro)
                            .font(.header2)
                            .padding(.top, 16)
                            
                            
                    
                            
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
