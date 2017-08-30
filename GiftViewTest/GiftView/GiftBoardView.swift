//
//  GiftBoardView.swift
//  GiftViewTest
//
//  Created by DSY on 2017/7/24.
//  Copyright © 2017年 DSY. All rights reserved.
//

import Foundation
import UIKit

protocol GiftViewDelegate {
    func sendButtonOnClickListener(currendGift:GiftBean);
    func rechargeButtonOnclickListener();
}

class GiftBoardView:UIView{

    fileprivate var vc:UIViewController?

    fileprivate var giftbeans : [GiftBean]{
        let gift1 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "鲜花", tradeType: .Diamonds)
        let gift2 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "鸡蛋", tradeType: .Diamonds)
        let gift3 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "鼓掌", tradeType: .Diamonds)
        let gift4 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "糖果", tradeType: .Diamonds)
        let gift5 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "布娃娃", tradeType: .Diamonds)
        let gift6 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "巧克力", tradeType: .Diamonds)
        let gift7 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "么么哒", tradeType: .Diamonds)
        let gift8 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "丘比特", tradeType: .Diamonds)
        let gift9 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "我爱你", tradeType: .Diamonds)
        let gift10 = GiftBean.init(giftId: 0, giftImage: UIImage.init(named: "tabbar-games-selected")!, giftPrice: 12, giftName: "热气球", tradeType: .Diamonds)
        return [gift1,gift2,gift3,gift4,gift5,gift6,gift7,gift8,gift9,gift10]
    }

    fileprivate var currentChoosedGift : GiftBean?
    public var viewFlag = false

    public var lastCell : GiftCollectionViewCell? //上次点击的cell
    public var deletage : GiftViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        UINib(nibName: "VoiceRecordDialog", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "VoiceRecordDialog", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = bounds
    }

    public func initGiftView(){



    }

    fileprivate func setCollectionView(){

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: Int(UIScreen.main.bounds.width - 4) / 5, height: 120)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1

        collectionView.register(UINib.init(nibName: "GiftCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "GiftCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //点击背景view,退出表情键盘
    public  func backViewTap(_ gestureRecognizer: UIGestureRecognizer){

        if(viewFlag){
            UIView.animate(withDuration: 0.2, animations: {
                self.changedConstraint?.constant = 0
            }, completion: { (isFinish) in
                self.dissmissGiftBoard()
            })
        }
    }

    //开放的方法,弹出表情键盘
    func showGiftBoard(vc:UIViewController){
        if !viewFlag{
            vc.view.addSubview(self)
            let ges = UITapGestureRecognizer.init(target: self, action: #selector(backViewTap(_:)))
            view?.addGestureRecognizer(ges)
            viewFlag = true
        }
    }

    //开放的方法,关闭表情键盘
    func dissmissGiftBoard(){
        if viewFlag{
            self.removeFromSuperview()
            viewFlag = false
        }
    }

    /**
     右上角的关闭按钮
     **/
    fileprivate func initCloseButton(){

//        closeButton.setTitleColor(UIColor.gray, for: .normal)
//        closeButton.addTarget(self, action: #selector(dissmissGiftBoard), for: .touchUpInside)

    }

    /**
     开启礼物赠送的动画,可随意修改
     **/
    func startGiftAnimation(giftBean:GiftBean){

        var giftImageView : UIImageView?
        giftImageView = UIImageView.init(frame: CGRect.init(x: screenWidth / 2 - 45, y: screenHeight / 2 - 70, width: 90, height: 90))
        giftImageView?.image = giftBean.giftImage
        giftImageView?.alpha = 0
        vc?.view.addSubview(giftImageView!)

        UIView.animate(withDuration: 0.5) {
            giftImageView?.alpha = 1
        }

        let time: TimeInterval = 1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            UIView.animate(withDuration: 0.5, animations: {
                 giftImageView?.alpha = 0.1
            }, completion: { (end) in
                if(end){
                    giftImageView?.removeFromSuperview()
                    giftImageView = nil
                }
            })
        }
    }

    /**
     赠送礼物的点击事件
     **/
    func sendButtonClick(){

        if(currentChoosedGift != nil){

            deletage?.sendButtonOnClickListener(currendGift: currentChoosedGift!)
        }else{
            print("没有选中的礼物")
        }
    }
}

extension GiftView :UICollectionViewDelegate,UICollectionViewDataSource{

    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

//        if(giftbeans.count <= 8){
//
//            return giftbeans.count
//        }else{
//
//            if(collectionView.tag != collectionViews.count - 1){
//                return 8
//            }else{
//                return giftbeans.count % 8
//            }
//        }

        return 10
    }

    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftCollectionViewCell", for: indexPath as IndexPath) as! GiftCollectionViewCell
            let giftType = giftbeans[indexPath.row].tradeType == .Diamonds ? "钻石":"金币"
            cell.giftImage.image = giftbeans[indexPath.row].giftImage
            cell.giftName.text = giftbeans[indexPath.row].giftname
            cell.giftPrice.text = "\(Int(giftbeans[indexPath.row].giftPrice))\(giftType)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let currentIndex = collectionView.tag * 8 + indexPath.row
        currentChoosedGift = giftbeans[currentIndex]

        let cell = collectionView.cellForItem(at: indexPath) as! GiftCollectionViewCell

        if(lastCell != nil){
            lastCell?.roundView.layer.borderColor = UIColor.clear.cgColor
            lastCell?.roundView.layer.borderWidth = 0
        }

        cell.roundView.layer.borderColor = UIColor.red.cgColor
        cell.roundView.layer.borderWidth = 2
        cell.roundView.layer.cornerRadius = 8
        lastCell = cell;

    }
}
