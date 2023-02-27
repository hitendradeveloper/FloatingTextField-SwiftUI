//
//  ContentView.swift
//  Example-FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 06/02/23.
//


import SwiftUI
import UIKit
import FloatingTextField_SwiftUI


class ContentViewModel: ObservableObject {
	@Published var name: String = ""
	@Published var email: String = ""
	@Published var password: String = ""
	
	@Published var isShowingPassword: Bool = false
	
	var floatingUseCase: FloatingUseCase
	enum FloatingUseCase {
		case floating
		case floatingFocusedUnderline
		case floatingFocusedBorder
		
		
		var screenTitle: String {
			switch self {
			case .floating: return "Floating Only"
			case .floatingFocusedUnderline: return "Focused & Floating"
			case .floatingFocusedBorder: return "Focused & Bordered"
			}
		}
	}
	init(floatingUseCase: FloatingUseCase) {
		self.floatingUseCase = floatingUseCase
		
		FloatingTextFieldAppearance.shared
			.textFieldFont(Font.title2)
			.floatingPlaceholderFont(.body)
	}
}

struct ContentView: View {
	
	static var test: ContentView {
		ContentView(viewModel: .init(floatingUseCase: .floatingFocusedUnderline))
	}
	
	
	@ObservedObject var viewModel: ContentViewModel
	
	init(viewModel: ContentViewModel) {
		self.viewModel = viewModel
	}
	
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 25) {
					switch viewModel.floatingUseCase {
					case .floatingFocusedUnderline:
						floatingFocusedUnderlineTextFields()
						
					case .floatingFocusedBorder:
						floatingFocusedBorderedTextFields()
						
					case .floating:
						floatingTextFields()
					}
					
				}
				
			}
			.navigationTitle(viewModel.floatingUseCase.screenTitle)

			.padding()
		}
		
	}
	
	
	
	@ViewBuilder func floatingFocusedUnderlineTextFields() -> some View {
		Group {
			let placeHolder = "Name"
			let binding = $viewModel.name.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingUnderline(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Email"
			let binding = $viewModel.email.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingUnderline(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Password"
			let binding = $viewModel.password.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			SecureField(placeHolder, text: binding)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingUnderline(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
	}
	
	@ViewBuilder func floatingFocusedBorderedTextFields() -> some View {
		Group {
			let placeHolder = "Name"
			let binding = $viewModel.name.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floatingRounded(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.floatingPlaceHolderLeadingPadding(6)
					.floatingPlaceHolderPadding(2)
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Email"
			let binding = $viewModel.email.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floatingRounded(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.floatingPlaceHolderLeadingPadding(6)
					.floatingPlaceHolderPadding(2)
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Password"
			let binding = $viewModel.password.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			SecureField(placeHolder, text: binding)
				.floatingRounded(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.floatingPlaceHolderLeadingPadding(6)
					.floatingPlaceHolderPadding(2)
					.configure(focusedConfiguration: focusedConfig)
				)
		}
	}
	
	@ViewBuilder func floatingTextFields() -> some View {
		Group {
			let placeHolder = "Name"
			let binding = $viewModel.name.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Email"
			let binding = $viewModel.email.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
		Group {
			let placeHolder = "Password"
			let binding = $viewModel.password.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			SecureField(placeHolder, text: binding)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
		}
		
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView.test
	}
}
