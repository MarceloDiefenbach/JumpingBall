//
//  RewardedAd.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 13/11/22.
//

import Foundation
import GoogleMobileAds

class Reward: NSObject, GADFullScreenContentDelegate, ObservableObject {
    @Published var rewardLoaded: Bool = false
    var rewardedAd: GADRewardedAd?

    override init() {
        super.init()
    }

    func LoadReward() {
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-7490663355066325/2589017270", request: GADRequest()) { (ad, error) in
            if let _ = error {
                //MARK: - add erro when load
                self.rewardLoaded = false
                return
            }
            //MARK: - add loaded
            self.rewardLoaded = true
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }

    func ShowReward(viewModel: GameViewModel) {
        let root = UIApplication.shared.windows.first?.rootViewController
        if let ad = rewardedAd {
            ad.present(fromRootViewController: root!, userDidEarnRewardHandler: {
                //MARK: - add watched
                self.rewardLoaded = false
                viewModel.isPresentingView = .gameRun
            })
        } else {
            //MARK: - add error
            self.rewardLoaded = false
            self.LoadReward()
        }
    }
}
