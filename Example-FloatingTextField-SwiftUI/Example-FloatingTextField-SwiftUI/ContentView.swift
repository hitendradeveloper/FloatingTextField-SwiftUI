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
		TextField("Name", text: $viewModel.name)
			.padding(.bottom, 6)
			.floatingFocusedUnderline(
				.init(placeHolder: "Name",
					  text: $viewModel.name, id: "name")
			)
		
		TextField("email", text: $viewModel.email)
			.padding(.bottom, 6)
			.floatingFocusedUnderline(
				.init(placeHolder: "email",
					  text: $viewModel.email, id: "email")
			)
		
		TextField("flight", text: $viewModel.flight)
			.padding(.bottom, 6)
			.floatingFocusedUnderline(
				.init(placeHolder: "flight",
					  text: $viewModel.flight, id: "flight")
			)
		
		TextField("address", text: $viewModel.address)
			.padding(.bottom, 6)
			.floatingFocusedUnderline(
				.init(placeHolder: "address",
					  text: $viewModel.address, id: "address")
			)
	}
	
	
	@ViewBuilder func floatingUnderlineTextFields() -> some View {
		TextField("Name", text: $viewModel.name)
			.padding(.bottom, 6)
			.floatingUnderline(
				.init(placeHolder: "Name",
					  text: $viewModel.name)
			)
		
		TextField("email", text: $viewModel.email)
			.padding(.bottom, 6)
			.floatingUnderline(
				.init(placeHolder: "email",
					  text: $viewModel.email)
			)
		
		TextField("flight", text: $viewModel.flight)
			.padding(.bottom, 6)
			.floatingUnderline(
				.init(placeHolder: "flight",
					  text: $viewModel.flight)
			)
		
		TextField("address", text: $viewModel.address)
			.padding(.bottom, 6)
			.floatingUnderline(
				.init(placeHolder: "address",
					  text: $viewModel.address)
			)
	}
	
	@ViewBuilder func floatingTextFields() -> some View {
		TextField("Name", text: $viewModel.name)
			.padding(.bottom, 6)
			.floating(
				.init(placeHolder: "Name",
					  text: $viewModel.name)
			)
		
		TextField("email", text: $viewModel.email)
			.padding(.bottom, 6)
			.floating(
				.init(placeHolder: "email",
					  text: $viewModel.email)
			)
		
		TextField("flight", text: $viewModel.flight)
			.padding(.bottom, 6)
			.floating(
				.init(placeHolder: "flight",
					  text: $viewModel.flight)
			)
		
		TextField("address", text: $viewModel.address)
			.padding(.bottom, 6)
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
