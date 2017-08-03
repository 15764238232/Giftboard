//
//  GiftView.swift
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

class GiftView:UIView{

   // fileprivate var collectionView1 :UICollectionView?
    fileprivate var scrollView:UIScrollView?
    fileprivate var screenWidth = UIScreen.main.bounds.width
    fileprivate var screenHeight = UIScreen.main.bounds.height
    fileprivate var pageControl = UIPageControl()
    fileprivate var sendButton = UIButton()
    fileprivate var closeButton = UIButton()
    fileprivate let sendBarHeight:CGFloat = 30
    fileprivate var viewFlag = false
    fileprivate var vc:UIViewController?

    fileprivate var collectionViews : [UICollectionView] = []
    fileprivate var giftbeans : [GiftBean] = []
    fileprivate var giftPageCount : CGFloat = 0;  //一页8个礼物,计算出页数
    fileprivate var currentChoosedGift : GiftBean?
    fileprivate var rechargebutton:UIButton?

    public var lastCell : GiftCollectionViewCell? //上次点击的cell
    public var deletage : GiftViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /**
     开放的方法,初始化控件
     @param GiftViewHeight  控件高度
     @param giftbeans  礼物集合
     @param deletage 协议
    **/
    func initGiftView(giftViewHeight:CGFloat,giftbeans : [GiftBean],deletage : GiftViewDelegate){

        self.backgroundColor = UIColor.clear
        vc = deletage as? UIViewController

        //半透明的黑色view
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: giftViewHeight))
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.7
        self.addSubview(bgView)

        self.deletage = deletage
        self.giftbeans = giftbeans

        if(giftbeans.count <= 8){
            giftPageCount = 1
        }else{

            if(giftbeans.count % 8 == 0){

                giftPageCount = CGFloat(giftbeans.count / 8)
            }else{

                giftPageCount = CGFloat(giftbeans.count / 8 + 1)
            }
        }

        self.frame = CGRect.init(x: 0, y: screenHeight - giftViewHeight, width: screenWidth, height: giftViewHeight)
        initScrollView(keyBoardHeight: giftViewHeight)
        initCollectView(keyBoardHeight: giftViewHeight)
        initCloseButton()
        initRechargebutton(keyBoradHeight: giftViewHeight)
    }

    //开放的方法,弹出表情键盘
    func showGiftBoard(vc:UIViewController){
        if !viewFlag{
            vc.view.addSubview(self)
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

    //初始化collectview
    fileprivate  func initCollectView(keyBoardHeight:CGFloat){

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: Int(UIScreen.main.bounds.width - 3) / 4, height: 120)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1

        for index in 0 ..< Int(giftPageCount){

            let collectionView = UICollectionView.init(frame: CGRect.init(x: CGFloat(index) * screenWidth, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)), collectionViewLayout: flowLayout)
            collectionView.backgroundColor = UIColor.gray
            collectionView.tag = index

            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: "GiftCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "GiftCollectionViewCell")
            scrollView?.addSubview(collectionView)
            collectionViews.append(collectionView)
        }

        for index in 0 ..< collectionViews.count{

            print(collectionViews[index].tag)
        }
    }

    //初始化ScrollView
    fileprivate func initScrollView(keyBoardHeight:CGFloat){

        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)))
        scrollView?.contentSize = CGSize.init(width: screenWidth * giftPageCount, height: (keyBoardHeight - sendBarHeight))
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = true
        scrollView?.delegate = self
        scrollView?.backgroundColor = UIColor.clear
        initPageControlAndSendButton(keyBoradHeight: keyBoardHeight)
        self.addSubview(scrollView!)
    }

    /**
     右上角的关闭按钮
     **/
    fileprivate func initCloseButton(){
        closeButton.frame = CGRect.init(x: screenWidth - 22, y: 5, width: 20, height: 20)
        closeButton.setTitle("✕", for: .normal)
        closeButton.addTarget(self, action: #selector(dissmissGiftBoard), for: .touchUpInside)
        self.addSubview(closeButton)
    }

    /**
    充值按钮
     **/
    fileprivate func initRechargebutton(keyBoradHeight:CGFloat){

        rechargebutton = UIButton()
        rechargebutton?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        let rechargebuttonSize = CGSize.init(width: 150, height: 25)
        rechargebutton?.frame =  CGRect.init(x: 5, y: keyBoradHeight - sendBarHeight + (sendBarHeight / 2 - rechargebuttonSize.height / 2 ) - 5 , width: rechargebuttonSize.width, height: rechargebuttonSize.height)
        rechargebutton?.setTitle("(金币:3200,钻石:200)", for: .normal)
        rechargebutton?.setImage(UIImage.init(named: "chongzhi"), for: .normal)
        rechargebutton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.addSubview(rechargebutton!)
    }

    //初始化tPageControl 和 SendButton
    fileprivate func initPageControlAndSendButton(keyBoradHeight:CGFloat){

        let uiPageControlSize = pageControl.size(forNumberOfPages: Int(giftPageCount))

        pageControl.frame = CGRect.init(x: screenWidth / 2 - uiPageControlSize.width / 2, y: keyBoradHeight - sendBarHeight + (sendBarHeight / 2 - uiPageControlSize.height / 2 ) , width: uiPageControlSize.width, height: uiPageControlSize.height)

        pageControl.numberOfPages = Int(giftPageCount)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pageControl.currentPage = 0
        self.addSubview(pageControl)

        let uiSendButtonSize = CGSize.init(width: 45, height: 25)
        sendButton.frame =  CGRect.init(x: screenWidth - uiSendButtonSize.width-10, y: keyBoradHeight - sendBarHeight + (sendBarHeight / 2 - uiSendButtonSize.height / 2 ) - 5 , width: uiSendButtonSize.width, height: uiSendButtonSize.height)
        sendButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        sendButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        sendButton.layer.cornerRadius = 4
        sendButton.setTitle("发送", for: .normal)
        self.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)
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

        return 8
    }

    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftCollectionViewCell", for: indexPath as IndexPath) as! GiftCollectionViewCell
        
        if(giftbeans.count > 0){
            let currentIndex = collectionView.tag * 8 + indexPath.row
            cell.giftImage.image = giftbeans[currentIndex].giftImage
        }

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

extension GiftView :UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollviewW =  scrollView.frame.size.width;
        let x = scrollView.contentOffset.x;
        let page = (x + scrollviewW / 2) /  scrollviewW;
        pageControl.currentPage = Int(page)
    }
}
