//
//  ViewController.m
//  SADemo
//
//  Created by zhuopin on 2019/2/11.
//

#import "ViewController.h"
#import <Masonry.h>
#import "PokemonCell.h"
#import "PokemonModel.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initTableView];
}

- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[PokemonCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PokemonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PokemonModel *pokemon = self.models[indexPath.row];
    cell.model = pokemon;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray new];
        NSArray *images = @[
                            @"https://img03.sogoucdn.com/app/a/100520093/ca86e620b9e623ff-d72d635343d5bade-7933792b3fe3e981dcc796505c712ecd.jpg",
                            @"https://real-time.oss-cn-beijing.aliyuncs.com/images/201512/24193347001.jpg",
                            @"https://i04picsos.sogoucdn.com/97628b81cbb775a5",
                            ];
        NSArray *titles = @[
                            @"皮卡丘~⚡️",
                            @"小火龙~🔥",
                            @"波克比~🎤",
                            ];

        for (NSInteger i = 0; i < images.count; i++) {
            PokemonModel *pokemon = [PokemonModel new];
            pokemon.image = images[i];
            pokemon.title = titles[i];
            pokemon.ID = [ViewController uuidString];
            [_models addObject:pokemon];
        }
    }
    return _models;
}

+ (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
