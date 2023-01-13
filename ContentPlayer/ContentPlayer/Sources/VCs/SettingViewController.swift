//
//  SettingViewController.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    private func initLayout() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.settingView.layer.cornerRadius = 20
        self.settingView.layer.masksToBounds = true
    }
}
