//
//  UIView+Appearance.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 14/09/2019.
//  Copyright © 2019 Kieran. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Lottie

extension UIViewController {

    func setupBackground() {
        let gradient = CAGradientLayer()
        
        // Create a gradient at 3/4 down the view
        gradient.locations = [0.75, 1]
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.CG_PINK.cgColor, UIColor.white.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    

    func setupAdBanner() {
        
        var bannerView: GADBannerView!

        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = AdManager.BANNER_KEY
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    // Set adMob banners constraints to safe area
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        bannerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func playAnimation(view: AnimationView, animation: String) {
        view.animation = Animation.named(animation)
        view.loopMode = .playOnce
        
        view.play { finished in
            view.removeFromSuperview()
        }
    }
}
