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

extension Modifiers.Floating {
	public class Configuration {
		var placeHolder: String
		var text: Binding<String>
		
		var placeholderColor: Color
		var placeholderFont: Font
		
		public init(placeHolder: String, text: Binding<String>) {
			self.placeHolder = placeHolder
			self.text = text
			
			self.placeholderColor = Color(UIColor.placeholderText)
			self.placeholderFont = .system(.caption)
		}
		
		@discardableResult
		public func placeholderColor(_ placeholderColor: Color) -> Self { self.placeholderColor = placeholderColor; return self }
		
		@discardableResult
		public func placeholderFont(_ placeholderFont: Font) -> Self { self.placeholderFont = placeholderFont; return self }
	}
}

public extension View {
	
	@ViewBuilder
	func floating(_ configuration: Modifiers.Floating.Configuration) -> some View {
		modifier(Modifiers.Floating(configuration: configuration))
	}
}


extension Modifiers {
	
	public struct Floating: ViewModifier {
		
		var configuration: Configuration
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			VStack(spacing: 0) {
				placeHolderViewIfNeeded()
					.padding(.bottom, 2)
				
				content
			}
		}
		
		@ViewBuilder private func placeHolderViewIfNeeded() -> some View {
			let text = configuration.text
			let placeholder = configuration.placeHolder
			Group {
				if text.wrappedValue.count > 0 {
					Text(text.wrappedValue.count > 0 ? placeholder : " ")
						.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
						.animation(text.wrappedValue.count > 0 ? .easeIn : .easeOut, value: text.wrappedValue.count > 0)
				} else {
					Text(text.wrappedValue.count > 0 ? placeholder : " ")
						.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
						.animation(text.wrappedValue.count > 0 ? .easeIn : .easeOut, value: text.wrappedValue.count > 0)
				}
			}
			.font(configuration.placeholderFont)
			.foregroundColor(configuration.placeholderColor)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
	
}
