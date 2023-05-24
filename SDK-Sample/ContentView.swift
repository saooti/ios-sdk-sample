//
//  ContentView.swift
//  SDK-Sample
//
//  Created by Aleksandr Khorobrykh on 13/02/2023.
//

import SwiftUI
import SaootiSDK

struct ContentView: View {
        
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        ZStack {
            Button {
                withAnimation {
                    viewModel.isSDKUIVisible.toggle()
                }
            } label: {
                Text("Open Podcasts")
            }
            
            VStack {
                Spacer()

                if viewModel.isDetachedMiniPlayerVisible {
                    MiniPlayerView(
                        isCloseButtonVisible: true,
                        onCloseButtonClick: {
                            viewModel.onMiniPlayerCloseButtonClick()
                        },
                        onClick: {
                            withAnimation {
                                viewModel.onMiniPlayerClick()
                            }
                        }
                    )
                } else {
                    EmptyView()
                }
            }
            
            if viewModel.isSDKUIVisible {
                UI(
                    navbarConfig: NavbarConfig(onCloseButtonClick: {
                        withAnimation {
                            viewModel.isSDKUIVisible.toggle()
                        }
                    })
                )
                .transition(.move(edge: .bottom))
            } else {
                EmptyView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
