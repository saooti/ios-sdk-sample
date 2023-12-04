//
//  ContentView.swift
//  SDK-Sample
//
//  Created by Aleksandr Khorobrykh on 13/02/2023.
//

import SwiftUI
import Combine
import SaootiSDK

struct ContentView: View {
        
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Text("App environment")
                
                Spacer()
                    .frame(height: 50)
                
                Button {
                    withAnimation {
                        viewModel.onPodcastsUIButtonClick()
                    }
                } label: {
                    Text("Podcasts UI")
                }
                
                Spacer()
                    .frame(height: 40)
                
                Button {
                    withAnimation {
                        viewModel.onRadioUIButtonClick()
                    }
                } label: {
                    Text("Broadcast UI")
                }
            }
            
            VStack {
                Spacer()

                if viewModel.isDetachedMiniPlayerVisible {
                    SaootiUI.MiniPlayerView(
                        isCloseButtonVisible: true,
                        onCloseButtonClick: {
                            Saooti.player.pause()
                            viewModel.onMiniPlayerCloseButtonClick()
                        }
                    )
                }
            }
            
            if viewModel.visibleUI == .podcasts {
                podcastsUI()
            }
            else if viewModel.visibleUI == .radio {
                broadcastUI()
            }
        }
    }
    
    @ViewBuilder
    private func podcastsUI() -> some View {
        // PodcastsHubView has internal navigation flow so it's wrapped in NavigationView
        SaootiUI.PodcastsHubView(
            navbarConfig: NavbarConfig(onCloseButtonClick: {
                withAnimation {
                    viewModel.onCloseButtonClick()
                }
            })
        )
        .transition(.move(edge: .bottom))
        .background(Color(235, 235, 239).edgesIgnoringSafeArea(.bottom))
    }
    
    @ViewBuilder
    private func broadcastUI() -> some View {
        NavigationView {
            // BroadcastHubView has no internal navigation flow so it's not wrapped in NavigationView
            SaootiUI.BroadcastHubView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Broadcasting")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack(alignment: .leading) {
                            Image("back_button")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color(100, 100, 100))
                                .frame(width: 15, height: 15)
                                .onTapGesture {
                                    viewModel.onCloseButtonClick()
                                }
                        }
                        .frame(width: 30, height: 30)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VStack(alignment: .leading) {
            
                        }
                        .frame(width: 30, height: 30)
                    }
                }
                .background(Color(235, 235, 239).edgesIgnoringSafeArea(.bottom))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .transition(.move(edge: .bottom))
    }
}
