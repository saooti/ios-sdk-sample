//
//  CarPlaySceneDelegate.swift
//  SDK-Sample
//
//  Created by Aleksandr Khorobrykh on 04/08/2023.
//

import Foundation
import CarPlay
import SaootiSDK

/// This is a code sample demonstrating how to embed prepared `SaootiUI.CarPlay` templates into a `CPTabBarTemplate`.
/// Available methods include:
/// `SaootiUI.CarPlay.getLatestPodcastsTemplate`
/// `SaootiUI.CarPlay.getPodcastsQueueTemplate`
/// Note: To enable CarPlay functionality, you must obtain entitlements from Apple and perform some setup steps:
/// https://developer.apple.com/documentation/carplay/requesting_carplay_entitlements

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
        
    private var interfaceController: CPInterfaceController?
                    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        
        self.interfaceController = interfaceController

        ///
        
        let latestPodcastsItem = CPListItem(text: "Newest episodes", detailText: nil)
        
        latestPodcastsItem.handler = { _, completion in

            Task(priority: .userInitiated) {
                do {
                    let podcastsTemplate = try await SaootiUI.CarPlay.getLatestPodcastsTemplate(onPodcastClick: { _ in
                        interfaceController.pushTemplate(CPNowPlayingTemplate.shared, animated: true, completion: nil)
                    })
                    interfaceController.pushTemplate(podcastsTemplate, animated: true, completion: nil)
                }
                catch {
                    print(error)
                }

                completion()
            }
        }
        
        ///
    
        let podcastsQueueItem = CPListItem(text: "Podcasts queue", detailText: nil)
        
        podcastsQueueItem.handler = { _, completion in

            Task(priority: .userInitiated) {
                do {
                    let podcastsTemplate = try await SaootiUI.CarPlay.getPodcastsQueueTemplate(onPodcastClick: { _ in
                        interfaceController.pushTemplate(CPNowPlayingTemplate.shared, animated: true, completion: nil)
                    })
                    interfaceController.pushTemplate(podcastsTemplate, animated: true, completion: nil)
                }
                catch {
                    print(error)
                }

                completion()
            }
        }
        
        ///
        
        let podcastsSection = CPListSection(items: [latestPodcastsItem, podcastsQueueItem])
        let podcastsListTemplate = CPListTemplate(title: "Podcasts", sections: [podcastsSection])
        podcastsListTemplate.tabImage = UIImage(systemName: "list.star")
        podcastsListTemplate.tabTitle = "Podcasts"
    
        let tabBarTemplate = CPTabBarTemplate(templates: [podcastsListTemplate])
        
        self.interfaceController?.setRootTemplate(tabBarTemplate, animated: true, completion: {_, _ in })
    }

    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}
