//
//  ChatTableViewCell.swift
//  WeiXinDemo
//
//  Created by 赵晓东 on 16/5/20.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    
    //左边
    var leftHeaderImageView : UIImageView!
    var leftBubbleIamgeView : UIImageView!
    var leftLabel : UILabel!

    
    
    //右边
    var rightHeaderImageView : UIImageView!
    var rightBubbleIamgeView : UIImageView!
    var rightLabel : UILabel!

    
    

    
    // Class 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func prepareUI() {
        
        //左边头像
        self.leftHeaderImageView = createImageView(CGRect(x:5, y:5 ,width: 30, height:30), ImageName: "contact_creat_group@2x.png")
        self.leftHeaderImageView.layer.cornerRadius = self.leftHeaderImageView.frame.width/2
        self.leftHeaderImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.leftHeaderImageView)
        
        
        
        var leftImage = UIImage(named: "ReceiverTextNodeBkg.png")
        
        let leftImageWidth = Int((leftImage?.size.width)!/2)
        let leftImageHeight = Int((leftImage?.size.height)!/2)
        
        leftImage = leftImage?.stretchableImageWithLeftCapWidth(leftImageWidth, topCapHeight: leftImageHeight)
        
        //设置气泡
        self.leftBubbleIamgeView = createImageView(CGRectZero, ImageName: "")
        self.leftBubbleIamgeView.image = leftImage
        self.contentView.addSubview(self.leftBubbleIamgeView)
        
        
        //图片 文字 语言 大表情
        self.leftLabel = createLabel(CGRectZero, Font: 14, Text: "")
        self.leftBubbleIamgeView.addSubview(self.leftLabel)
        self.leftLabel.numberOfLines = 0
        self.leftLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        
        
        
        
        
        
        
        //右边头像
        self.rightHeaderImageView = createImageView(CGRect(x:WIDTH-35, y:5 ,width: 30, height:30), ImageName: "contact_friend@2x.png")
        self.rightHeaderImageView.layer.cornerRadius = 15
        self.rightHeaderImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.rightHeaderImageView)
        
        
        var rightImage = UIImage(named: "SenderVoiceNodeDownloading@2x.png")
        
        let rightImageWidth = Int((leftImage?.size.width)!/2)
        let rightImageHeight = Int((leftImage?.size.height)!/2)
        
        rightImage = rightImage?.stretchableImageWithLeftCapWidth(rightImageWidth, topCapHeight: rightImageHeight)
        
        //设置气泡
        self.rightBubbleIamgeView = createImageView(CGRectZero, ImageName: "")
        self.contentView.addSubview(self.rightBubbleIamgeView)
        self.rightBubbleIamgeView.image = rightImage
        
        //图片 文字 语言 大表情
        self.rightLabel = createLabel(CGRectZero, Font: 14, Text: "")
        self.rightBubbleIamgeView.addSubview(self.rightLabel)
        self.rightLabel.numberOfLines = 0
        self.rightLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
    }
    
    func voiceClick() {
        
    }
    
    
    func configModel(aMsg:WXMessage) {
        
        let size = getTextRectSize(aMsg.body, font: 14, size: CGSizeMake(180, 20000))
        
        //print(size)
        
        //如果是本人发出的消息
        if aMsg.isMe {
            //自己  则单元格文字居右
            
            self.rightHeaderImageView.hidden = false
            self.rightBubbleIamgeView.hidden = false
            self.leftHeaderImageView.hidden = true
            self.leftBubbleIamgeView.hidden = true
            
            //设置气泡大小
            
            rightBubbleIamgeView.frame = CGRectMake(WIDTH-55-size.width-20, 5, size.width+40, size.height+30)
            rightLabel.frame=CGRectMake(15, 4, size.width+10, size.height+10)
            ;
            
            self.rightLabel.text = aMsg.body
        } else {
            //好友的消息字体是桔色 居左
            
            self.rightHeaderImageView.hidden = true
            self.rightBubbleIamgeView.hidden = true
            self.leftHeaderImageView.hidden = false
            self.leftBubbleIamgeView.hidden = false
            
            
            leftBubbleIamgeView.frame = CGRectMake(35, 5, size.width+40, size.height+30)
            leftLabel.frame = CGRectMake(15, 4, size.width+10, size.height+10)
            self.leftLabel.text = aMsg.body
        }
    }
    
    
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
