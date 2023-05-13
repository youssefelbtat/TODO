//
//  ToDoScreen.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <UIKit/UIKit.h>

#import "MyProtocol.h"
@interface ToDoScreen : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol,UISearchBarDelegate>

{
    @public
    NSMutableArray * TodoTasksArray;

    
}

@end


