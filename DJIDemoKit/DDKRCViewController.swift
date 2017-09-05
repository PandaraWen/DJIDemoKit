//
//  DDKRCViewController.swift
//  RCReplay
//
//  Created by Pandara on 2017/9/4.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit
import SnapKit
import DJISDK

public class DDKRCViewController: UIViewController {
    fileprivate var leftTopLabel: UILabel!
    fileprivate var leftLabel: UILabel!
    fileprivate var rightTopLabel: UILabel!
    fileprivate var rightLabel: UILabel!
    
    fileprivate var leftContainer: UIView!
    fileprivate var rightContainer: UIView!
    
    fileprivate let _viColor = UIColor(colorLiteralRed: 0, green: 140 / 255.0, blue: 1, alpha: 1)
    fileprivate let _stickSize = 10
    
    fileprivate var leftStickV: UIView!
    fileprivate var leftStickH: UIView!
    fileprivate var rightStickV: UIView!
    fileprivate var rightStickH: UIView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.view.backgroundColor = UIColor.white
        
        self.leftLabel.text = "0"
        self.leftTopLabel.text = "0"
        self.rightTopLabel.text = "0"
        self.rightLabel.text = "0"
        
        DDKComponentHelper.fetchRemoteController()?.delegate = self
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}

// MARK: Private methods
fileprivate extension DDKRCViewController {
    enum StickType {
        case left
        case right
    }
    
    func moveLeftStick(top: Float, left: Float) {
        self.moveStick(stickType: .left, top: top, left: left)
    }
    
    func moveRightStick(top: Float, left: Float) {
        self.moveStick(stickType: .right, top: top, left: left)
    }
    
    private func moveStick(stickType: StickType, top: Float, left: Float) {
        var stickV: UIView
        var stickH: UIView
        switch stickType {
        case .left:
            stickH = self.leftStickH
            stickV = self.leftStickV
        case .right:
            stickH = self.rightStickH
            stickV = self.rightStickV
        }
        
        
        stickV.snp.updateConstraints { (make) in
            if top > 0 {
                // Top
                make.top.equalTo(Float(75 - _stickSize / 2) * (1 - top))
                make.bottom.equalTo(-(75 - _stickSize / 2))
            } else {
                // Bottom
                make.top.equalTo((75 - _stickSize / 2))
                make.bottom.equalTo(-Float(75 - _stickSize / 2) * (1 + top))
            }
        }
        
        stickH.snp.updateConstraints { (make) in
            if left > 0 {
                // right
                make.left.equalTo(75 - _stickSize / 2)
                make.right.equalTo(-Float(75 - _stickSize / 2) * (1 - left))
            } else {
                // left
                make.left.equalTo(Float(75 - _stickSize / 2) * (1 + left))
                make.right.equalTo(-(75 - _stickSize / 2))
            }
        }
    }
}

