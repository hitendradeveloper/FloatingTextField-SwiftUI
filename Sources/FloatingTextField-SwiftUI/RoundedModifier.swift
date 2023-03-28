//
//  RoundedModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 28/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI

extension Modifiers.Rounded {
	public  class Configuration {
		var borderColor: Color
		var borderWidth: CGFloat
		var borderPadding: CGFloat
		
		public init() {
			self.borderColor = FloatingTextFieldAppearance.shared.borderColor
			self.borderWidth = FloatingTextFieldAppearance.shared.borderWidth
			self.borderPadding = FloatingTextFieldAppearance.shared.borderPadding
		}
		
		@discardableResult
		public func borderColor(_ borderColor: Color) -> Self { self.borderColor = borderColor; return self }
		
		@discardableResult
		public func borderWidth(_ borderWidth: CGFloat) -> Self { self.borderWidth = borderWidth; return self }
		
		@discardableResult
		public func borderPadding(_ borderPadding: CGFloat) -> Self { self.borderPadding = borderPadding; return self }
		
	}
}

public extension View {
	
	@ViewBuilder
	func floatingRounded(_ configuration: Modifiers.Rounded.Configuration) -> some View {
		self
			.modifier(Modifiers.Rounded(configuration: configuration))
	}
	
	@ViewBuilder
	fileprivate func drawRoundedBorder(color: Color, lineWidth: CGFloat) -> some View{
		ZStack(alignment: .center) {
			self
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.stroke(color, lineWidth: lineWidth)
		}
		.clipShape(
			RoundedRectangle(cornerRadius: 10, style: .continuous)
		)
	}
}


extension Modifiers {
	public struct Rounded: ViewModifier {
		
		var configuration: Configuration
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			content
				.padding(configuration.borderPadding)
				.drawRoundedBorder(
					color: configuration.borderColor,
					lineWidth: configuration.borderWidth
				)
		}
	}
}

extension Modifiers.Rounded.Configuration: OnFocusChangeConfigurable {
	public func configure(focusedConfiguration: Modifiers.Focused.Configuration) -> Self {
		if focusedConfiguration.isFocused {
			self.borderColor = focusedConfiguration.focusedColor
		}
		return self
	}
}
