//
//  GitRefViewController.m
//  GitReference
//
//  Created by Justin Smith on 7/6/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "GitRefViewController.h"

static const CGFloat defaultHeight = 20.0;
static const CGFloat heightOfCommandLabel = 25.0;
static const CGFloat theMargin = 15.0;
static const CGFloat topFromNavigationControl = 20.0;

@interface GitRefViewController ()

@end

@implementation GitRefViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GitReference";
    
    UIScrollView *gitScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(theMargin, 10, self.view.frame.size.width - theMargin * 2, self.view.frame.size.height)];
    [self.view addSubview:gitScrollView];
    
    CGFloat labelHeight = defaultHeight;
    
    for (NSDictionary *keywords in self.gitCommands)
    {
        NSString *theCommand = keywords[Command];
        NSString *theRef = keywords[Reference];
        
        UILabel *command = [[UILabel alloc] initWithFrame:CGRectMake(theMargin, labelHeight, self.view.frame.size.width - theMargin, heightOfCommandLabel)];
        command.font = [UIFont boldSystemFontOfSize:18];
        command.text = theCommand;
        [gitScrollView addSubview:command];
        
        labelHeight += (topFromNavigationControl + defaultHeight + theMargin);
        
        CGFloat refHeight = [self heightOfReferenceString:theRef];
        
        UILabel *ref = [[UILabel alloc] initWithFrame:CGRectMake(theMargin, labelHeight, self.view.frame.size.width - theMargin, refHeight)];
        ref.text = theRef;
        ref.numberOfLines = 0;
        [gitScrollView addSubview:ref];
        
        labelHeight += (refHeight + theMargin * 2);
        
    }
    
    gitScrollView.contentSize = CGSizeMake(self.view.frame.size.width, labelHeight);
    
}

static CGFloat margin = 15;
static NSString * const Command = @"command";
static NSString * const Reference = @"reference";


- (NSArray *)gitCommands {
    
    return @[@{Command: @"git status", Reference: @": shows changed files"},
             @{Command: @"git diff", Reference: @": shows actual changes"},
             @{Command: @"git add .", Reference: @": adds changed files to the commit"},
             @{Command: @"git commit -m \"notes\"", Reference: @": commits the changes"},
             @{Command: @"git push origin _branch_", Reference: @": pushes commits to branch named _branch_"},
             @{Command: @"git log", Reference: @": displays progress log"},
             @{Command: @"git comment --amend", Reference: @": re-enter last commit message"}
             ];
    
}

- (CGFloat)heightOfReferenceString:(NSString *)reference {
    
    CGRect bounding = [reference boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                              context:nil];
    
    return bounding.size.height;
    
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

@end
