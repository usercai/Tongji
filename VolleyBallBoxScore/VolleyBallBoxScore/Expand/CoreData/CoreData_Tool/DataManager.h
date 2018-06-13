//
//  DataManager.h
//  VolleyballVoice
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 thc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (readonly ,nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly ,nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly ,nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(DataManager*)shareIntance;

- (NSURL *)applicationDocumentsDirectory;

- (void)saveContext;
@end
