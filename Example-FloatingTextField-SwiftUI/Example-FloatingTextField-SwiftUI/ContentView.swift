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
	@Published var flight: String = ""
	@Published var address: String = ""
	
	var floatingUseCase: FloatingUseCase
	enum FloatingUseCase {
		case floating
		case floatingUnderline
		case floatingFocusedUnderline
		
		var screenTitle: String {
			switch self {
			case .floating: return "Floating Only"
			case .floatingUnderline: return "Underline & Floating"
			case .floatingFocusedUnderline: return "Focused & Floating"
			}
		}
	}
	init(floatingUseCase: FloatingUseCase) {
		self.floatingUseCase = floatingUseCase
		
		FloatingTextFieldConfiguration.shared
			.textFieldFont(Font.title2)
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
						
					case .floatingUnderline:
						floatingUnderlineTextFields()
						
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

			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "Name",
						text: $viewModel.name, id: "name")
			let _ = config.floatingUnderlineConfiguration
				.leftView({
					AnyView(
						Image(systemName: "person.fill")
							.padding(.top)
					)
						
				}())
			
			TextField("Name", text: $viewModel.name)
				.floatingFocusedUnderline(
					config
				)
		}
		
		Group {
	
			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "email", text: $viewModel.email, id: "email")
			let _ = config.floatingUnderlineConfiguration
				.leftView({
					AnyView(
						Image(systemName: "envelope.fill")
							.padding(.top)
					)
				}())
			
			TextField("email", text: $viewModel.email)
				.floatingFocusedUnderline(
					config
				)
		}
		
		Group {
	
			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "flight",
																				 text: $viewModel.flight, id: "flight")
			let _ = config.floatingUnderlineConfiguration
				.rightView({
					AnyView(
						Image(systemName: "airplane")
							.padding(.top)
					)
				}())
			
			TextField("flight", text: $viewModel.flight)
				.floatingFocusedUnderline(
					config
				)
		}
		
		Group {
	
			let config: Modifiers.FloatingFocusedUnderline.Configuration = .init(placeHolder: "address",
																				 text: $viewModel.address, id: "address")
			let _ = config.floatingUnderlineConfiguration
				.rightView({
					AnyView(
						Image(systemName: "mappin")
							.padding(.top)
					)
				}())
			
			TextField("address", text: $viewModel.address)
				.floatingFocusedUnderline(
					config
				)
		}
	}
	
	
	@ViewBuilder func floatingUnderlineTextFields() -> some View {
		TextField("Name", text: $viewModel.name)
			.floatingUnderline(
				.init(placeHolder: "Name",
					  text: $viewModel.name)
			)
		
		TextField("email", text: $viewModel.email)
			.floatingUnderline(
				.init(placeHolder: "email",
					  text: $viewModel.email)
			)
		
		TextField("flight", text: $viewModel.flight)
			.floatingUnderline(
				.init(placeHolder: "flight",
					  text: $viewModel.flight)
			)
		
		TextField("address", text: $viewModel.address)
			.floatingUnderline(
				.init(placeHolder: "address",
					  text: $viewModel.address)
			)
	}
	
	@ViewBuilder func floatingTextFields() -> some View {
		TextField("Name", text: $viewModel.name)
			.floating(
				.init(placeHolder: "Name",
					  text: $viewModel.name)
			)
		
		TextField("email", text: $viewModel.email)
			.floating(
				.init(placeHolder: "email",
					  text: $viewModel.email)
			)
		
		TextField("flight", text: $viewModel.flight)
			.floating(
				.init(placeHolder: "flight",
					  text: $viewModel.flight)
			)
		
		TextField("address", text: $viewModel.address)
			.floatingID("address")
			.floating(
				.init(placeHolder: "address",
					  text: $viewModel.address)
			)
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView.test
	}
}
