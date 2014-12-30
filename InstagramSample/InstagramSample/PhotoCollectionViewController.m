//
//  PhotoCollectionViewController.m
//  InstagramSample
//
//  Created by Keisei SHIGETA on 2014/12/30.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "InstagramAPIClient.h"
#import <Haneke.h>

@interface PhotoCollectionViewController ()
@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //invokeOAuthの直後かつhasAuthenticatedがまだfalseのときに再度viewDidAppearが呼ばれて、2回認証がはしってそう
    __weak PhotoCollectionViewController *weakSelf = self;
    if ([[InstagramAPIClient sharedClient] hasAuthenticated]) {
        [[InstagramAPIClient sharedClient] getMyPhotoListWithCompleteBlock:^(NSArray *data) {
            weakSelf.photoCollection = data; //本当はエンティティつくったほうがいいけど、簡単のために生のレスポンスをいれてる
            [weakSelf.collectionView reloadData];
        }];
    } else {
        [[InstagramAPIClient sharedClient] invokeOAuth];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // get image
    NSString *urlString = [_photoCollection[indexPath.row] valueForKeyPath:@"images.low_resolution.url"];
    NSURL *url = [NSURL URLWithString:urlString];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds]; //cell.frameにすると全部storyboardのprototype cellの位置になって重なってしまうので注意・・・・！！！！
    [imageView hnk_setImageFromURL:url];

    // set image
    [cell.contentView addSubview:imageView];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
