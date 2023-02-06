//
//  FloatingUnderlineModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI

extension Modifiers.FloatingUnderline {
	public  class Configuration {
		public var floatingConfiguration: Modifiers.Floating.Configuration
		
		
		var underlineColor: Color
		var underlineHeight: CGFloat
		var underlinePadding: CGFloat

		
		init(floatingConfiguration: Modifiers.Floating.Configuration) {
			self.underlineColor = FloatingTextFieldConfiguration.shared.underlineColor
			self.underlineHeight = FloatingTextFieldConfiguration.shared.underlineHeight
			self.underlinePadding = FloatingTextFieldConfiguration.shared.underlinePadding
			self.floatingConfiguration = floatingConfiguration
		}
		
		public convenience init(placeHolder: String, text: Binding<String>) {
			let floatingConfiguation: Modifiers.Floating.Configuration = .init(placeHolder: placeHolder, text: text)
			self.init(floatingConfiguration: floatingConfiguation)
		}
		
		@discardableResult
		public func underlineColor(_ underlineColor: Color) -> Self { self.underlineColor = underlineColor; return self }
		
		@discardableResult
		public func underlineHeight(_ underlineHeight: CGFloat) -> Self { self.underlineHeight = underlineHeight; return self }
		
		@discardableResult
		public func underlinePadding(_ underlinePadding: CGFloat) -> Self { self.underlinePadding = underlinePadding; return self }
		
		@discardableResult
		public func floatingConfiguration(_ configuration: Modifiers.Floating.Configuration) -> Self { self.floatingConfiguration = configuration; return self }
	}
}

public extension View {
	
	@ViewBuilder
	func floatingUnderline(_ configuration: Modifiers.FloatingUnderline.Configuration) -> some View {
		self
			.modifier(Modifiers.FloatingUnderline(configuration: configuration))
	}
	
	@ViewBuilder
	fileprivate func drawUnderLine(color: Color, height: CGFloat) -> some View{
		ZStack(alignment: .bottom) {
			self
			Rectangle()
				.frame(height: height)
				.foregroundColor(color)
		}
	}
}


extension Modifiers {
	public struct FloatingUnderline: ViewModifier {
		
		var configuration: Configuration
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			content
				.floating(configuration.floatingConfiguration) //Floating modifier
				.padding(.bottom, configuration.underlinePadding)
				.drawUnderLine(
					color: configuration.underlineColor,
					height: configuration.underlineHeight
				)
		}
	}
}

