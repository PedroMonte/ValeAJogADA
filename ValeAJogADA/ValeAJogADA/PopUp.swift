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
    @Binding var result: Double
    @Binding var game5: Game?
    
    @State var infoPopup: Bool = false
    
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
                
                Button(action: {infoPopup = true}) {
                    Image("button?")
                }
                
                if (infoPopup) {
                   
                }
                VStack (spacing: 16){
                    Spacer()
                    HStack {
                        Text("Assassino")
                            .font(.body)
                            .foregroundStyle(.black)
                        Text(String(Int(styles[0])))
                        Image("naipes1")
                        Text("Socializador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Text(String(Int(styles[1])))
                    }
                    HStack {
                        Text("Conquistador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Text(String(Int(styles[3])))
                        Image("naipes2")
                        Text("Explorador")
                            .font(.body)
                            .foregroundStyle(.black)
                        Text(String(Int(styles[2])))
                        
                    }
                    
                    Text("Concluímos que:")
                        .font(.header3)
                    
                    if (result >= 50) {
                        Text("Vale a JogADA!")
                            .font(.display)
                        Text("Você irá adorar \(game5!.name)")
                            .font(.header3)
                        Text(String(Int(result)))
                            .font(.header3)
                    } else {
                        Text("Talvez não valha a JogADA!")
                            .font(.display)
                        Text(String(Int(result)))
                            .font(.header3)
                    }
                    
                    
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
