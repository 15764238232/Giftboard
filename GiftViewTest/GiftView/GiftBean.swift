//
//  GiftBean.swift
//  GiftViewTest
//
//  Created by DSY on 2017/7/24.
//  Copyright © 2017年 DSY. All rights reserved.
//  礼物实体类

import Foundation
import UIKit

class GiftBean{

    enum TradeType {
        case Gold
        case Diamonds
    }

    public let giftId : Int        //礼物id
    public let giftImage : UIImage  //礼物图片资源
    public let giftPrice : Double   //礼物价格
    public let tradeType : TradeType  //礼物交易类型(金币和钻石)

    init(giftId : Int,giftImage : UIImage,giftPrice : Double,tradeType : TradeType){
        self.giftId = giftId
        self.giftImage = giftImage
        self.giftPrice = giftPrice
        self.tradeType = tradeType
    }

}
