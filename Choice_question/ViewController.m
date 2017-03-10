//
//  ViewController.m
//  Choice_question
//
//  Created by 张晓烨 on 2017/1/8.
//  Copyright © 2017年 zxy. All rights reserved.
//

#import "ViewController.h"
#import "QRadioButton.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,QRadioButtonDelegate>
{
    UITableView *TableView;
    NSMutableArray *MuArr;
    float cellHeight;
    NSMutableDictionary *answerMuDic;//答案的字典
    
}
@end
#pragma mark - type : 1->单选 2 ->多选 3->是非题
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellHeight = 200;
    
    answerMuDic = [[NSMutableDictionary alloc]init];
    
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    TableView.dataSource = self;
    TableView.delegate = self;
    TableView.allowsSelection = NO;
    
    [self.view addSubview:TableView];
    
    MuArr = [[NSMutableArray alloc]init];
    
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"苹果"},
                                @{@"num":@"2",@"string":@"西瓜"},
                                @{@"num":@"3",@"string":@"草莓"},
                                @{@"num":@"4",@"string":@"香蕉"}],@"type":@"2",@"question":@"第一题"}];
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"苹果"},
                                @{@"num":@"2",@"string":@"西瓜"},
                                @{@"num":@"3",@"string":@"草莓"},
                                @{@"num":@"4",@"string":@"香蕉"}],@"type":@"1",@"question":@"第二题"}];
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"苹果"},
                                @{@"num":@"2",@"string":@"西瓜"}],@"type":@"1",@"question":@"第三题"}];
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"苹果"},
                                @{@"num":@"2",@"string":@"西瓜"},
                                @{@"num":@"3",@"string":@"草莓"},
                                @{@"num":@"4",@"string":@"香蕉"}],@"type":@"2",@"question":@"第四题"}];
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"苹果"},
                                @{@"num":@"2",@"string":@"西瓜"},
                                @{@"num":@"3",@"string":@"草莓"}],@"type":@"1",@"question":@"第五题"}];
    
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"是"},
                                @{@"num":@"2",@"string":@"否"}],@"type":@"3",@"question":@"第六题"}];
    
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"是"},
                                @{@"num":@"2",@"string":@"否"}],@"type":@"3",@"question":@"第七题"}];
    
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"是"},
                                @{@"num":@"2",@"string":@"否"}],@"type":@"3",@"question":@"第八题"}];
    
    [MuArr addObject:@{@"num":@[@{@"num":@"1",@"string":@"是"},
                                @{@"num":@"2",@"string":@"否"}],@"type":@"3",@"question":@"第九题"}];
    
    for (int i = 1; i <= MuArr.count; i ++) {
        
        [answerMuDic setObject:@"" forKey:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return MuArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    UILabel *question = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 15, [self heightForString:MuArr[indexPath.row][@"question"] fontSize:15 andWidth:self.view.frame.size.width - 15])];
    
    question.numberOfLines = 0;
    
    question.text = MuArr[indexPath.row][@"question"];
    
    [cell addSubview:question];
    
    if ([MuArr[indexPath.row][@"type"] isEqualToString:@"1"]) {
        
        for (int i = 0 ; i < [MuArr[indexPath.row][@"num"] count]; i ++) {
            
            QRadioButton *radio = [[QRadioButton alloc] initWithDelegate:self groupId:[NSString stringWithFormat:@"%ld",(long)indexPath.row] type:1 answer:MuArr[indexPath.row][@"num"][i][@"num"]];
            radio.frame = CGRectMake(20, question.frame.size.height + 5 + i * 40, cell.frame.size.width - 25, 40);
            [radio setTitle:MuArr[indexPath.row][@"num"][i][@"string"] forState:UIControlStateNormal];
            [radio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [radio.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            [cell addSubview:radio];
            
            if ([[answerMuDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]] rangeOfString:[NSString stringWithFormat:@"%d",i+1]].location != NSNotFound) {
                
                radio.checked = YES;
            }
        }
        
 
    }else if ([MuArr[indexPath.row][@"type"] isEqualToString:@"2"]){
        
        for (int i = 0 ; i < [MuArr[indexPath.row][@"num"] count]; i ++) {
            QRadioButton *radio = [[QRadioButton alloc] initWithDelegate:self groupId:[NSString stringWithFormat:@"%@+%ld",[[NSUUID UUID] UUIDString],(long)indexPath.row] type:2 answer:MuArr[indexPath.row][@"num"][i][@"num"]];
            radio.frame = CGRectMake(20, question.frame.size.height + 5 + i * 40, cell.frame.size.width - 25, 40);
            [radio setTitle:MuArr[indexPath.row][@"num"][i][@"string"] forState:UIControlStateNormal];
            [radio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [radio.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            [cell addSubview:radio];
            
            if ([[answerMuDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]] rangeOfString:[NSString stringWithFormat:@"%d",i+1]].location != NSNotFound) {
                
                radio.checked = YES;
            }
            
        }
        
    }else if ([MuArr[indexPath.row][@"type"] isEqualToString:@"3"]){
    
        for (int i = 0 ; i < [MuArr[indexPath.row][@"num"] count]; i ++) {
            QRadioButton *radio = [[QRadioButton alloc] initWithDelegate:self groupId:[NSString stringWithFormat:@"%ld",(long)indexPath.row] type:3 answer:MuArr[indexPath.row][@"num"][i][@"num"]];
            radio.frame = CGRectMake(20 + + i * (cell.frame.size.width - 40) / 2, question.frame.size.height + 5 , (cell.frame.size.width - 40) / 2, 40);
            
            [radio setTitle:MuArr[indexPath.row][@"num"][i][@"string"] forState:UIControlStateNormal];
            [radio setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [radio.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            [cell addSubview:radio];
            
            if ([[answerMuDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]] rangeOfString:MuArr[indexPath.row][@"num"][i][@"string"]].location != NSNotFound) {
                
                radio.checked = YES;
            }
            
        }
        
    }else{
        
    }
    if ([MuArr[indexPath.row][@"type"] isEqualToString:@"3"]) {
        
        cellHeight = 40 + question.frame.size.height +5;
        
    }else{
        cellHeight = [MuArr[indexPath.row][@"num"] count] * 40 + question.frame.size.height +5;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId type:(int)type answer:(NSString *)answer{
    
    //    NSLog(@"did selected radio:%@ groupId:%@ type:%d answer:%@", radio.titleLabel.text, groupId, type, answer);
    
    if (type == 1) {
        
        [answerMuDic setObject:answer forKey:[NSString stringWithFormat:@"%d",[groupId intValue] + 1]];
        
    }else if (type == 2){
        
        NSArray *array = [groupId componentsSeparatedByString:@"+"]; //从字符A中分隔成2个元素的数组
        
        if ([[answerMuDic allKeys] containsObject:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]]){
            
            [answerMuDic setObject:[NSString stringWithFormat:@"%@,%@",[answerMuDic objectForKey:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]],answer] forKey:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]];
            
            
        }else{
            
            [answerMuDic setObject:answer forKey:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]];
            
        }

    }else if (type == 3){
         [answerMuDic setObject:radio.titleLabel.text forKey:[NSString stringWithFormat:@"%d",[groupId intValue] + 1]];
    }
}

- (void)didDeselectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId type:(int)type answer:(NSString *)answer{
    
    NSLog(@"did selected radio:%@ groupId:%@ type:%d answer:%@", radio.titleLabel.text, groupId, type, answer);
    
    NSArray *array = [groupId componentsSeparatedByString:@"+"]; //从字符A中分隔成2个
    NSString *answerStr = [answerMuDic objectForKey:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]];
    answerStr = [answerStr stringByReplacingOccurrencesOfString:answer withString:@""];
    
    //去除字符串中多余的逗号
    NSArray *parts = [answerStr componentsSeparatedByString:@","];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    NSString *ResultStr = [filteredArray componentsJoinedByString:@","];
    
    [answerMuDic setObject:ResultStr forKey:[NSString stringWithFormat:@"%d",[array[1] intValue] + 1]];
    
}

-(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];  detailTextView.font = [UIFont systemFontOfSize:fontSize];  detailTextView.text = value; CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)]; return deSize.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
