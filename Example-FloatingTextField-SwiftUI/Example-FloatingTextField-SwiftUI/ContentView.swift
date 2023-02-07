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
		
		var screenTitle: String {
			switch self {
			case .floating: return "Floating Only"
			case .floatingFocusedUnderline: return "Focused & Floating"
			}
		}
	}
	init(floatingUseCase: FloatingUseCase) {
		self.floatingUseCase = floatingUseCase
		
		FloatingTextFieldConfiguration.shared
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
		
//		Group {
//
//			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "Name",
//						text: $viewModel.name, id: "name")
//			let _ = config.floatingUnderlineConfiguration
//				.floatingConfiguration
//				.leftView({
//					AnyView(
//						Image(systemName: "person.fill")
//					)
//				}())
//
//			TextField("Name", text: $viewModel.name.animation())
//				.floatingFocusedUnderline(
//					config
//				)
//		}
//
//		Group {
//
//			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "Email", text: $viewModel.email, id: "email")
//			let _ = config.floatingUnderlineConfiguration
//				.floatingConfiguration
//				.leftView({
//					AnyView(
//						Image(systemName: "envelope.fill")
//					)
//				}())
//
//
//			TextField("email", text: $viewModel.email.animation())
//				.floatingFocusedUnderline(
//					config
//				)
//		}
//
//		Group {
//
//			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "Password",
//																				 text: $viewModel.password, id: "password")
//			let _ = config.floatingUnderlineConfiguration
//				.floatingConfiguration
//				.leftView({
//					AnyView(
//						Image(systemName: viewModel.isShowingPassword ? "lock.open.fill" : "lock.fill")
//					)
//				}())
//				.rightView({
//					AnyView(
//						Button(action: {
//							withAnimation {
//								self.viewModel.isShowingPassword.toggle()
//							}
//						}, label: {
//							Image(systemName: viewModel.isShowingPassword ? "eye.slash.fill" : "eye.fill")
//						})
//					)
//				}())
//
//			Group {
//				if self.viewModel.isShowingPassword {
//					TextField("Password", text: $viewModel.password.animation())
//				}else {
//					SecureField("Password", text: $viewModel.password.animation())
//				}
//
//			}.floatingFocusedUnderline(
//					config
//				)
//		}
	}
	
	
	@ViewBuilder func floatingTextFields() -> some View {
		Group {
			let placeHolder = "Name"
			let binding = $viewModel.name.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
//				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
//				.floatingUnderline(
//					.init()
//					.configure(focusedConfiguration: focusedConfig)
//				)
		}
		
		Group {
			let placeHolder = "Email"
			let binding = $viewModel.email.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			TextField(placeHolder, text: binding)
//				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
//				.floatingUnderline(
//					.init()
//					.configure(focusedConfiguration: focusedConfig)
//				)
		}
		
		Group {
			let placeHolder = "Password"
			let binding = $viewModel.password.animation()
			let id = placeHolder + self.viewModel.floatingUseCase.screenTitle
			
			let focusedConfig: Modifiers.Focused.Configuration = .init(id: id)
						
			SecureField(placeHolder, text: binding)
//				.floatingFocused(focusedConfig)
				.floating(
					.init()
					.configure(focusedConfiguration: focusedConfig)
				)
//				.floatingUnderline(
//					.init()
//					.configure(focusedConfiguration: focusedConfig)
//				)
		}
		
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView.test
	}
}
