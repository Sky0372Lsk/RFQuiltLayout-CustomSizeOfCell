//
//  ViewController.m
//  RFQuiltLayout-masterByMyself
//
//  Created by 李尚锴 on 15/12/9.
//  Copyright © 2015年 shangkai. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RFQuiltLayoutDelegate> {
    BOOL isAnimating;
}
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSMutableArray* numbers;
@property (nonatomic) NSMutableArray* numberWidths;
@property (nonatomic) NSMutableArray* numberHeights;

@property (nonatomic) UIEdgeInsets uiEdgeInsets;
@property (nonatomic) NSInteger NumOfImage;
@property (nonatomic) NSArray *dateArrrayWidth;
@property (nonatomic) NSArray *dateDictOfHeight;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self datasInit];
    //    RFQuiltLayout *layout = [[RFQuiltLayout alloc]init];
    //    layout.delegate = self;
    //    layout.direction = UICollectionViewScrollDirectionVertical;
    //    layout.blockPixels = CGSizeMake(1,1);
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView reloadData];
}

////数据初始化
//- (void)datasInit {
//    self.uiEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    self.NumOfImage = 88;
//    self.numbers = [NSMutableArray array];
//    self.numberWidths = [NSMutableArray array];
//    self.numberHeights = [NSMutableArray array];
//    for(int num = 0; num < self.NumOfImage; num++) {
//        [self.numbers addObject:@(num)];
//        [self.numberWidths addObject:@([self randomLength])];
//        [self.numberHeights addObject:@([self randomLength])];
//    }
//}

//数据初始化
- (void)datasInit {
    self.uiEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //    self.NumOfImage = 1;
    //    self.dateArrrayWidth = @[@"375"];
    //    self.dateDictOfHeight = @[@"200"];
    
    //    self.NumOfImage = 2;
    //    self.dateArrrayWidth = @[@"188",@"187"];
    //    self.dateDictOfHeight = @[@"200",@"200"];
    
    //    self.NumOfImage = 3;
    //    self.dateArrrayWidth = @[@"125",@"125",@"125"];
    //    self.dateDictOfHeight = @[@"200",@"200",@"200"];
    
    //    self.NumOfImage = 4;
    //    self.dateArrrayWidth = @[@"93",@"94",@"95",@"93"];
    //    self.dateDictOfHeight = @[@"200",@"200",@"200",@"200"];
    
//    self.NumOfImage = 5;
//    self.dateArrrayWidth = @[@"75",@"75",@"75",@"75",@"75"];
//    self.dateDictOfHeight = @[@"75",@"75",@"75",@"75",@"75"];
    
    self.NumOfImage = 9;
    self.dateArrrayWidth = @[@"75",@"75",@"75",@"75",@"75",@"150",@"94",@"95",@"93"];
    self.dateDictOfHeight = @[@"75",@"75",@"75",@"75",@"75",@"150",@"94",@"95",@"93"];
    
    self.numbers = [NSMutableArray array];
    self.numberWidths = [NSMutableArray array];
    self.numberHeights = [NSMutableArray array];
    
    for(int num = 0; num < self.NumOfImage; num++) {
        [self.numbers addObject:@(num)];
        [self.numberWidths addObject:self.dateArrrayWidth[num]];
        [self.numberHeights addObject:self.dateDictOfHeight[num]];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (UIColor*) colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

#pragma mark - private method

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        RFQuiltLayout *layout = [[RFQuiltLayout alloc]init];
        layout.direction = UICollectionViewScrollDirectionVertical;
        layout.delegate = self;
        layout.blockPixels = CGSizeMake(1,1);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, 375, 675-20) collectionViewLayout:layout];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.numbers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [self colorForNumber:self.numbers[indexPath.row]];
    
    UILabel* label = (id)[cell viewWithTag:5];
    if(!label) label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    label.tag = 5;
    label.textColor = [UIColor blackColor];
    label.text = [NSString stringWithFormat:@"%@", self.numbers[indexPath.row]];
    label.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    return cell;
}


#pragma mark – RFQuiltLayoutDelegate

//获取宽和高
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= self.numbers.count) {
        NSLog(@"Asking for index paths of non-existant cells!! %ld from %lu cells", (long)indexPath.row, (unsigned long)self.numbers.count);
    }
    
    CGFloat width = [[self.numberWidths objectAtIndex:indexPath.row] floatValue];
    CGFloat height = [[self.numberHeights objectAtIndex:indexPath.row] floatValue];
    return CGSizeMake(width, height);
}

//传上下左右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.uiEdgeInsets;
}

#pragma mark - Helper methods

- (NSUInteger)randomLength
{
    // always returns a random length between 1 and 3, weighted towards lower numbers.
    NSUInteger result = arc4random() % 6;
    
    // 3/6 chance of it being 1.
    if (result <= 2)
    {
        result = 1;
    }
    // 1/6 chance of it being 3.
    else if (result == 5)
    {
        result = 3;
    }
    // 2/6 chance of it being 2.
    else {
        result = 2;
    }
    
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
