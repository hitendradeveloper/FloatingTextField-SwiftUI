//
//  Example_FloatingTextField_SwiftUIApp.swift
//  Example-FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 06/02/23.
//

import SwiftUI

@main
struct Example_FloatingTextField_SwiftUIApp: App {
	var tab1ViewModel: ContentViewModel = .init(floatingUseCase: .floatingFocusedUnderline)
	var tab3ViewModel: ContentViewModel = .init(floatingUseCase: .floating)
	
	var body: some Scene {
		WindowGroup {
			TabView {
				ContentView(viewModel: tab1ViewModel)
					.tabItem {
						Label(tab1ViewModel.floatingUseCase.screenTitle, systemImage: "text.line.first.and.arrowtriangle.forward")
					}

				ContentView(viewModel: tab3ViewModel)
					.tabItem {
						Label(tab3ViewModel.floatingUseCase.screenTitle, systemImage: "textformat.abc.dottedunderline")
					}
				
			}
			
			
		}
	}
}
