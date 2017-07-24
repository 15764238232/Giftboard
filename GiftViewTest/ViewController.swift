//
//  ViewController.swift
//  GiftViewTest
//
//  Created by DSY on 2017/7/24.
//  Copyright © 2017年 DSY. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,GiftViewDelegate{

    let giftView = GiftView()

    override func viewDidLoad() {
        super.viewDidLoad()

         let gift1 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)
         let gift2 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "box")!, giftPrice: 12, tradeType: .Diamonds)
         let gift3 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)
         let gift4 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "box")!, giftPrice: 12, tradeType: .Diamonds)
         let gift5 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)

        let gift6 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)
        let gift7 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "box")!, giftPrice: 12, tradeType: .Diamonds)
        let gift8 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)
        let gift9 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "box")!, giftPrice: 12, tradeType: .Diamonds)
        let gift10 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "cake")!, giftPrice: 12, tradeType: .Diamonds)

        let array = [gift1,gift2,gift3,gift4,gift5,gift6,gift7,gift8,gift9,gift10,gift1,gift2,gift3,gift4,gift5,gift6]

        giftView.initGiftView(giftViewHeight: 270, giftbeans: array, deletage: self)
        giftView.showGiftBoard(vc: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func sendButtonOnClickListener(currendGift:GiftBean){

        print(currendGift)
        giftView.startGiftAnimation(giftBean: currendGift)
    }

    func rechargeButtonOnclickListener(){

    }
}

