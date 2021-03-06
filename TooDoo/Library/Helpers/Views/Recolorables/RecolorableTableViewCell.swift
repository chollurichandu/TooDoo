//
//  RecolorableTableViewCell.swift
//  TooDoo
//
//  Created by Cali Castle  on 11/22/17.
//  Copyright © 2017 Cali Castle . All rights reserved.
//

import UIKit

class RecolorableTableViewCell: UITableViewCell, RecolorableView {

    @IBInspectable
    var solidBackground: Bool = false {
        didSet {
            recolorViews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        recolorViews()
        
        NotificationManager.listen(self, do: #selector(recolorViews), notification: .SettingThemeChanged, object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recolorViews()
    }
    
    @objc open func recolorViews(_ notification: Notification? = nil) {
        guard notification == nil else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                switch UserDefaultManager.settingThemeMode() {
                case .Dark:
                    // Dark theme
                    self.contentView.backgroundColor = .flatBlack()
                case .Light:
                    // Light theme
                    self.contentView.backgroundColor = .flatWhite()
                }
            }, completion: nil)
            
            return
        }
        
        if AppearanceManager.default.theme == .Dark {
            contentView.backgroundColor = solidBackground ? .flatBlack() : .clear
            tintColor = .flatWhite()
        } else {
            contentView.backgroundColor = solidBackground ? .flatWhite() : .clear
            tintColor = .flatBlack()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
