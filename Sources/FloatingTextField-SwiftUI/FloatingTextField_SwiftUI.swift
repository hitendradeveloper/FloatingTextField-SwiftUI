//
//  FloatingModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit

internal extension View {
	@ViewBuilder func drawUnderLine(color: Color, height: CGFloat) -> some View{
		ZStack(alignment: .bottom) {
			self
			Rectangle()
				.frame(height: height)
				.foregroundColor(color)
		}
	}
}


extension Color {
 
	func uiColor() -> UIColor {

		if #available(iOS 14.0, *) {
			return UIColor(self)
		}

		let components = self.components()
		return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
	}

	private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

		let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
		var hexNumber: UInt64 = 0
		var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

		let result = scanner.scanHexInt64(&hexNumber)
		if result {
			r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
			g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
			b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
			a = CGFloat(hexNumber & 0x000000ff) / 255
		}
		return (r, g, b, a)
	}
}
