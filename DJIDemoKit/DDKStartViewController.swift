//
//  ViewController.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit
import DJISDK

public protocol DDKStartViewControllerDelegate: NSObjectProtocol {
    func startViewControllerDidClickGoButton(_ viewCon: DDKStartViewController)
}

public class DDKStartViewController: UIViewController {
    fileprivate var goButton: UIButton!
    fileprivate var tableview: UITableView!
    public weak var delegate: DDKStartViewControllerDelegate?
    
    fileprivate var infoTitles = ["Model", "Activation state", "Binding state"]
    fileprivate var settingTitles = ["📟 Use Remote log", "⛓ Enable bridge", "🎚 Log enable"]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Start up"
        self.view.backgroundColor = UIColor.white
        
        self.setupGoButton()
        self.setupTableview()
        self.refreshComponents()
        DJISDKManager.appActivationManager().delegate = self
        DJISDKManager.registerApp(with: self)
    }
}

// MARK: UI
fileprivate extension DDKStartViewController {
    func setupGoButton() {
        self.goButton = {
            let button = UIButton()
            button.setBackgroundImage(UIImage.image(of: UIColor.ddkVIBlue, with: CGSize(width: 1, height: 1)), for: .normal)
            button.addTarget(self, action: #selector(onGoButtonClicked(_:)), for: .touchUpInside)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitle("Go", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            self.view.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalTo(self.view)
                make.height.equalTo(45)
            })
            return button
        }()
    }
    
    func setupTableview() {
        self.tableview = {
            let tableview = UITableView()
            tableview.delegate = self
            tableview.dataSource = self
            tableview.backgroundColor = UIColor.clear
            if #available(iOS 11.0, *) {
                tableview.contentInsetAdjustmentBehavior = .never
            }
            tableview.delaysContentTouches = false
            tableview.register(DDKTableSectionHeader.self, forHeaderFooterViewReuseIdentifier: "DDKTableSectionHeader")
            tableview.tableFooterView = UITableView()
            self.view.addSubview(tableview)
            tableview.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.view).offset(20)
                make.bottom.equalTo(self.goButton.snp.top)
            })
            return tableview
        }()
    }
}

// MARK: Private methods
fileprivate extension DDKStartViewController {
    func string(from activationState: DJIAppActivationState) -> String {
        var activationStateString = ""
        switch activationState {
        case .activated:
            activationStateString = "Activated"
        case .loginRequired:
            activationStateString = "LoginRequired"
        case .notSupported:
            activationStateString = "NotSupported"
        case .unknown:
            activationStateString = "Unknown"
        }
        
        return activationStateString
    }
    
    func string(from bindingState: DJIAppActivationAircraftBindingState) -> String {
        var bindingStateString = ""
        switch bindingState {
        case .bound:
            bindingStateString = "Bound"
        case .initial:
            bindingStateString = "Initial"
        case .notRequired:
            bindingStateString = "NotRequired"
        case .notSupported:
            bindingStateString = "NotSupported"
        case .unbound:
            bindingStateString = "Unbound"
        case .unboundButCannotSync:
            bindingStateString = "UnboundButCannotSync"
        case .unknown:
            bindingStateString = "Unknown"
        }
        
        return bindingStateString
    }
    
    func refreshComponents() {
        self.tableview.reloadData()
        self.goButton.isEnabled = (DJISDKManager.appActivationManager().appActivationState == .activated && DJISDKManager.appActivationManager().aircraftBindingState == .bound)
    }
    
    func setInfoCellDetail(_ infoCell: UITableViewCell, at row: Int) {
        switch row {
        case 0: // Model name
            infoCell.detailTextLabel?.text = DDKComponentHelper.fetchProduct()?.model ?? "Not connected"
        case 1: // Activation state
            infoCell.detailTextLabel?.text = self.string(from: DJISDKManager.appActivationManager().appActivationState)
        case 2: // Binding state
            infoCell.detailTextLabel?.text = self.string(from: DJISDKManager.appActivationManager().aircraftBindingState)
        default:
            break
        }
        
        infoCell.textLabel?.text = self.infoTitles[row]
    }
    
    func setSettingCellDetail(_ settingCell: UITableViewCell, at row: Int) {
        switch row {
        case 0: // Remote log
            settingCell.detailTextLabel?.text = DDKConfig.default.enableRemoteLog ? "✅" : "No"
        case 1: // Bridger
            settingCell.detailTextLabel?.text = DDKConfig.default.enableBridger ? "✅" : "No"
        case 2: // Log enable
            settingCell.detailTextLabel?.text = DDKLogger.shareLogger.enable ? "✅" : "No"
        default:
            break
        }
        
        settingCell.textLabel?.text = self.settingTitles[row]
    }
}

// MARK: Actions
fileprivate extension DDKStartViewController {
    @objc func onGoButtonClicked(_ sender: Any) {
        self.delegate?.startViewControllerDidClickGoButton(self)
    }
}

