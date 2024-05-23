//
//  PopUp.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 15/05/24.
//

import SwiftUI

struct PopUp: View {
    
    @Binding var on: Bool
    @Binding var styles: [Double]
    @Binding var result: [GamePair]
    @Binding var timeLimit: Float
    @Binding var playerLimit: Float
    
    var games: [Game] {
        var res: [Game] = []
        var g = result.filter({($0.game.time <= Int(timeLimit)) && ($0.game.playerCount.0 <= Int(playerLimit)) && (Int(playerLimit) <= $0.game.playerCount.1)})
        
        // limit : 6
     // jogo: (2,4)
        
        for i in g {
            res.append(i.game)
        }
        
        return res
    }
    
    @State var infoPopup: Bool = false
    
    var body: some View {
        ZStack (alignment: .leading){
            Image("cartafinal")
            VStack (alignment: .leading) {
                Spacer()
                Text("Calculamos seu perfil de jogo")
                    .font(.header3)
                    .padding(.top, 24)
                    .padding(.leading, 24)
                Text("pelos jogos que você escolheu:")
                    .font(.header3)
                    .padding(.leading, 24)
                
                Spacer()
                VStack (spacing: 16){
                    Spacer()
                    VStack {
                    
                        HStack {
                            Text("Assassino")
                                .font(.body)
                                .foregroundStyle(.black)
                            
                            Image("naipes1")
                            Text("Socializador")
                                .font(.body)
                                .foregroundStyle(.black)
                            
                            
                            
                        }
                        
                        HStack {
                            Text(String(Int(styles[1])) + "%")
                                .font(.body)
                                .foregroundStyle(.azulescuro)
                            Spacer()
                            Button(action: {infoPopup = true}) {
                                Image("button?")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            Spacer()
                            Text(String(Int(styles[0])) + "%")
                                .font(.body)
                                .foregroundStyle(.azulescuro)
                        }.padding(.leading, 64)
                            .padding(.trailing, 64)
                    }
                    
                    VStack {
                        
                        
                        HStack {
                            Text("Conquistador")
                                .font(.body)
                                .foregroundStyle(.black)
                            
                            Image("naipes2")
                            Text("Explorador")
                                .font(.body)
                                .foregroundStyle(.black)
                        
                            
                        }
                        
                        HStack {
                            Text(String(Int(styles[3])) + "%")
                                .font(.body)
                                .foregroundStyle(.azulescuro)
                            Spacer()
                            Text(String(Int(styles[2])) + "%")
                                .font(.body)
                                .foregroundStyle(.azulescuro)
                        }.padding(.leading, 64)
                            .padding(.trailing, 64)
                    }
                    
                    
                    
                    if (games.count == 0){
                        VStack {
                            Text("Infelizmente, nenhum jogo")
                                .font(.header1)
                                .padding(.leading, 24)
                                .padding(.trailing, 24)
                            Text("atendeu as suas exigências...")
                                .font(.header1)
                                .padding(.leading, 24)
                                .padding(.trailing, 24)
                        }
                    } else {
                        Text("E te recomendamos...")
                        VStack {
                            ForEach(games[0...2]) { game in
                                    Text(game.name)
                                    .font(.header1)
                                }
                        }
                    
                        
                    }
                    
                    
                    Spacer()
                    Button (action: {self.on = false}) {
                        Image("closebutton")
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
            }.padding(.top, 36)
                .padding(.bottom, 36)
            
            if infoPopup {
                Image("cartafinal")
                VStack (alignment: .center, spacing: 12){
                    VStack {
                        HStack {
                            Text("1. Assassino")
                                .font(.header1)
                            Image("assassinonaipe")
                        }

                        Text("É o tipo de jogador que adora ganhar")
                            .padding(.trailing, 36)
                        Text("e faz de tudo para vencer!")
                            .padding(.trailing, 36)
                            
                        
                        
                    }.padding(.top, 12)
                        
                        
                    VStack {
                        HStack {
                            Text("2. Socializador")
                                .font(.header1)
                            Image("socializadornaipe")
                        }
                        
                        Text("Socializadores adoram interagir com")
                        Text("os outros,trabalhar em")
                        Text("equipe e negociar para obter a vitória!")
                        
                    }
                        
                    VStack {
                        HStack {
                            Text("3. Conquistador")
                                .font(.header1)
                            Image("conquistadornaipe")
                        }
                        
                            
                            
                        Text("Conquistadores gostam de fazer pontos")
                        Text("e cumprir objetivos para ganhar!")
                        
                            
                    }
                    
                    VStack {
                        HStack {
                            Text("4. Explorador")
                                .font(.header1)
                            Image("exploradornaipe")
                        }
                        
                            
                            
                        Text("Para os exploradores, descobrir cada")
                            .padding(.leading, 36)
                        Text("aspecto do jogo e diferentes formas")
                            .padding(.leading, 36)
                        Text("de jogar é a melhor parte!")
                            .padding(.leading, 36)
                        
                            
                    }
                        
                    Button (action: {infoPopup = false}) {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.vermelho)
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.branco)
                            }
                            
                            Text("Voltar")
                                .font(.header1)
                                .foregroundStyle(.vermelho)
                            
                        }
                        
                    }.padding(.bottom, 12)
                    
                    Spacer()
                        
                        
                }
                .frame(width: 343, height: 500)
                .foregroundStyle(.azulescuro)
                .font(.body)
                        
                        
            }
            
        }.frame(width: 343, height: 500)
            .foregroundStyle(.azulescuro)
    }
    
}

//#Preview {
//   PopUp(on: .constant(true))
//}

//struct FormView_Previews: PreviewProvider {
//  static var previews: some View {
//    PopUp(on: .constant(true))
//  }
//}

//#Preview {
//    struct Preview: View {
//        @State var a = false
//        var body: some View {
//            PopUp(on: $a)
//        }
//    }
//
//    return Preview()
//}
