//
//  XUTableViewCell.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/27.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit


class XUTableViewCell: UITableViewCell {
    var mainImageView : UIImageView!
    var titleLabel: UILabel!
    var subTitleLabel:UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
      self.selectionStyle = UITableViewCellSelectionStyle.None
        
     self.drawView()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawView() -> Void {
        
        mainImageView = UIImageView(frame: CGRectMake(25, 10, 120, 80))
        self.contentView .addSubview(mainImageView)
        
        titleLabel = UILabel(frame:CGRectMake(155, 10, 200, 40))
        titleLabel.textColor = UIColor(red:0.86, green:0.24, blue:0.22, alpha:1)
        self.contentView.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(155, 50, 200, 40))
        self.contentView.addSubview(subTitleLabel)
        
        
        
    }

    func drawCellWithModel(model:VideoModel) ->Void {
        
        titleLabel.text = model.video_title as String
        subTitleLabel.text = model.video_subTitle as String
        
        mainImageView.setWebImageWithUrlStr(model.video_img as? String)
    }
    func drawMusicWithModel(model:MusicModel) ->Void {
        
        titleLabel.text = model.name as String
        subTitleLabel.text = model.cname as String
        
        mainImageView.setWebImageWithUrlStr(model.img)
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
