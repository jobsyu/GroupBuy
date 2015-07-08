//
//  CityViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//
#define groupTag 999

#import "CityViewController.h"
#import "MJExtension.h"
#import "CityGroup.h"
#import "Masonry.h"

@interface CityViewController()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSArray *cityGroups;
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CityViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"城市切换";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" selectedImage:@"btn_navigation_close_hl"];
    
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    self.cityGroups = [CityGroup objectArrayWithFilename:@"cityGroups.plist"];
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 搜索框代理方法
/**
 *  键盘弹出，文本框开始编辑
 */
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //添加遮盖
    UIButton *cover = [[UIButton alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    cover.tag = groupTag;
    [cover addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:searchBar action:@selector(resignFirstResponder)]];
    [self.view addSubview:cover];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_left);
        make.right.equalTo(self.tableView.mas_right);
        make.top.equalTo(self.tableView.mas_top);
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];
    
    //修改搜索框背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //隐藏遮盖
    [[self.view viewWithTag:groupTag] removeFromSuperview];
    
    //修改搜索框背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    CityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CityGroup *group = self.cityGroups[section];
    return group.title;
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  [self.cityGroups valueForKey:@"title"];
}
@end
