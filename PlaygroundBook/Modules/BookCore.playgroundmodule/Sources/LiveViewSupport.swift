//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport
import SwiftUI

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView() -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)

    guard let viewController = storyboard.instantiateInitialViewController() else {
        fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
    }

    guard let liveViewController = viewController as? LiveViewController else {
        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
    }

    return liveViewController
}

public func instantiateExploreView() -> PlaygroundLiveViewable {
    let explorerController = ItemDetailViewController() //UINavigationController(rootViewController: MyViewController())
//    explorerController.setNavigationBarHidden(true, animated: false)
//    let navController = UINavigationController(rootViewController: explorerController)
    return explorerController
}

public func instantiateBuilderView() -> PlaygroundLiveViewable {
    let builderController = EditorViewController()
//    let navController = UINavigationController(rootViewController: explorerController)
    return builderController
}

public func instantiateAboutMeView() -> PlaygroundLiveViewable {
    let view = ContentView()
    return UIHostingController(rootView: view)
}