// MARK: Settings
fileprivate extension DDKStartViewController {
    func enableRemoteLog() {
        let alert = UIAlertController(title: "Use remote log", message: "Input remote log server's ip and port", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "192.168.x.x"
            if let remoteLogIP = UserDefaults.standard.object(forKey: kUDRemoteLogIP) as? String {
                textfield.text = remoteLogIP
            }
        })
        
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "4567"
            if let remoteLogPort = UserDefaults.standard.object(forKey: kUDRemoteLogPort) as? String {
                textfield.text = remoteLogPort
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            guard let ip = alert.textFields![0].text, let port = alert.textFields![1].text else {
                return
            }
            
            UserDefaults.standard.set(ip, forKey: kUDRemoteLogIP)
            UserDefaults.standard.set(port, forKey: kUDRemoteLogPort)
            
            DDKConfig.default.enableRemoteLog(ip: ip, port: port)
            ddkLogOK("Remote log set up")
            self.tableview.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func enableBridger() {
        let alert = UIAlertController(title: "Use remote log", message: "Input remote log server's ip and port", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "192.168.x.x"
            if let remoteLogIP = UserDefaults.standard.object(forKey: kUDBridgerIP) as? String {
                textfield.text = remoteLogIP
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            guard let ip = alert.textFields![0].text else {
                return
            }
            
            UserDefaults.standard.set(ip, forKey: kUDBridgerIP)
            
            DJISDKManager.stopConnectionToProduct()
            DDKConfig.default.enableBridger(ip: ip)
            
            self.tableview.reloadData()
            
            if DDKComponentHelper.fetchProduct() == nil {
                DJISDKManager.enableBridgeMode(withBridgeAppIP: DDKConfig.default.bridgerIP)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension DDKStartViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 1 else {
            return
        }
        
        switch indexPath.row {
        case 0: // Remote log
            self.enableRemoteLog()
        case 1: // Enable bridge
            self.enableBridger()
        case 2: // Log enable
            DDKLogger.shareLogger.enable = !DDKLogger.shareLogger.enable
            self.tableview.reloadData()
        default:
            break
        }
    }
}

extension DDKStartViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DDKTableSectionHeader") as! DDKTableSectionHeader
        switch section {
        case 0:
            header.titleLabel.text = "Infomations"
        case 1:
            header.titleLabel.text = "Settings"
        default:
            break
        }
        return header
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.infoTitles.count
        case 1:
            return self.settingTitles.count
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var infoCell: UITableViewCell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") {
                infoCell = cell
            } else {
                infoCell = UITableViewCell(style: .value1, reuseIdentifier: "InfoCell")
                infoCell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
                infoCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            
            self.setInfoCellDetail(infoCell, at: indexPath.row)
            return infoCell
        case 1:
            var settingCell: UITableViewCell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") {
                settingCell = cell
            } else {
                settingCell = UITableViewCell(style: .value1, reuseIdentifier: "SettingCell")
                settingCell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
                settingCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
                settingCell.accessoryType = .disclosureIndicator
            }
            
            self.setSettingCellDetail(settingCell, at: indexPath.row)
            return settingCell
        default:
            return UITableViewCell()
        }
    }
}

extension DDKStartViewController: DJISDKManagerDelegate {
    public func appRegisteredWithError(_ error: Error?) {
        if let error = error {
            ddkLogError("\(error.localizedDescription)")
        } else {
            ddkLogOK("Register app success")

            if DDKConfig.default.enableBridger && DDKComponentHelper.fetchProduct() == nil {
                DJISDKManager.enableBridgeMode(withBridgeAppIP: DDKConfig.default.bridgerIP)
            } else {
                DJISDKManager.startConnectionToProduct()
            }
        }
    }
    public func productConnected(_ product: DJIBaseProduct?) {
        ddkLogInfo("Product connected: \(product?.model ?? "")")
    }
    
    public func productDisconnected() {
        ddkLogInfo("Product disconnected")
    }
    
    public func componentConnected(withKey key: String?, andIndex index: Int) {
        ddkLogInfo("Component connected: \(key ?? ""), \(index)")
    }
    
    public func componentDisconnected(withKey key: String?, andIndex index: Int) {
        ddkLogInfo("Component disconnected: \(key ?? ""), \(index)")
    }
}

extension DDKStartViewController: DJIAppActivationManagerDelegate {
    public func manager(_ manager: DJIAppActivationManager!, didUpdate appActivationState: DJIAppActivationState) {
        self.refreshComponents()
        if appActivationState == .loginRequired {
            DJISDKManager.userAccountManager().logIntoDJIUserAccount(withAuthorizationRequired: false, withCompletion: { (state, error) in
                if let error = error {
                    DDKHelper.showAlert(title: "Error", message: error.localizedDescription, at: self)
                }
            })
        }
        ddkLogInfo("App activation state: \(appActivationState.rawValue)")
    }
    
    public func manager(_ manager: DJIAppActivationManager!, didUpdate aircraftBindingState: DJIAppActivationAircraftBindingState) {
        self.refreshComponents()
        ddkLogInfo("Aircraft binding state: \(aircraftBindingState.rawValue)")
    }
}

