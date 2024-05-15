//
//  PopUp.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 15/05/24.
//

import SwiftUI

struct PopUp: View {
    @Binding var on: Bool
    var body: some View {
        ZStack (alignment: .leading){
            Image("cartafinal")
            VStack (alignment: .leading) {
                Text("Calculamos seu perfil de jogo")
                    .font(.header3)
                    .padding(.leading, 24)
                Text("pelos jogos que você escolheu:")
                    .font(.header3)
                    .padding(.leading, 24)
                Spacer()
                VStack (spacing: 16){
                    Spacer()
                    HStack {
                        Button(action: {openInfo()}) {
                            Image("button?")
                        }
                        Text("Assassino")
                            .font(.body)
                            .foregroundStyle(.black)
                        Image("naipes1")
                        Text("Socializador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Button(action: {openInfo()}) {
                            Image("button?")
                        }
                    }
                    HStack {
                        Button(action: {openInfo()}) {
                            Image("button?")
                        }
                        Text("Conquistador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Image("naipes2")
                        Text("Explorador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Button(action: {openInfo()}) {
                            Image("button?")
                        }
                    }
                    
                    Text("Concluímos que:")
                        .font(.header3)
                    Text("Vale a JogADA!")
                        .font(.display)
                    Text("Você irá adorar")
                        .font(.header3)
                    
                    Spacer()
                    Button (action: {self.on = false}) {
                        Image("closebutton")
                    }
                }.frame(maxWidth: .infinity)
                
                
            }.padding(.top, 24)
            .padding(.bottom, 24)
            
        }.frame(width: 343, height: 500)
            .foregroundStyle(.azulescuro)
    }
    
    func openInfo() {
        
    }
}


