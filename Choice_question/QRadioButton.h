//
//  QRadioButton.h
//  Choice_question
//
//  Created by 张晓烨 on 2017/1/8.
//  Copyright © 2017年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRadioButtonDelegate;

@interface QRadioButton : UIButton {
    NSString                        *_groupId;
    BOOL                            _checked;
}

@property(nonatomic, assign)id<QRadioButtonDelegate>   delegate;
@property(nonatomic, copy, readonly)NSString            *groupId;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, assign)int type;//多选或单选
@property(nonatomic, assign)NSString *answer;//选项

- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId type:(int)type answer:(NSString *)answer;

@end

@protocol QRadioButtonDelegate <NSObject>

@optional
// 未选 - 选中
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId type:(int)type answer:(NSString *)answer;
//选中 - 取消选中
- (void)didDeselectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId type:(int)type answer:(NSString *)answer;

@end
