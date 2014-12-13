//
//  ItemCollectionViewCell.swift
//  PageBasedAppSample
//
//  Created by Keisei SHIGETA on 2014/12/13.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!

    override init() {
        super.init()
    }

    //このイニシャライザが呼ばれる
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setText(text: String?) {
        if (text == nil) {
            textLabel.text = ""
        } else {
            textLabel.text = text
        }
    }
}

