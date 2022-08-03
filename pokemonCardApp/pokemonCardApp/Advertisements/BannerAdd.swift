//
//  BannerAdd.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/07/23.
//

import SwiftUI
import GoogleMobileAds
import os

struct BannerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = GADBannerViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class GADBannerViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView!
    let adUnitID = "ca-app-pub-2630838252921150/5873567530"
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        bannerView.delegate = self
        setAdView(bannerView)
    }
    
    func setAdView(_ view: GADBannerView) {
        bannerView = view
        self.view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = ["_bannerView": bannerView!]
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[_bannerView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[_bannerView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
        )
    }

    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        OSLog.normal.log("バナー広告を受信しました")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        OSLog.normal.log("バナー広告の受信に失敗しました → \(error.localizedDescription)")
    }
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        OSLog.normal.log("バナー広告を表示しました")
    }
}
