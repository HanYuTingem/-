//
//  OtherShopListViewController.h
//  HCheap
//

/*
 其他商户
 */
#import "BaseViewController.h"
#import "OtherShopListTableViewCell.h"

@interface OtherShopListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,OtherShopListTableViewCellDelegate>

@property(nonatomic,strong)NSArray *shopListMutableArray;//商户数组
@property(nonatomic,strong)NSString *name;


@end
