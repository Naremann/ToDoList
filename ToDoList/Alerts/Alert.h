//
//  Alert.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Alert : UIViewController
+(void) showAlertDialogWithTitle :(NSString *)title andMsg : (NSString *)message  andHandler:(void (^) (UIAlertAction *))handler andViewController:(UIViewController *) viewController;
@end

NS_ASSUME_NONNULL_END
