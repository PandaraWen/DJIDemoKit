//
//  DDKStartTableSectionHeader.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/9/1.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit
import SnapKit

public class DDKTableSectionHeader: UITableViewHeaderFooterView {
    public weak var titleLabel: UILabel!
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
fileprivate extension DDKTableSectionHeader {
    func setupSubviews() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(r: 0, g: 140, b: 255, a: 1)
        self.addSubview(headerView)
        headerView.snp.makeConstraints({ (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(4)
        })
        
        self.titleLabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = UIColor.ddkVIBlue
            self.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.left.equalTo(headerView.snp.right).offset(8)
                make.top.right.bottom.equalTo(self)
            })
            return label
        }()
    }
}
