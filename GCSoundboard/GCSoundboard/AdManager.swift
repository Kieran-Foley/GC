//
//  AdManager.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 26/11/2018.
//  Copyright © 2018 Kieran. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdManager:  NSObject, GADInterstitialDelegate {
    
    static let SINGLETON = AdManager()
    
    // Popover ad : ca-app-pub-1725298510457190/9515229573
    var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
    
    
    func showAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    // Loads a new ad as soon as the current one is dismissed
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
    }
}
