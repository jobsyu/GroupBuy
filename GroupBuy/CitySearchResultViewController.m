//
//  CitySearchResultViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "CitySearchResultViewController.h"
#import "City.h"
#import "MJExtension.h"

@interface CitySearchResultViewController()
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) NSArray *resultCities;
@end

@implementation CitySearchResultViewController

#pragma mark 懒加载
-(NSArray *)cities
{
    if (!_cities) {
        self.cities = [City objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}


-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    searchText =searchText.lowercaseString;
    
    // 谓词\过滤器:能利用一定的条件从一个数组中过滤出想要的数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pinYin contains %@ or pinYinHead contains %@ or name  contains %@",searchText,searchText,searchText];
    self.resultCities = [self.cities filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}

#pragma mark -数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultCities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier =@"result";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    City *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共返回%ld个结果",self.resultCities.count];
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = self.resultCities[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:CityDidChangeNotification object:nil userInfo:@{SelectCityName : city.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