// MARK: UI
fileprivate extension DDKRCViewController {
    func setupSubviews() {
        self.setupLeftContainer()
        self.setupLeftStick()
        self.setupRightContainer()
        self.setupRightStick()
    }
    
    func setupLeftContainer() {
        self.leftContainer = {
            let view = UIView()
            view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.96, alpha: 1)
            view.layer.cornerRadius = 75
            self.view.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.view)
                make.left.equalTo(self.view).offset(110)
                make.size.equalTo(CGSize(width: 150, height: 150))
            })
            return view
        }()
        
        self.leftTopLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.ddkVIBlue
            self.view.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.leftContainer)
                make.bottom.equalTo(self.leftContainer.snp.top).offset(-10)
            })
            return label
        }()
        
        self.leftLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.ddkVIBlue
            self.view.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.leftContainer)
                make.right.equalTo(self.leftContainer.snp.left).offset(-10)
            })
            return label
        }()
        
        let vertical = UIView()
        vertical.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.94, alpha: 1)
        vertical.layer.cornerRadius = 5
        self.leftContainer.addSubview(vertical)
        vertical.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(self.leftContainer)
            make.width.equalTo(10)
        }
        
        let horizontal = UIView()
        horizontal.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.94, alpha: 1)
        horizontal.layer.cornerRadius = 5
        self.leftContainer.addSubview(horizontal)
        horizontal.snp.makeConstraints { (make) in
            make.left.right.centerY.equalTo(self.leftContainer)
            make.height.equalTo(10)
        }
    }
    
    func setupLeftStick() {
        self.leftStickV = {
            let view = UIView()
            view.backgroundColor = _viColor
            self.leftContainer.addSubview(view)
            view.layer.cornerRadius = 5
            
            view.snp.makeConstraints { (make) in
                make.top.left.equalTo(self.leftContainer).offset(75 - _stickSize / 2)
                make.bottom.right.equalTo(self.leftContainer).offset(-(75 - _stickSize / 2))
            }
            return view
        }()
        
        self.leftStickH = {
            let view = UIView()
            view.backgroundColor = _viColor
            self.leftContainer.addSubview(view)
            view.layer.cornerRadius = 5
            
            view.snp.makeConstraints { (make) in
                make.top.left.equalTo(self.leftContainer).offset(75 - _stickSize / 2)
                make.bottom.right.equalTo(self.leftContainer).offset(-(75 - _stickSize / 2))
            }
            return view
        }()
    }
    
    func setupRightContainer() {
        self.rightContainer = {
            let view = UIView()
            view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.96, alpha: 1)
            view.layer.cornerRadius = 75
            self.view.addSubview(view)
            view.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.view)
                make.right.equalTo(self.view).offset(-110)
                make.size.equalTo(CGSize(width: 150, height: 150))
            })
            return view
        }()
        
        self.rightTopLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.ddkVIBlue
            self.view.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.rightContainer)
                make.bottom.equalTo(self.rightContainer.snp.top).offset(-10)
            })
            return label
        }()
        
        self.rightLabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.ddkVIBlue
            self.view.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.rightContainer)
                make.left.equalTo(self.rightContainer.snp.right).offset(10)
            })
            return label
        }()
        
        let vertical = UIView()
        vertical.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.94, alpha: 1)
        vertical.layer.cornerRadius = 5
        self.rightContainer.addSubview(vertical)
        vertical.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(self.rightContainer)
            make.width.equalTo(10)
        }
        
        let horizontal = UIView()
        horizontal.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.94, alpha: 1)
        horizontal.layer.cornerRadius = 5
        self.rightContainer.addSubview(horizontal)
        horizontal.snp.makeConstraints { (make) in
            make.left.right.centerY.equalTo(self.rightContainer)
            make.height.equalTo(10)
        }
    }
    
    func setupRightStick() {
        self.rightStickV = {
            let view = UIView()
            view.backgroundColor = _viColor
            view.layer.cornerRadius = 5
            self.rightContainer.addSubview(view)
            
            view.snp.makeConstraints { (make) in
                make.top.left.equalTo(self.rightContainer).offset(75 - _stickSize / 2)
                make.bottom.right.equalTo(self.rightContainer).offset(-(75 - _stickSize / 2))
            }
            return view
        }()
        
        self.rightStickH = {
            let view = UIView()
            view.backgroundColor = _viColor
            view.layer.cornerRadius = 5
            self.rightContainer.addSubview(view)
            
            view.snp.makeConstraints { (make) in
                make.top.left.equalTo(self.rightContainer).offset(75 - _stickSize / 2)
                make.bottom.right.equalTo(self.rightContainer).offset(-(75 - _stickSize / 2))
            }
            return view
        }()
    }
}

extension DDKRCViewController: DJIRemoteControllerDelegate {
    public func remoteController(_ rc: DJIRemoteController, didUpdate state: DJIRCHardwareState) {
        let leftV = state.leftStick.verticalPosition
        let leftH = state.leftStick.horizontalPosition
        self.moveLeftStick(top: Float(leftV) / 660.0, left: Float(leftH) / 660.0)
        self.leftTopLabel.text = "\(leftV)"
        self.leftLabel.text = "\(leftH)"
        
        let rightV = state.rightStick.verticalPosition
        let rightH = state.rightStick.horizontalPosition
        self.moveRightStick(top: Float(rightV) / 660.0, left: Float(rightH) / 660.0)
        self.rightTopLabel.text = "\(rightV)"
        self.rightLabel.text = "\(rightH)"
    }
}
