//
//  StyleGuide.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 14/05/24.
//

import SwiftUI

extension Font {
    static let display: Font = .custom(CustomFonts.bold.rawValue, size: 32)
    static let header1: Font = .custom(CustomFonts.semiBold.rawValue, size: 20)
    static let header2: Font = .custom(CustomFonts.semiBold.rawValue, size: 16)
    static let header3: Font = .custom(CustomFonts.medium.rawValue, size: 16)
    static let body: Font = .custom(CustomFonts.semiBold.rawValue, size: 12)
    static let a: Font = .custom(CustomFonts.semiBold.rawValue, size: 20)
}

enum CustomFonts: String {
    case plusJakartaSans = "PlusJakartaSans"
    case bold = "PlusJakartaSans-Bold"
    case extraBold = "PlusJakartaSans-ExtraBold"
    case light = "PlusJakartaSans-Light"
    case extraLight = "PlusJakartaSans-ExtraLight"
    case medium = "PlusJakartaSans-Medium"
    case regular = "PlusJakartaSans-Regular"
    case semiBold = "PlusJakartaSans-SemiBold"
}
