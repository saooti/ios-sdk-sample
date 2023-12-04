//
//  ViewModel.swift
//  SDK-Sample
//
//  Created by Aleksandr Khorobrykh on 27/04/2023.
//

import Foundation
import Combine
import SaootiSDK

enum UI {
    case podcasts
    case radio
}

class ViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var isDetachedMiniPlayerVisible = false
    
    @Published var visibleUI: UI?

    init() {
        Saooti.player.playingState.publisher
            .compactMap({ $0 })
            .filter({ $0.playingStatus == .playing })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isDetachedMiniPlayerVisible = true
            }
            .store(in: &cancellables)
    }
    
    func onPodcastsUIButtonClick() {
        visibleUI = .podcasts
    }
    
    func onRadioUIButtonClick() {
        visibleUI = .radio
    }
    
    func onCloseButtonClick() {
        visibleUI = nil
    }
    
    func onMiniPlayerCloseButtonClick() {
        isDetachedMiniPlayerVisible = false
    }
}
